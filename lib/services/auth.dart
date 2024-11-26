import 'package:firebase_auth/firebase_auth.dart';

class Auth {
  final FirebaseAuth auth = FirebaseAuth.instance;
  Future signOutUser() async {
    await FirebaseAuth.instance.signOut();
  }

  Future deleteUser() async {
    User? user = await FirebaseAuth.instance.currentUser;
    user?.delete();
  }
}
