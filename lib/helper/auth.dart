import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shadow_space/helper/firestore.dart';
import 'package:shadow_space/helper/user_service.dart';

class Auth {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final GoogleSignIn googleSignIn = GoogleSignIn();

  User? get currentUser => _firebaseAuth.currentUser;

  Stream<User?> get authStateChanges => _firebaseAuth.authStateChanges();

  Future<void> signInWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    await _firebaseAuth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
  }

  Future<void> createUserWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    await _firebaseAuth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );
  }

  Future<void> signOut() async {
    final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
    await _firebaseAuth.signOut();
  }

  Future<void> signOutGoogle() async {
    final GoogleSignIn _googleSignIn = GoogleSignIn();

    if (await _googleSignIn.isSignedIn()) {
      await _googleSignIn.signOut();
    }
  }

  Future<UserCredential> signInWithGoogle() async {
    final FirestoreAddUser firestoreGoogleUser = FirestoreAddUser();
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    final GoogleSignInAuthentication? googleAuth =
        await googleUser?.authentication;

    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );

    final UserCredential userCredential =
        await FirebaseAuth.instance.signInWithCredential(credential);
    final User? user = userCredential.user;

    if (user != null) {
      UserService.loggedUser!.email = user.email ?? '';
      UserService.loggedUser!.username = user.displayName ?? '';
      UserService.loggedUser!.userId = user.uid;

      final bool checkUser = await firestoreGoogleUser.checkUser(user.uid);

      if(!checkUser){
        firestoreGoogleUser.addUsers(UserService.loggedUser!.username,
            UserService.loggedUser!.email, UserService.loggedUser!.userId);
      }
    } else {
      return Future.error('Error');
    }

    return await FirebaseAuth.instance.signInWithCredential(credential);
  }
}
