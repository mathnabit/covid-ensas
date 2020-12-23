import 'dart:ffi';
import 'dart:ui';

import 'package:provider/provider.dart';
import 'package:covidensa/core/consts.dart';
import 'package:covidensa/pages/home_page.dart';
import 'package:covidensa/pages/local_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:covidensa/models/user.dart';
import 'package:covidensa/services/auth.dart';


class IntroPage extends StatefulWidget{
  @override
  _IntroPageState createState() =>  _IntroPageState();


}

class _IntroPageState  extends State<IntroPage>{
  @override
  Widget build(BuildContext context) {
    //final user = Provider.of<User>(context);

   return Scaffold(
     body: Container(
       width: MediaQuery.of(context).size.width,
       height: MediaQuery.of(context).size.height,
       decoration: BoxDecoration(
         gradient: LinearGradient(colors:
         [
           AppColors.mainColor,
           AppColors.mainColor.withOpacity(.5),
         ])
       ),
       child: Stack(
         children: <Widget>[
           _buildHeader(),
           Align(
             alignment:Alignment.center,
          child: Container(
               width: MediaQuery.of(context).size.width * .7,
           child:Center(
             child: Image.asset("assets/images/virus.png"),
           ),
           ),
           ),
           Positioned(
             top: MediaQuery.of(context).size.height * .22,
            right: 8,
            child: Container(
             width: MediaQuery.of(context).size.width * .4,
          child: Image.asset("assets/images/person.png")),),
           _buildFooter(context)
           ],
       ),
     ),
   );
  }
}
Padding _buildHeader(){
 return Padding(
padding:const EdgeInsets.only(top:20),
child:Align(
alignment: Alignment.topCenter,
child: Image.asset("assets/images/logo.png"),
),
);
}
Widget _buildFooter(BuildContext context){

//final user = Provider.of<User>(context);

return Positioned(bottom: 50,
child:Container(
width: MediaQuery.of(context).size.width,
child:Column(
crossAxisAlignment:CrossAxisAlignment.center,
children: <Widget>[
Text("Coronavirus à Safi (COVID-19)",
style: TextStyle(fontSize: 25,color: Colors.white,fontWeight: FontWeight.bold)),
Text(" est une maladie infectieuse utilisée par un nouveau virus",
style: TextStyle(fontSize: 20,height:1.5,color: Colors.white),
textAlign: TextAlign.center),
SizedBox(height: 25),
GestureDetector(
  onTap:(){
    //if (user == null)
      Navigator.of(context).push(MaterialPageRoute(builder:(_) => HomePage(), ),);
   /* else
      Navigator.of(context).push(MaterialPageRoute(builder:(_) => LocalPage(), ),);*/
    
  } ,

child:Container(
decoration: BoxDecoration(
color: Colors.white,
borderRadius: BorderRadius.all(
Radius.circular(20)),
boxShadow: [
BoxShadow(
color: Colors.black26,
offset: Offset(1, 1),
spreadRadius: 3,
blurRadius: 3,
)
]
),
width: MediaQuery.of(context).size.width * .85,
height: 60,
child:Center(
child:Text("GET STARTED",
style:TextStyle(
color: AppColors.mainColor,
fontWeight: FontWeight.bold,
fontSize: 20) ,))
),),],
)
),);
}