import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:zero_waste_cookbook/src/models/administration/user.dart';

class DatabaseService {
  final _db = Firestore.instance;

  Future<void> addRecipeToFavourites(String recipeId, String userId) async {
    var recipeRef = getDocumentReference('Recipes', 'SOWUsKMR4vmK6e4FgoRZ');

    await _db.collection('Users').document(userId).updateData(
      {
        'favouriteRecipes': FieldValue.arrayUnion([recipeRef])
      },
    );
  }

  Future<void> createDatum(String collection, Map data) async {
    _db.collection(collection).add(data);
  }

  Stream<QuerySnapshot> getAllData(String collection) =>
      _db.collection(collection).getDocuments().asStream();

  getDataByField(String collection, String field, String expectedField) async {
    List<DocumentSnapshot> value;

    await _db
        .collection(collection)
        .where(field, isEqualTo: expectedField)
        .getDocuments()
        .then((snaphshot) {
      value = snaphshot.documents;
    });

    return value;
  }

  getDatumByField(String collection, String field, String expectedField) async {
    DocumentSnapshot value;

    await _db
        .collection(collection)
        .where(field, isEqualTo: expectedField)
        .getDocuments()
        .then((snaphshot) {
      value = snaphshot.documents[0];
    });

    return value;
  }

  Future<DocumentSnapshot> getDatumByID(String collection, String id) async {
    DocumentSnapshot value;

    await _db.collection(collection).document(id).get().then((snapshot) {
      value = snapshot;
    });

    return value;
  }

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

  Future<QuerySnapshot> getRecipeTags(String recipeId) {
    DocumentReference ref = _db.collection('Recipes').document(recipeId);

    return _db
        .collection('Tags')
        .where('recipe', isEqualTo: ref)
        .getDocuments();
  }

  Future<List<DocumentSnapshot>> getUserFavouriteRecipes(String userId) async {
    var userSnapshot =
        await getDatumByID('Users', userId).then((value) => value);

    var user = User.fromFirestore(userSnapshot);

    var favRecipes = List<DocumentSnapshot>();

    for (var recipe in user.recipes) {
      favRecipes
          .add(await _db.document(recipe.path).get().then((value) => value));
    }

    return favRecipes;
  }

  // Future<List<Recipe>> getRecipesByIngredients(
  //     List<String> ingredientsId) async {
  //   List<DocumentReference> ingredients = List<DocumentReference>();
  //   List<Recipe> recipes = List<Recipe>();

  //   List<Recipe> result = List<Recipe>();

  //   ingredients = getDocumentsReferences('Ingredients', ingredientsId).toList();

  //   var recipesSnapshots = await _db
  //       .collection('Recipes')
  //       .getDocuments()
  //       .then((value) => value.documents);

  //   for (var snapshot in recipesSnapshots) {
  //     recipes.add(Recipe.fromFirestore(snapshot));
  //   }

  //   for (var recipe in recipes) {
  //     if (recipe.ingredients == ingredients) {
  //       result.add(recipe);
  //     } else {
  //       for (var ingredient in ingredients) {
  //         if (recipe.ingredients. && recipe) {

  //         }
  //       }
  //     }
  //   }

  //   // _db
  // }

  // Stream<QuerySnapshot> getSearchedRecipes(List<String> ingredientsId) {
  //   List<DocumentReference> ingredientsReferences =
  //       getDocumentsReferences('Ingredients', ingredientsId);

  //   var list;

  //   _db
  //       .collection('RecipeMeasures')
  //       .where('idIngredients', arrayContains: ingredientsReferences)
  //       .getDocuments()
  //       .then((values) {
  //     print(values.documents);
  //     list = values.documents;
  //   });

  //   print(list);

  //   return null;
  // }

  Stream<QuerySnapshot> getUserRecipes(String id) {
    DocumentReference userRef = getDocumentReference('Users', id);

    return _db
        .collection('Recipes')
        .where('user', isEqualTo: userRef)
        .getDocuments()
        .asStream();
  }

  streamCollection(String collection, String id) =>
      _db.collection(collection).document(id).snapshots().map((snap) => snap);

  streamCollections(String collection, String field, String expectedField) =>
      _db
          .collection(collection)
          .where(field, isEqualTo: expectedField)
          .snapshots()
          .map((snap) => snap.documents);

  Stream<QuerySnapshot> streamNewestRecipes({int limit = 5}) => _db
      .collection('Recipes')
      .orderBy('creationTime', descending: true)
      .limit(limit)
      .getDocuments()
      .asStream();
}
