

import 'dart:developer';

import 'package:covidensa/core/consts.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class LocalPage extends StatefulWidget {
@override
_LocalPageState  createState() => _LocalPageState();
}


class _LocalPageState extends State<LocalPage> {
  get kHeadingTextStyle => null;



  @override
  Widget build(BuildContext context) {
    return new Scaffold(



      body: SingleChildScrollView(
        //controller: controller,
        child:Column(
        children: <Widget>[
          ClipPath(
      clipper: MyClipper(),
          child:Container(
            padding: EdgeInsets.only(left:40,top: 50,right: 20 ),
            height: 350,
            width: double.infinity,
            decoration: BoxDecoration(gradient:LinearGradient(
                begin: Alignment.topRight,
                end:Alignment.bottomLeft,colors: [
              AppColors.mainColor,
              AppColors.mainColor.withOpacity(.5),

            ]),
              image: DecorationImage(image:AssetImage("assets/images/virus2.png") ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Align(
                  alignment:Alignment.topRight,
           child:SvgPicture.asset("assets/icons/menu.svg"),
                ),
                SizedBox(height: 20,),
                Expanded(child:Stack(
                  children: <Widget>[
                    SvgPicture.asset("assets/icons/Drcorona.svg",
                    width: 230,fit: BoxFit.fitWidth,alignment: Alignment.topCenter,),
                    Positioned(
top: 1,
                        left:180,
                        child: Text(" Restons\n chez nous",style:TextStyle(color:Colors.white,fontWeight: FontWeight.bold,fontSize: 23)),


                    ),
                      Container(),
                  ],),
                ),],
                ) ,),
          ),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 20),
            padding: EdgeInsets.symmetric(vertical: 10,horizontal: 20),
            height: 60,
            width: double.infinity,
            decoration: BoxDecoration(color: Colors.white,
              borderRadius: BorderRadius.circular(25),
              border: Border.all(
                color: Color(0xFFE),
              ),
            ),
            child: Row(
              children: <Widget>[
                SvgPicture.asset("assets/icons/maps-and-flags.svg"),
                SizedBox(width: 20),
                Expanded(child:
    DropdownButton(isExpanded: true,
      underline: SizedBox(),
      icon: SvgPicture.asset("assets/icons/dropdown.svg"),
      items: ['Hay Anass','azib daraai','miftah el kheir'].map<DropdownMenuItem<String>>((String value) {
    return DropdownMenuItem<String>(
    value: value,
    child: Text(value),);}).toList(),
                   onChanged: (value) {  },
                ),),],),
            ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              children: <Widget>[
                Row(
    children: <Widget>[
            RichText(
            text: TextSpan(
              children: [
              TextSpan(
              text: "Case Update\n",
              style: TextStyle(color: Colors.black),
            ),
            TextSpan(
              text: "Newest update March 28",
              style: TextStyle(
                color: Colors.black,
              ),
            ),
            ],
          ),),
                Spacer(),
                Text(
                  "See details",
                  style: TextStyle(
                    color: Colors.deepPurpleAccent,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
                SizedBox(height: 20),
                Container(
                  padding: EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        offset: Offset(0, 4),
                        blurRadius: 30,
                        color: Colors.grey,
                      ),
                    ],
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                       Counter(
                        color: Colors.black,
                        number: 1046,
                        title: "Infected",
                      ),
                      Counter(
                        color: Colors.black,
                        number: 87,
                        title: "Deaths",
                      ),
                      Counter(
                        color: Colors.black,
                        number: 46,
                        title: "Recovered",
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      "Spread of Virus",
                      style: TextStyle(color: Colors.black),
                    ),
                    Text(
                      "See details",
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
                Container(
                  margin: EdgeInsets.only(top: 20),
                  padding: EdgeInsets.all(20),
                  height: 178,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        offset: Offset(0, 10),
                        blurRadius: 30,
                        color: Colors.black,
                      ),
                    ],
                  ),
                  child: Image.asset(
                    "assets/images/map.png",
                    fit: BoxFit.contain,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),),
    );
  }
}

class MyClipper extends CustomClipper<Path>{
  @override
  Path getClip(Size size) {
    var path = Path();
    path.lineTo(0, size.height-80);
    path.quadraticBezierTo(size.width/2, size.height, size.width, size.height-80);
    path.lineTo(size.width, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    // TODO: implement shouldReclip
    return false;
  }

}

class Counter extends StatelessWidget {
  final int number;
  final Color color;
  final String title;
  const Counter({
    Key key,
    this.number,
    this.color,
    this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(
          padding: EdgeInsets.all(6),
          height: 25,
          width: 25,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: color.withOpacity(.26),
          ),
          child: Container(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.transparent,
              border: Border.all(
                color: color,
                width: 2,
              ),
            ),
          ),
        ),
        SizedBox(height: 10),
        Text(
          "$number",
          style: TextStyle(
            fontSize: 40,
            color: color,
          ),
        ),
        Text(title, style: TextStyle(color: Colors.black)),
      ],
    );
  }
}


