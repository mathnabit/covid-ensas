import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:covidensa/models/user.dart';
import 'package:covidensa/models/zone.dart';
import 'package:covidensa/services/auth.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

class DatabaseService {
  final  Firestore  myDB = Firestore.instance; 
  final FirebaseMessaging _fcm = FirebaseMessaging();

 DatabaseService.authen(){

   this.uid=AuthService.idauth;

 }
  //Instance auth
  final FirebaseAuth _authent = FirebaseAuth.instance;
  //Instance database
   String uid;
  DatabaseService({this.uid});
  //recuperation de l'objet de la collection users
  final CollectionReference userCollection = Firestore.instance.collection('users');

  Future updateUser(String nom,String prenom,String etat,String adresse,int score,String zone, String token, String email) async {
    return await userCollection.document(uid).setData({
      'nom': nom,
      'prenom' : prenom,
      'etat' : etat,
      'adresse' : adresse,
      'score' : score,
      'zone' : zone,
      'token' : token,
      'email' : email
      });
  }

  /*-------Update token------- */ 
  Future<void> updateToken(User user) async {

    await myDB.collection("users").document(user.uid).updateData({
        'token' : await _fcm.getToken(), 
    });
    
  }

  /*-------Get token------- */ 
  Future<String> getToken(String email) async {
    String token;
    final snapshot = await myDB.collection("users").where("email", isEqualTo: email).getDocuments();
    final docReff = snapshot.documents.first;
    token = docReff.data['token'];
    return token;
    
  }


  /*-------Etat user------- */    
 
  Future<String> tonEtat() async {

    final FirebaseUser user  = await _authent.currentUser();
    String etat='';
    final docRef = await myDB.collection("users").document(user.uid).get();
    etat = docRef.data['etat'];
    return etat;
  }
 /*-------get etat zones------- */ 
Future<List<Zone>> zoneEtat() async { 
  final docs = await myDB.collection('zones').getDocuments();
   return docs.documents.map((doc) {
        return Zone(
          uid: doc.documentID ?? '',
          nom: doc.data['nom'] ?? '',
          infectes: doc.data['infectes'] ?? '',
          morts: doc.data['morts'] ?? '',
          gueris: doc.data['gueris'] ?? '',
        );
   }).toList();
   
}



  //-------------------------Users

   //insertion
 
Future <  void  > addUser() async { 
  try{
    await myDB.collection ( "users" ) .add ({  
        'nom' : "ELhariri",  
        'prenom' :  "noura",  
    }) ;
        print("fait");  
   }        
    catch(e) {  
        print(e);  
    }
}  
//update 
Future < void > editUser( int score ) async {  
   try{
     FirebaseAuth a=FirebaseAuth.instance;
final FirebaseUser user  = await a.currentUser();
   
if (user == null) {
    // User is not signed in
}
   else{
     String etat="";
      if(score>5){
          etat="ensuivi";

        }
        else {
           etat="normal";

        }
      String d = user.uid;
    await myDB.collection("users").document(d).updateData({  
        'score': score,  
        'etat':etat,
        
        
    }); 
    } 
    }
    catch(e) {  
        print(e);  
    }  
}   
Future <  void  > addUserlier(String nom,String prenom,String adresse,String etat ) async { 
  try{
     FirebaseAuth a=FirebaseAuth.instance;
final FirebaseUser user  = await a.currentUser();
   
if (user == null) {
    // User is not signed in
}
   
      String d = user.uid;
    await myDB.collection("users").document(d).updateData({  
         
        'etat':etat,
        'nom':nom,
        'adresse':adresse,
        'prenom':prenom,
        
        
    }); 
    } 
    
    catch(e) {  
        print(e);  
    }  

}}