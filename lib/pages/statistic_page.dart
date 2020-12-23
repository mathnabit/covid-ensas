import 'package:covidensa/Animation/chart_widget.dart';
import 'package:covidensa/core/consts.dart';
import 'package:covidensa/core/flutter_icons.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'local_page.dart';

class StatisticPage extends StatefulWidget {
  @override
  _StatisticPageState createState() => _StatisticPageState();
}

class _StatisticPageState extends State<StatisticPage> {
  @override
  Widget build(BuildContext context) {
    return

    Scaffold(
      backgroundColor: AppColors.backgroundColor,
      body: Stack(
        children: <Widget>[
          Container(
            height: 275,
            decoration: BoxDecoration(
              color: AppColors.mainColor,
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(25),
                bottomRight: Radius.circular(25),
              ),
            ),
            padding: EdgeInsets.only(top: 25),
            child: Image.asset("assets/images/virus2.png"),
          ),
          Container(
            padding: EdgeInsets.only(top: 25),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                CustomAppBarWidget(),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  child: Text(
                    "STATISTICS",
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 32,
                    ),
                  ),
                ),
                SizedBox(height: 25),
                _buildStatistic(),
                Padding(
                  padding: EdgeInsets.all(8),
                  child: Row(
                    children: <Widget>[
                      Expanded(
                        child: _buildGender(FlutterIcons.male,
                            Colors.orangeAccent, "MALE", "59.5%"),
                      ),
                      SizedBox(width: 10),
                      Expanded(
                        child: _buildGender(FlutterIcons.female,
                            Colors.pinkAccent, "FEMALE", "40.5%"),
                      ),
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

  Widget _buildGender(IconData icon, Color color, String title, String value) {
    return Container(
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
      padding: EdgeInsets.all(16),
      child: Column(
        children: <Widget>[
          Row(
            children: <Widget>[
              Icon(
                icon,
                size: 60,
                color: color,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    title,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                      fontSize: 24,
                    ),
                  ),
                  Text(
                    "Confirmed\nCase",
                    style: TextStyle(
                      color: Colors.black38,
                      height: 1.5,
                    ),
                  ),
                ],
              )
            ],
          ),
          SizedBox(
            height: 20,
          ),
          Text(
            value,
            style: TextStyle(
              color: color,
              fontWeight: FontWeight.bold,
              fontSize: 32,
            ),
          )
        ],
      ),
    );
  }

  Widget _buildStatistic() {
    return Container(
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
      margin: EdgeInsets.symmetric(horizontal: 16),
      padding: EdgeInsets.all(24),
      child: Center(
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Container(
              width: 150,
              height: 150,
              child: DonutPieChart.withSampleData(),
            ),
            SizedBox(width: 25),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                _buildStatisticItem(
                    Colors.blueAccent, "Confirmed", "23,29,539"),
                _buildStatisticItem(
                    Colors.yellowAccent, "Recovered", "5,92,229"),
                _buildStatisticItem(Colors.redAccent, "Deaths", "1,60,717"),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatisticItem(Color color, String title, String value) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: <Widget>[
        Icon(
          FlutterIcons.label,
          size: 50,
          color: color,
        ),
        Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              title,
              style: TextStyle(
                color: Colors.black38,
              ),
            ),
            SizedBox(height: 5),
            Text(value),
          ],
        ),
      ],
    );
  }
}
class CustomAppBarWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        IconButton(
          icon: Icon(
            FlutterIcons.menu,
            color: Colors.white,
          ),
          onPressed: null,
        ),
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
              image: AssetImage("assets/images/profile.jpg"),
            ),
          ),
        )
      ],
    );
    ;
  }
}
