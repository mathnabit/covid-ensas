import 'package:covidensa/services/database.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:covidensa/models/user.dart';


class AuthService {

static FirebaseUser current;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final DatabaseService _dbs = DatabaseService();
  static DatabaseService authentifi ;
  static String idauth;

  //creation d'un user de type User a partir du user firebase
  User _userFromFirebaseUser(FirebaseUser user){
    current=user;
      return user != null ? User(uid: user.uid) : null;
  }

  //stream pour ecouter les changements au niveau stateUser
  Stream<User> get user {
    return _auth.onAuthStateChanged
      .map(_userFromFirebaseUser);
  }
  //sign up avec un email et pass
  Future register(String email, String password) async {
    try {
      AuthResult result = await _auth.createUserWithEmailAndPassword(email: email, password: password);
      FirebaseUser user = result.user;
      //association d'un document pour user qui vient d'inscrire
      authentifi=DatabaseService(uid: user.uid);
      await DatabaseService(uid: user.uid).updateUser('xxxx', 'xxxx', 'xxxx', 'xxxxxx', 0,'xxxxxx','xxxxxx',email);
      idauth=user.uid;
      return _userFromFirebaseUser(user);
    } catch(e) {
      print(e.toString());
      return null;
    }
  }

  //sign in avec un email et pass
  Future login(String email, String password) async {
    try {
      AuthResult result = await _auth.signInWithEmailAndPassword(email: email, password: password);
      
      FirebaseUser user = result.user;
      User userr = _userFromFirebaseUser(user);
      await _dbs.updateToken(userr);

      return userr;

    } catch(e) {
      print('erroro :' +e.toString());
      return null;
    }
  }

  //sign out
  Future signOut() async {
    try {
      return await _auth.signOut();
    } catch(e) {
      print(e.toString());
      return null;
    }
  }
}