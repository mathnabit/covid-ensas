import 'package:flutter/material.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Notifications extends StatefulWidget {
  @override
  _NotificationsState createState() => _NotificationsState();
}


class _NotificationsState extends State<Notifications> {

  //Instances
  final Firestore _db = Firestore.instance;
  final FirebaseMessaging _fcm = FirebaseMessaging();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _fcm.getToken().then((value) => {
        print('token : ' + value)
    });
    
    
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      
    );
  }
}