import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:zero_waste_cookbook/src/models/administration/user.dart';
import 'package:zero_waste_cookbook/src/models/food/recipe.dart';
import 'package:zero_waste_cookbook/ui/login/google_login.dart';

class DatabaseService {
  final _db = Firestore.instance;

  Future<bool> addNewUserToDatabase() async {
    final exists = await checkIfExists('Users', currentUserId);

    if (!exists) {
      var account = Map<String, String>();

      account.addEntries(
        [
          MapEntry('username', currentUserName),
          MapEntry('avaterUrl', currentUserIamgeUrl)
        ],
      );

      _db.collection('Users').document(currentUserId).setData(
            User(
              id: currentUserId,
              account: account,
              createTime: Timestamp.fromDate(DateTime.now()),
              deleted: false,
              role: null,
            ).toJson(),
          );
    }

    return true;
  }

  Future<void> addRecipeToFavourites(String recipeId, String userId) async {
    var recipeRef = getDocumentReference('Recipes', recipeId);

    await _db.collection('Users').document(userId).updateData(
      {
        'favouriteRecipes': FieldValue.arrayUnion([recipeRef])
      },
    );
  }

  Future<bool> checkIfExists(String collection, String id) async => await _db
      .collection(collection)
      .document(id)
      .get()
      .then((value) => value.exists);

  Future<bool> checkIfRecipeIsFaved(String userId, String recipeId) async {
    var user = User.fromFirestore(await getDatumByID('Users', userId));
    var recipesRef = getDocumentReference('Recipes', recipeId);

    return user.favouriteRecipes.contains(recipesRef);
  }

  Future<bool> checkIfUserIsAReviewCreator(
      String userId, String reviewId) async {
    var userRef = getDocumentReference('Users', userId);

    return await _db
        .collection('Reviews')
        .document(reviewId)
        .get()
        .then((value) => value.data['user'] == userRef);
  }

  Future<void> createDatum(String collection, Map data) async {
    _db.collection(collection).add(data);
  }

  Future<void> deleteDataByRelation(String collection, String field,
      String refColletion, String refId) async {
    var reference = getDocumentReference(refColletion, refId);

    var tags = await _db
        .collection(collection)
        .where(field, isEqualTo: reference)
        .getDocuments()
        .then((value) => value.documents);

    for (var tag in tags) {
      await _db.collection(collection).document(tag.documentID).delete();
    }
  }

  Future<void> deleteDatum(String collection, String id) async {
    _db.collection(collection).document(id).delete();
  }

  Future<void> deleteRelatedData(String collection, String id,
      String fieldToModify, String relatedCollection, String relatedId) async {
    var reference = getDocumentReference(relatedCollection, relatedId);

    await _db.collection(collection).document(id).updateData({
      fieldToModify: FieldValue.arrayRemove([reference])
    });
  }

  Future<QuerySnapshot> getAllData(String collection) async =>
      await _db.collection(collection).getDocuments();

  Future<List<DocumentSnapshot>> getDataByField(
          String collection, String field, dynamic expectedField) async =>
      await _db
          .collection(collection)
          .where(field, isEqualTo: expectedField)
          .getDocuments()
          .then((snaphshot) => snaphshot.documents);

  Future<DocumentSnapshot> getDatumByField(
          String collection, String field, dynamic expectedField) async =>
      await _db
          .collection(collection)
          .where(field, isEqualTo: expectedField)
          .getDocuments()
          .then((snaphshot) => snaphshot.documents.single);

  Future<DocumentSnapshot> getDatumByID(String collection, String id) async =>
      await _db
          .collection(collection)
          .document(id)
          .get()
          .then((snapshot) => snapshot);

  DocumentReference getDocumentReference(String collection, String id) =>
      _db.collection(collection).document(id);

  Iterable<DocumentReference> getDocumentsReferences(
      String collection, List<String> references) sync* {
    for (var reference in references) {
      yield getDocumentReference(collection, reference);
    }
  }

  Future<QuerySnapshot> getNewestRecipes({int limit = 5}) => _db
      .collection('Recipes')
      .orderBy('creationTime', descending: true)
      .limit(limit)
      .getDocuments();

  Future<List<DocumentSnapshot>> getRecipeIngredients(
      List<DocumentReference> ids) async {
    List<DocumentSnapshot> snapshots = List<DocumentSnapshot>();

    for (var i = 0; i < ids.length; i++) {
      snapshots
          .add(await _db.document(ids[i].path).get().then((value) => value));
    }

    return snapshots;
  }

