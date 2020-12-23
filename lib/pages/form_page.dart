
import 'package:covidensa/pages/quest_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:flutter/painting.dart';
import 'package:covidensa/core/consts.dart';

import 'home_page.dart';
import 'package:covidensa/services/auth.dart';


class FormPage extends StatefulWidget {
  @override
  _FormPageState  createState() => _FormPageState();
}


class _FormPageState extends State<FormPage> {

  //objet authService
  final AuthService _auth = AuthService();
  //pour validation
  final _formKey = GlobalKey<FormState>();
  //inputs state
  String email = '';
  String password = '';
  String error = '';
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomPadding:true,

        body: Container(
        width: double.infinity,
        decoration: BoxDecoration(
        gradient: LinearGradient(
        begin: Alignment.topCenter,
        colors: [
          AppColors.mainColor,
          AppColors.mainColor.withOpacity(.5),
        ]
    )
    ),
    child:Form(
      key: _formKey,
      child:Column(
           crossAxisAlignment: CrossAxisAlignment.start,
children: <Widget>[
  SizedBox(height: 60,),
  Padding(
    padding: EdgeInsets.all(20),
    child: Column(
      children: <Widget>[
        Text("Login",style: TextStyle(color: Colors.white,fontWeight:FontWeight.bold,fontSize: 40),),
        SizedBox(height: 10,),
        Text("Welcome back",style: TextStyle(color: Colors.white,fontSize: 20),)

      ],
    ),
    
  ),
  SizedBox(height: 20,),
  Expanded(
    child: Container(
      decoration: BoxDecoration(
      color: Colors.white,
        borderRadius: BorderRadius.only(topLeft: Radius.circular(60),topRight: Radius.circular(60))
      ),
      child: Padding(
        padding: EdgeInsets.all(30),
        child: Column(
          children: <Widget>[
            SizedBox(height: 60,),
            Container(
              padding:EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                boxShadow: [BoxShadow(
                  color: AppColors.mainColor,
                      blurRadius: 20,
                  offset: Offset(0,10),
                )]
              ),
              child: Column(
                children: <Widget>[
                  Container(
                    padding:EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      border:Border(bottom: BorderSide(color: Colors.grey[200]))
                    ),
                    child: TextFormField(
                      decoration: InputDecoration(
                        hintText: "Email or  cin",
                        hintStyle: TextStyle(color: Colors.grey),
                        border:InputBorder.none,
                      ),
                      validator: (val)=> val.isEmpty ? 'champs vide' : null ,
                      onChanged: (val) {
                        setState(() => email = val);
                      },
                    ),
                  ),
                  Container(
                    padding:EdgeInsets.all(10),
                    decoration: BoxDecoration(
                        border:Border(bottom: BorderSide(color: Colors.grey[200]))
                    ),
                    child: TextFormField(
                      obscureText: true,
                      decoration: InputDecoration(
                        hintText: "Password",
                        hintStyle: TextStyle(color: Colors.grey),
                        border:InputBorder.none,
                        
                      ),
                      validator: (val)=> val.length<3 ? 'passe très court' : null ,
                      onChanged: (val) {
                        setState(() => password = val);
                      },
                    ),
                  )
                ],
              ),
            ),
            SizedBox(height: 20,),
            Text("Forgot Password" ,style: TextStyle(color: Colors.grey),),
            //affichage de l'erreur
            Text(error,style: TextStyle(color: Colors.red,fontSize: 16.0),),
            SizedBox(height: 40,),
        GestureDetector(
          onTap:() async {
            
            if(_formKey.currentState.validate()){
                  
                  dynamic result = await _auth.login(email, password);
                  if(result == null) {
                    setState(() => error = 'user non existe !!');
                    print('error :'+error);
                  } else if (result != null)
                   {Navigator.of(context).push(MaterialPageRoute(builder:(_) => QuestPage(), ),); }
                }
          } , 
          
           child: Container(
              height: 50,
              margin: EdgeInsets.symmetric(horizontal: 50),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(50),
                color: Colors.deepPurple,

              ),
              child: Center(
                child: Text("Login",style: TextStyle(color: Colors.white,fontSize: 16,fontWeight: FontWeight.bold),),

              ),
              
              ),

        ),],
        ),
      ),
    
    ),
  )
],


            ),
              )




        ),
     );
  }
}


