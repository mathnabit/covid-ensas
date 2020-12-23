import 'package:carousel_pro/carousel_pro.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class Eta1Page extends StatefulWidget {
  @override
  _Eta1PageState  createState() => _Eta1PageState();
}


class _Eta1PageState extends State<Eta1Page> {

  @override
  Widget build(BuildContext context) {
    Widget imageSliderCarousel= Container(
      height: 300,
      child: Carousel(
        boxFit: BoxFit.fill,
        images:[
          AssetImage("assets/images/di.jpg"),
          AssetImage("assets/images/lave.jpg"),
          AssetImage("assets/images/masques.jpeg"),
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
          'Etat normal',
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
          Text("\n - La distance de securite de 1 metre est la distance limite \n ",
              style: TextStyle(fontSize: 20,color: Colors.deepPurpleAccent,fontWeight: FontWeight.bold),textAlign: TextAlign.center),

          Text("\n - Lavez- vous vos mains frequemment avec du l'eau et du savon\n ",
              style: TextStyle(fontSize: 20,color: Colors.deepPurpleAccent,fontWeight: FontWeight.bold),textAlign: TextAlign.center),

          Text("\n - Faire des masques  lors de vos sorties \n ",
              style: TextStyle(fontSize: 20,color: Colors.deepPurpleAccent,fontWeight: FontWeight.bold),textAlign: TextAlign.center),

        ],
      )
      ,
    );}}