  Stream<QuerySnapshot> getRecipeReviews(String id) {
    DocumentReference ref = _db.collection('Recipes').document(id);

    return _db
        .collection('Reviews')
        .where('recipe', isEqualTo: ref)
        .getDocuments()
        .asStream();
  }

  Future<List<Recipe>> getRecipesByIngredients(
      List<String> ingredientsIds) async {
    var ingredientsRefs =
        getDocumentsReferences('Ingredients', ingredientsIds).toList();

    var recipesSnapshots = await getAllData('Recipes');

    List<Recipe> recipes = List<Recipe>();

    for (var recipeSnapshot in recipesSnapshots.documents) {
      var recipe = Recipe.fromFirestore(recipeSnapshot);

      if (recipe.ingredients.length > ingredientsRefs.length) {
        continue;
      }

      bool hasRecipeMoreThanGivenIngredients = recipe.ingredients
          .every((ingredient) => ingredientsRefs.contains(ingredient));

      bool hasRefsMoreThanRecipeIngredients = ingredientsRefs
          .any((ingredient) => recipe.ingredients.contains(ingredient));

      if (hasRecipeMoreThanGivenIngredients &&
          hasRefsMoreThanRecipeIngredients) {
        recipes.add(recipe);
      }
    }

    return recipes;
  }

  Future<List<Recipe>> getRecipesByRegions(List<String> regionsIds) async {
    var recipesSnapshots = await getAllData('Recipes');

    List<Recipe> recipes = List<Recipe>();

    for (var recipeSnapshot in recipesSnapshots.documents) {
      var recipe = Recipe.fromFirestore(recipeSnapshot);

      for (var regionId in regionsIds) {
        if (recipe.dishRegions.documentID == regionId) {
          recipes.add(recipe);
        }
      }
    }

    return recipes;
  }

  Future<QuerySnapshot> getRecipeTags(String recipeId) {
    DocumentReference ref = _db.collection('Recipes').document(recipeId);

    return _db
        .collection('Tags')
        .where('recipe', isEqualTo: ref)
        .getDocuments();
  }

  Stream<List<DocumentSnapshot>> getUserFavouriteRecipes(String userId) async* {
    var user = User.fromFirestore(await getDatumByID('Users', userId));

    var favRecipes = List<DocumentSnapshot>();

    for (var recipe in user.favouriteRecipes) {
      favRecipes
          .add(await _db.document(recipe.path).get().then((value) => value));
    }

    yield favRecipes;
  }

  Future<QuerySnapshot> getUserRecipes(String id) async {
    DocumentReference userRef = getDocumentReference('Users', id);

    return await _db
        .collection('Recipes')
        .where('user', isEqualTo: userRef)
        .getDocuments();
  }

  Future<void> removeRecipeFromFavourites(
      String recipeId, String userId) async {
    var recipeRef = getDocumentReference('Recipes', recipeId);

    await _db.collection('Users').document(userId).updateData(
      {
        'favouriteRecipes': FieldValue.arrayRemove([recipeRef])
      },
    );
  }

  Stream<QuerySnapshot> streamAllData(String collection) async* {
    yield await _db
        .collection(collection)
        .orderBy('name', descending: false)
        .getDocuments();
  }

  streamCollection(String collection, String id) =>
      _db.collection(collection).document(id).snapshots().map((snap) => snap);

  streamCollections(String collection, String field, String expectedField) =>
      _db
          .collection(collection)
          .where(field, isEqualTo: expectedField)
          .snapshots()
          .map((snap) => snap.documents);

  Stream<QuerySnapshot> streamNewestRecipes({int limit = 5}) async* {
    yield await _db
        .collection('Recipes')
        .orderBy('creationTime', descending: true)
        .limit(limit)
        .getDocuments();
  }

  Future<void> updateRecipeRank(String recipeId) async {
    var recipeRef = getDocumentReference('Recipes', recipeId);
    var reviews = (await getDataByField('Reviews', 'recipe', recipeRef));

    double newRank = 0.0;

    for (var review in reviews) {
      newRank += review.data['rate'];
    }

    _db.collection('Recipes').document(recipeId).updateData(
      {
        'rank': double.parse((newRank / reviews.length).toStringAsFixed(2)),
      },
    );
  }
}
