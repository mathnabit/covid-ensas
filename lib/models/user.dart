

class User {
  User({this.uid});
 void setuser(String nom,String prenom,String etat,String adresse){
   this.nom=nom;
   this.prenom=prenom;
   this.adresse=adresse;
   this.etat=etat;
  

 }


final String uid;
  String nom;
  String prenom;
  String adresse;
  String etat;
int score;
String tel;

Future <  void  > setnom(String value){
  this.nom=value;
}
}