import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:zero_waste_cookbook/src/database/database_service.dart';
import 'package:zero_waste_cookbook/src/models/administration/user.dart';

String email;
final GoogleSignIn googleSignIn = GoogleSignIn();

String currentUserName;
String currentUserId;
String currentUserIamgeUrl;

final FirebaseAuth _auth = FirebaseAuth.instance;

Future<String> get signInWithGoogle async {
  final GoogleSignInAccount googleSignInAccount = await googleSignIn.signIn();
  final GoogleSignInAuthentication googleSignInAuthentication =
      await googleSignInAccount.authentication;

  final AuthCredential credential = GoogleAuthProvider.getCredential(
    accessToken: googleSignInAuthentication.accessToken,
    idToken: googleSignInAuthentication.idToken,
  );

  final AuthResult authResult = await _auth.signInWithCredential(credential);
  final FirebaseUser user = authResult.user;

  assert(!user.isAnonymous);
  assert(await user.getIdToken() != null);

  final FirebaseUser currentUser = await _auth.currentUser();
  assert(user.uid == currentUser.uid);

  assert(user.email != null);
  assert(user.displayName != null);
  assert(user.photoUrl != null);

  currentUserName = user.displayName;
  email = user.email;
  currentUserIamgeUrl = user.photoUrl;
  currentUserId = user.uid;
 
  return 'signInWithGoogle succeeded: $user';
}

Future<void> signOutGoogle() async {
  await googleSignIn.signOut();
}
