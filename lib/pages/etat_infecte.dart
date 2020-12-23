
import 'package:carousel_pro/carousel_pro.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class Eta3Page extends StatefulWidget {
  @override
  _Eta3PageState  createState() => _Eta3PageState();
}


class _Eta3PageState extends State<Eta3Page> {

  @override
  Widget build(BuildContext context) {
    Widget imageSliderCarousel= Container(
      height: 300,
      child: Carousel(
        boxFit: BoxFit.fill,
        images:[
          AssetImage("assets/images/co4.jpg"),
          AssetImage("assets/images/co5.jpg"),
          AssetImage("assets/images/co2.jpg"),
        ] ,
      ),
    );
    return new Scaffold(
      appBar: AppBar(
        leading: Icon(
          Icons.menu,
          color: Colors.white,
        ),
        centerTitle: true,
        title: Text(
          'Etat infecté',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 22.0,
          ),
        ),
        backgroundColor: Colors.deepPurple[800],
      ),
      body:ListView(
        children: <Widget>[
          imageSliderCarousel,
          SizedBox(height: 2),
          Text("\n - Consultez le medecin ou bien appelez les urgences en cas de fievre , de toux ou de difficulte à respirer  \n Portez les masques pour ne pas diffuser la maladie par voie aerienne",
              style: TextStyle(fontSize: 20,color: Colors.deepPurpleAccent,fontWeight: FontWeight.bold),textAlign: TextAlign.center),


        ],
      )
      ,
    );}}