import 'package:covidensa/core/consts.dart';
import 'package:covidensa/core/flutter_icons.dart';
import 'package:covidensa/pages/sign_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';

import 'form_page.dart';
import 'formu_page.dart';
import 'intro_page.dart';



class HomePage extends StatefulWidget {
  @override
  _HomePageState  createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      body: Column(
        children: <Widget>[
          Container(
              decoration: BoxDecoration(
                  color: AppColors.mainColor,
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(25),
                    bottomRight: Radius.circular(25),
                  )
              ),
              padding: EdgeInsets.only(top: 15,bottom: 5),
              child: Stack(
                children: <Widget>[
                 Image.asset("assets/images/virus2.png"),
                    _buildHeader(),
                  
                ],
              )
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16),
                child:RichText(
                text: TextSpan(
                  text: "Symptoms de ",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                    color: Colors.black87,
                  ),
                  children:[
                    TextSpan(
                    text: "COVID 19",
                    style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                    color: AppColors.mainColor,
                    ),
                    ),
                  ],

                ),
                ),
                ),
                SizedBox(height: 25),
                Container(
                  height: 130,
                  child:ListView(
                    scrollDirection: Axis.horizontal,
    children: <Widget>[
      _buildSymptomItem("assets/images/1.png","Fever"),
      _buildSymptomItem("assets/images/2.png","Dry Cought"),
      _buildSymptomItem("assets/images/3.png","Headache"),
      _buildSymptomItem("assets/images/4.png","Breathless"),
    ],
                ),
                ),
                SizedBox(height: 10),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  child: Text("Prevention",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,color: Colors.black87,
                    ),
                ),),
                SizedBox(height: 20),
                Container(
                  height: 120,
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    padding: EdgeInsets.only(left: 20),
                    physics: BouncingScrollPhysics(),
                    children: <Widget>[
                      _buildPrevention(
                          "assets/images/a10.png", "WASH", "hands often"),
                      _buildPrevention("assets/images/a4.png", "COVER", "your cough"),
                     // _buildPrevention("assets/images/a6.png", "ALWAYS", "clean"),
                      _buildPrevention("assets/images/a9.png", "USE", "mask"),
                    ],
                  ),
                ),
              ],
            ),
          )

        ],
      ),
    );
  }
  Widget _buildPrevention(String path, String text1, String text2) {
    return Column(
      children: <Widget>[
        Container(
          width: 80,
          height: 80,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(
              Radius.circular(15),
            ),
            border: Border.all(color: Colors.white),
            boxShadow: [
              BoxShadow(
                color: Colors.black12,
                offset: Offset(1, 1),
                spreadRadius: 1,
                blurRadius: 1,
              ),
            ],
          ),
          padding: EdgeInsets.all(5),
          child: Row(
            children: <Widget>[
              Image.asset(path),

            ],
          ),
          margin: EdgeInsets.only(right: 25),
        ),
        SizedBox(height: 7),
      ],
    );
  }

  Widget _buildSymptomItem(String path, String text) {
    return Column(
      children: <Widget>[
        Container(
          width: 80,
          height: 80,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(
              Radius.circular(15),
            ),
            gradient: LinearGradient(
              colors: [
                AppColors.backgroundColor,
                Colors.white,
              ],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
            border: Border.all(color: Colors.white),
            boxShadow: [
              BoxShadow(
                color: Colors.black26,
                offset: Offset(1, 1),
                spreadRadius: 1,
                blurRadius: 3,
              )
            ],
          ),
          padding: EdgeInsets.only(top: 8),
          child: Image.asset(path),
          margin: EdgeInsets.only(right: 20),
        ),
        SizedBox(height: 7),
        Text(
          text,
          style: TextStyle(
            color: Colors.black87,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }


  Widget _buildHeader(){
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        _buildAppBar(),
        Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child:Text("COVID 19 en SAFI",style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 32,
            ),)
        ),



    SizedBox(height: 20,),
    Padding(
    padding: const EdgeInsets.symmetric(horizontal: 16),
    child:Text("Fonds de secours CoronaVirus",style: TextStyle(
    color: Colors.white,
    fontWeight: FontWeight.bold,
    ),)
    ),
    SizedBox(height: 20,),
    Padding(
    padding: const EdgeInsets.symmetric(horizontal: 16),
    child:Text("à ce fonds aidera à stopper la propagation du virus et \n à communiquer les lignes d'urgence'",style: TextStyle(
    color: Colors.white,
    height:1.5,
    ),)
    ),
    SizedBox(height: 20),
    Row(children: <Widget>[

    Expanded(
    child: RaisedButton(
    color: Colors.blue,
    onPressed: (){
      Navigator.of(context).push(MaterialPageRoute(builder:(_) => SignUpPage(), ),);

    },
    child: Text("Inscription",
    style: TextStyle(color: Colors.white),),
    shape: RoundedRectangleBorder(
    borderRadius: BorderRadius.all(Radius.circular(50))
    ),
    padding: EdgeInsets.symmetric(vertical: 8),
    )

    ),SizedBox(width: 20),
    Expanded(
    child: RaisedButton(
    color: Colors.red,
    /*onPressed: (){

    }*/
    onPressed:(){
    Navigator.of(context).push(MaterialPageRoute(builder:(_) => FormPage(), ),);
    },
    child: Text("Login",
    style: TextStyle(color: Colors.white),),
    shape: RoundedRectangleBorder(
    borderRadius: BorderRadius.all(Radius.circular(50))
    ),
    padding: EdgeInsets.symmetric(vertical: 8),
    ),),
    ],),],);
  }
  Widget _buildAppBar(){
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        IconButton(icon:  Icon(
          FlutterIcons.menu,
          color: Colors.white,),
            onPressed: null),
        Container(
          width: 50,
          height: 50,
          margin: EdgeInsets.all(16),
          decoration: BoxDecoration(
              border: Border.all(color: Colors.white),
              borderRadius: BorderRadius.all(
                Radius.circular(100),
              ),
              image: DecorationImage(
                  image: AssetImage("assets/images/profile.jpg")
              )
          ),
        )
      ],
    );
  }  }