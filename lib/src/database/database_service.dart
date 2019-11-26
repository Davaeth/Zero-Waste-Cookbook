import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseService {
  final _db = Firestore.instance;

  Future<void> createDatum(String collection, Map data) async {
    _db.collection(collection).add(data);
  }

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

  getDatumByID(String collection, String id) async {
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

  Stream<QuerySnapshot> getNewestRecipes() => _db
      .collection('Recipes')
      .orderBy('creationTime', descending: true)
      .limit(5)
      .getDocuments()
      .asStream();

  Stream<QuerySnapshot> getRecipeReviews(String id) {
    DocumentReference ref = _db.collection('Recipes').document(id);

    return _db
        .collection('Reviews')
        .where('recipe', isEqualTo: ref)
        .getDocuments()
        .asStream();
  }

  Stream<QuerySnapshot> getSearchedRecipes(List<String> ingredientsId) {
    List<DocumentReference> ingredientsReferences =
        getDocumentsReferences('Ingredients', ingredientsId);

    var list;

    _db
        .collection('RecipeMeasures')
        .where('idIngredients', arrayContains: ingredientsReferences)
        .getDocuments()
        .then((values) {
      print(values.documents);
      list = values.documents;
    });

    print(list);

    return null;
  }

  // List<Recipe> getUserFavRecipes(String id) {
  //   var favRecipesID =
  //       _db.collection('FavouriteRecipes').where('idUser', isEqualTo: id);

  //   List<String> recipesID = List<String>();

  //   favRecipesID.getDocuments().then((value) {
  //     recipesID = value.documents[0].data['idRecipes'];
  //   });

  //   List<Recipe> recipes = List<Recipe>();

  //   for (var recipeID in recipesID) {
  //     _db.collection('Recipes').document(recipeID).get().then((value) {
  //       recipes.add(Recipe.fromFirestore(getDatumByID('Recipes', id)));
  //     });
  //   }

  //   return recipes;
  // }

  // getUserRecipes(String id) {
  //   User user = User.fromFirestore(getDatumByID('Users', id));

  //   List<Recipe> recipes = List<Recipe>();

  //   for (var recipeId in user.recipes) {
  //     recipes.add(Recipe.fromFirestore(getDatumByID('Recipes', recipeId)));
  //   }

  //   return recipes;
  // }

  streamCollection(String collection, String id) =>
      _db.collection(collection).document(id).snapshots().map((snap) => snap);

  streamCollections(String collection, String field, String expectedField) =>
      _db
          .collection(collection)
          .where(field, isEqualTo: expectedField)
          .snapshots()
          .map((snap) => snap.documents);
}
