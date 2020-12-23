
import 'package:covidensa/services/database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:covidensa/pages/quest_page.dart';



class ForPage extends StatefulWidget{
  @override
  _ForPageState createState() =>  _ForPageState();
 

 
  


}

class _ForPageState  extends State<ForPage>{

  static var _keyValidationForm = GlobalKey<FormState>();
TextEditingController _textEditConName = TextEditingController();
TextEditingController _textEditConEmail = TextEditingController();
TextEditingController _textEditConPassword = TextEditingController();
TextEditingController _textEditConConfirmPassword = TextEditingController();
String etat;
bool isPasswordVisible = false;
bool isConfirmPasswordVisible = false;

@override
void initState() {
isPasswordVisible = false;
isConfirmPasswordVisible = false;
super.initState();
}

@override
Widget build(BuildContext context) {
return Scaffold(
   appBar: AppBar(
        leading: Icon(
          Icons.menu,
          color: Colors.white,
        ),
        centerTitle: true,
        title: Text(
          'Profil',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 22.0,
          ),
        ),
        backgroundColor: Colors.deepPurple[800],
      ),
  body: SingleChildScrollView(
    
    child: Padding(
        padding: EdgeInsets.only(top: 32.0),
        child: Column(
          children: <Widget>[
            getWidgetImageLogo(),
            getWidgetRegistrationCard(),
            SizedBox(height:  50),
            Image.asset(
              "assets/images/virus.png",
              height: 120,
            ),
          ],
        )),
  ),
);
}

Widget getWidgetImageLogo() {
return Container(
    alignment: Alignment.center,
    child: Padding(
      padding: const EdgeInsets.only(top: 32, bottom: 32),
      child: Icon(Icons.person_pin_circle,
                  size: 50,
      ),
    ));
 }

Widget getWidgetRegistrationCard() {
final FocusNode _passwordEmail = FocusNode();
final FocusNode _passwordFocus = FocusNode();
final FocusNode _passwordConfirmFocus = FocusNode();
String _selectedLocation = 'veuillez saisir votre etat';
List<String> _locations = ['malade', 'normal'];

return Padding(
  padding: const EdgeInsets.only(left: 16.0, right: 16.0),
  child: Card(
    color: Colors.deepPurpleAccent[100],
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(12.0),
    ),
    elevation: 10.0,
    child: Padding(
      padding: const EdgeInsets.all(16.0),
      child: Form(
        key: _keyValidationForm,
        child: Column(
          children: <Widget>[
            Container(
              alignment: Alignment.center,
              width: double.infinity,
              child: Text(
                'Enregistrer vos informations',
                style: TextStyle(
                    fontSize: 18.0,color: Colors.white),
              ),
            ), // title: login
            Container(
              child: TextFormField(
                controller: _textEditConName,
                keyboardType: TextInputType.text,
                textInputAction: TextInputAction.next,
               
                onFieldSubmitted: (String value) {
                  FocusScope.of(context).requestFocus(_passwordFocus);
                },
                decoration: InputDecoration(
                    labelText: 'nom',
                    //prefixIcon: Icon(Icons.email),
                    icon: Icon(Icons.perm_identity)),
              ),
            ), //text field : user name
            Container(
              child: TextFormField(
                controller: _textEditConEmail,
                keyboardType: TextInputType.text,
                textInputAction: TextInputAction.next,
               
                onFieldSubmitted: (String value) {
                  FocusScope.of(context).requestFocus(_passwordConfirmFocus);
                },
                decoration: InputDecoration(
                    labelText: 'prenom',
                    //prefixIcon: Icon(Icons.email),
                    icon: Icon(Icons.perm_identity)),
              ),
            ),
            //text field: email
            Container(
              child:TextFormField(
                controller: _textEditConPassword,
                keyboardType: TextInputType.text,
                textInputAction: TextInputAction.next,
               
                onFieldSubmitted: (String value) {
                  FocusScope.of(context).requestFocus(_passwordEmail);
                },
                decoration: InputDecoration(
                    labelText: 'adresse',
                    //prefixIcon: Icon(Icons.email),
                    icon: Icon(Icons.location_on)),
              ),
            ), //text field: password
           
        
            Container(
              child: 
 
DropdownButton<String>(
   
              
  items: <String>['infecte', 'normal'].map((String value) {
    return new DropdownMenuItem<String>(
      value: value,
      child: new Text(value),
    );
  }).toList(),
  onChanged: (String newValue) {
    setState(() {
      _selectedLocation = newValue;
      etat=newValue;
     });
},
),

            ),

            Container(
              margin: EdgeInsets.only(top: 32.0),
              width: double.infinity,
              child: RaisedButton(
             
                textColor: Colors.deepPurpleAccent,
                elevation: 5.0,
                padding: EdgeInsets.only(top: 16.0, bottom: 16.0),
                child: Text(
                  'Enregistrer vos Informaations',
                  style: TextStyle(fontSize: 16.0),
                ),
                onPressed: () {
                  if (_keyValidationForm.currentState.validate()) {
                    _onTappedButtonRegister();
                  }
                },
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25.0)),
              ),
            ), //button: login
           
                
          ],
        ),
      ),
    ),
  ),
);
}








void _onTappedButtonRegister() {
  DatabaseService db= new DatabaseService.authen();
db.addUserlier( _textEditConName.text, _textEditConEmail.text, _textEditConPassword.text, etat) ;
Navigator.of(context).push(MaterialPageRoute(builder:(_) => QuestPage(), ),);
}

}