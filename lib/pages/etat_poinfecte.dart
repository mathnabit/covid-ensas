import 'package:carousel_pro/carousel_pro.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class Eta2Page extends StatefulWidget {
  @override
  _Eta2PageState  createState() => _Eta2PageState();
}


class _Eta2PageState extends State<Eta2Page> {

  @override
  Widget build(BuildContext context) {
    Widget imageSliderCarousel= Container(
      height: 300,
      child: Carousel(
        boxFit: BoxFit.fill,
        images:[
          AssetImage("assets/images/mo.jpg"),
          AssetImage("assets/images/mo1.jpg"),
          AssetImage("assets/images/co1.jpg"),
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
          'Etat ensuivi',
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
          Text("\n - Evitez tous  contact rapproche avec toute personne presentant les symptomes d'un rhume ou de la grippe \n ",
              style: TextStyle(fontSize: 20,color: Colors.deepPurpleAccent,fontWeight: FontWeight.bold),textAlign: TextAlign.center),

          Text("\n - Couvrez-vous la bouche et le nez vous toussez ou eternuez dans le pil de votre coude\n ",
              style: TextStyle(fontSize: 20,color: Colors.deepPurpleAccent,fontWeight: FontWeight.bold),textAlign: TextAlign.center),

          Text("\n - utilisez un mouchoir  à usage unique et jetez-le \n ",
              style: TextStyle(fontSize: 20,color: Colors.deepPurpleAccent,fontWeight: FontWeight.bold),textAlign: TextAlign.center),

        ],
      )
      ,
    );}}