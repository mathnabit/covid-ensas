import 'package:covidensa/core/consts.dart';
import 'package:covidensa/pages/etat_poinfecte.dart';
import 'package:covidensa/pages/quiz_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'etat_infecte.dart';
import 'etat_normal.dart';

class EtaPage extends StatefulWidget {
  @override
  _EtaPageState  createState() => _EtaPageState();
}


class _EtaPageState extends State<EtaPage> {

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: AppBar(
        title: new Text("Definir Ton Etat",),
        elevation: defaultTargetPlatform==TargetPlatform.android?5.0:0.0,
      ),
      body: Container(
          child: Column(

            children: <Widget>[
              Text("\n \n  Veuillez stp choisir l'une de ces etats !!!\n ",
                  style: TextStyle(fontSize: 30 ,color: Colors.deepPurpleAccent,fontWeight: FontWeight.bold),textAlign: TextAlign.center),

              SizedBox(height: 25),
              GestureDetector(
                onTap:(){
                  Navigator.of(context).push(MaterialPageRoute(builder:(_) => Eta1Page(), ),);
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
                        child:Text("Etat Normal",
                          style:TextStyle(
                              color: AppColors.mainColor,
                              fontWeight: FontWeight.bold,
                              fontSize: 20) ,))
                ),),SizedBox(height: 25),
              GestureDetector(
                onTap:(){
                  Navigator.of(context).push(MaterialPageRoute(builder:(_) => Eta2Page(), ),);
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
                        child:Text("Possible Etre Infecté",
                          style:TextStyle(
                              color: AppColors.mainColor,
                              fontWeight: FontWeight.bold,
                              fontSize: 20) ,))
                ),),SizedBox(height: 25),GestureDetector(
                onTap:(){
                  Navigator.of(context).push(MaterialPageRoute(builder:(_) => Eta3Page(), ),);
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
                        child:Text("Infecté",
                          style:TextStyle(
                              color: AppColors.mainColor,
                              fontWeight: FontWeight.bold,
                              fontSize: 20) ,))
                ),),],
          )
      ),
    );}}