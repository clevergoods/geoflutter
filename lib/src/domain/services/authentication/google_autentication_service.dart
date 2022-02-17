import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart';

class GoogleAuthenticationService{
  Future<Map<String, dynamic>?> logIn(Function() completion) async {
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
    if (googleUser == null) {
      await isLogIn(() => null);
      return null;
    }

    final GoogleSignInAuthentication googleAuth =
        await googleUser.authentication;

    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    final userCredential =
        await FirebaseAuth.instance.signInWithCredential(credential);
    //ToDo: send  userCredential to the WL server and get auth token
    await isLogIn(() => Null);
    var json = <String, String>{
      'login': "google_"+googleUser.id.toString(),
      'email': googleUser.email.toString(),
      'name' : googleUser.displayName.toString(),
      'photo' : googleUser.photoUrl.toString(),
      'Id': googleUser.id.toString(),
      'IdToken': googleAuth.idToken.toString(),
      'source': "google"
    };

    return json;
  }

  Future<void> logOut(Function() completion) async {
    await FirebaseAuth.instance.signOut();
    await GoogleSignIn().signOut();
  }

  Future<bool> isLogIn(Function() completion) async {
    return await GoogleSignIn().isSignedIn();
  }

  @override
  noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}
