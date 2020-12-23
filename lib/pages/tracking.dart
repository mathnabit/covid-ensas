import 'dart:io';
import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:location/location.dart';
import 'package:flutter/material.dart';
import 'package:nearby_connections/nearby_connections.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:covidensa/pages/contact_card.dart';
import 'package:covidensa/services/database.dart';

class Tracking extends StatefulWidget {
  static const String id = 'nearby_interface';

  @override
  _TrackingState createState() => _TrackingState();
}

class _TrackingState extends State<Tracking> {

final DatabaseService _dbs = DatabaseService();

final Strategy strategy = Strategy.P2P_CLUSTER;

  String cId = "0"; //currently connected device ID
  File tempFile; //reference to the file currently being transferred
  Map<int, String> map = Map(); //store filename mapped to corresponding payloadId

  //Quelques variables
  Location location = Location();
  Firestore _firestore = Firestore.instance;
  final _auth = FirebaseAuth.instance;
  FirebaseUser loggedInUser;  
  List<dynamic> contactTraces = [];
  List<dynamic> contactTimes = [];
  List<dynamic> contactLocations = [];
   


  @override
  void initState() { 
  super.initState();
  //addContactsToList();
  print(contactTraces.length);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Icon(
          Icons.menu,
          color: Colors.white,
        ),
        centerTitle: true,
        title: Text(
          'Tracking',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 22.0,
          ),
        ),
        backgroundColor: Colors.deepPurple[800],
      ),
      body:  Builder( builder: (context) => Column(
        
      children: <Widget>[
        
      Row(
        //ROW 1
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Colors.white,
              boxShadow: [
                  BoxShadow(color: Colors.deepPurpleAccent[400], spreadRadius: 2)
                ]
            ),
            margin: EdgeInsets.all(5.0),
            child:ButtonBar(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
            Icon(
                  FontAwesomeIcons.locationArrow,
                  color: Colors.deepPurpleAccent[700],
                  size: 20.0,
                ),
            
                new RaisedButton(
                  child: Text("Check location"),
                  color: Colors.deepPurple[300],
                      textColor: Colors.white,
                      padding: EdgeInsets.fromLTRB(9, 9, 9, 9),
                      splashColor: Colors.grey,
                  onPressed: () async {
                    if (await Nearby().checkLocationPermission()) {
                      Scaffold.of(context).showSnackBar(SnackBar(
                          content: Text("Location permissions granted :)")));
                    } else {
                      Scaffold.of(context).showSnackBar(SnackBar(
                          content:
                              Text("Location permissions not granted :(")));
                    }
                  },
                ),
                new RaisedButton(
                  child: Text("Demander permession"),
                  color: Colors.deepPurple[300],
                      textColor: Colors.white,
                      padding: EdgeInsets.fromLTRB(9, 9, 9, 9),
                      splashColor: Colors.grey,
                  onPressed: () {
                    Nearby().askLocationPermission();
                  },
                ),
            ],
             ),
          ),
        
        ],
      ),
      Row(mainAxisAlignment: MainAxisAlignment.center,
        //ROW 2
        children: [
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Colors.white,
              boxShadow: [
                  BoxShadow(color: Colors.deepPurpleAccent[400], spreadRadius: 2)
                ]
            ),
            child:new ButtonBar(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
            Icon(
                  FontAwesomeIcons.solidHdd,
                  color: Colors.deepPurpleAccent[700],
                  size: 20.0,
                ),
                RaisedButton(
                  child: Text("Check storage"),
                  color: Colors.deepPurple[300],
                      textColor: Colors.white,
                      padding: EdgeInsets.fromLTRB(9, 9, 9, 9),
                      splashColor: Colors.grey,
                  onPressed: () async {
                    if (await Nearby().checkExternalStoragePermission()) {
                      Scaffold.of(context).showSnackBar(SnackBar(
                          content:
                              Text("External Storage permissions granted :)")));
                    } else {
                      Scaffold.of(context).showSnackBar(SnackBar(
                          content: Text(
                              "External Storage permissions not granted :(")));
                    }
                  },
                ),
                RaisedButton(
                  child: Text("Demander permession"),
                  color: Colors.deepPurple[300],
                      textColor: Colors.white,
                      padding: EdgeInsets.fromLTRB(9, 9, 9, 9),
                      splashColor: Colors.grey,
                  onPressed: () {
                    Nearby().askExternalStoragePermission();
                  },
                ),
           
              ],
            ),
          ),
        ],
      ),
      SizedBox(height:  10),
            Image.asset(
              "assets/images/virus.png",
              height: 50,
            ),
      Row(mainAxisAlignment: MainAxisAlignment.center,
      
          children: [
          Container(
            
            child:new ButtonBar(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
             RaisedButton(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.0)),
              elevation: 5.0,
              color: Colors.deepPurple[400],
              onPressed: () async {
                await getCurrentUser();
                await addContactsToList();
                try {
                      bool a = await Nearby().startAdvertising(
                        loggedInUser.email,
                        strategy,
                        onConnectionInitiated: onConnectionInit,
                        onConnectionResult: (id, status) {
                          Scaffold.of(context).showSnackBar(SnackBar(
                          content:
                              Text(status.toString())));
                          print(status);
                        },
                        
                        onDisconnected: (id) {
                          print("Disconnected: " + id);
                          Scaffold.of(context).showSnackBar(SnackBar(
                          content:
                              Text("Disconnected: " + id)));
                          
                        },
                      );
                      //showSnackbar("ADVERTISING: " + a.toString());
                      Scaffold.of(context).showSnackBar(SnackBar(
                          content:
                              Text("ADVERTISING: " + a.toString())));

                      print("ADVERTISING: " + a.toString());
                    } catch (exception) {
                      Scaffold.of(context).showSnackBar(SnackBar(
                          content:
                              Text(exception.toString())));
                      print(exception);
                    }

                    //discovery
                    try {
                      bool a = await Nearby().startDiscovery(
                        loggedInUser.email,
                        strategy,
                        onEndpointFound: (id, name, serviceId) async{
                          print('I saw id:$id with name:$name');
                          // show sheet automatically to request connection
                          showModalBottomSheet(
                            context: context,
                            builder: (builder) {
                              return Center(
                                child: Column(
                                  children: <Widget>[
                                    Text("id: " + id,style: TextStyle(
                                        color: Colors.red,
                                        //fontWeight: FontWeight.bold,
                                        fontSize: 26.0,
                                      ),),
                                                                
                                    Text("Nom: " + name,
                                    style: TextStyle(
                                      color: Colors.red,
                                      //fontWeight: FontWeight.bold,
                                      fontSize: 26.0,
                                    ),),
                                    //Text("ServiceId: " + serviceId),
                                    /*RaisedButton(
                                      //child: Text("Request Connection"),
                                      onPressed: () {
                                        Navigator.pop(context);
                                        Nearby().requestConnection(
                                          'userName',
                                          id,
                                          onConnectionInitiated: (id, info) {
                                            onConnectionInit(id, info);
                                          },
                                          onConnectionResult: (id, status) {
                                            Scaffold.of(context).showSnackBar(SnackBar(
                                              content:
                                              Text(status.toString())));
                                          },
                                          onDisconnected: (id) {
                                            Scaffold.of(context).showSnackBar(SnackBar(
                                              content:
                                              Text(id.toString())));
                                          },
                                        );
                                      },
                                    ),*/
                                  ],
                                ),
                              );
                            },
                          );
                          print(name);
                          await _firestore.collection('users').document(loggedInUser.uid)
                          .collection('met_with').document(name).setData({
                            'username': name,
                            'contact time': DateTime.now(),
                            'token' : await _dbs.getToken(name),
                           
                          },merge:true );
                          print(loggedInUser.email);
                          print(contactTraces.length);
                        },
                        onEndpointLost: (id) {
                          //showSnackbar("Lost Endpoint:" + id);
                          Scaffold.of(context).showSnackBar(SnackBar(
                            content:
                            Text("Lost Endpoint:" + id)));
                        },
                      );
                      //showSnackbar("DISCOVERING: " + a.toString());
                      Scaffold.of(context).showSnackBar(SnackBar(
                            content:
                            Text("DISCOVERING: " + a.toString())));
                    } catch (e) {
                      //showSnackbar(e);
                      Scaffold.of(context).showSnackBar(SnackBar(
                            content:
                            Text(e.toString())));
                    }
               
                
              },
              
              child: Text(
                
                'Start Tracking',
                style: TextStyle(
                  fontSize: 16
                ),
                /*style: kButtonTextStyle,*/
              ),
              
            ),
            RaisedButton(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.0)),
              elevation: 5.0,
              color: Colors.deepPurple[400],
              onPressed: () async {

                await Nearby().stopAdvertising();
                await Nearby().stopDiscovery();      
                await Nearby().stopAllEndpoints();
                print(contactTraces.length);
              },
              child: Text(
                'Stop Tracking',
                style: TextStyle(
                  fontSize: 16
                ),
                /*style: kButtonTextStyle,*/
              ),
            ),

            ],
            ),
          ),
          ],
      ),
      Expanded(
        //children: [
          //Container(
          child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 25.0),
                child:ListView.builder(
                  itemBuilder: (context, index) {
                    return ContactCard(
                      imagePath: 'assets/images/safi.jpg',
                      email: contactTraces[index],
                      infection: 'Non infecté',
                      contactUsername: contactTraces[index],
                      contactTime: contactTimes[index],
                      //contactLocation: contactLocations[index],
                    );
                    // Text(contactTraces.length.toString() + ' '+contactTraces.length.toString() )
                   
                  },
                   
                  itemCount: contactTraces.length,
              ),
              ),
         // ),
        //],
      )
    ]
    ),
      ),
    );

  }

  /*void showSnackbar(dynamic a) {
    
    Scaffold.of(context).showSnackBar(SnackBar(
      content: Text(a.toString()),
    
    ));
  }*/

  /// Called upon Connection request (on both devices)
  /// Both need to accept connection to start sending/receiving
  void onConnectionInit(String id, ConnectionInfo info) {
    showModalBottomSheet(
      context: context,
      builder: (builder) {
        return Center(
          child: Column(
            children: <Widget>[
              Text("id: " + id),
              Text("Token: " + info.authenticationToken),
              Text("Name" + info.endpointName),
              Text("Incoming: " + info.isIncomingConnection.toString()),
              RaisedButton(
                child: Text("Accept Connection"),
                onPressed: () {
                  Navigator.pop(context);
                  cId = id;
                  Nearby().acceptConnection(
                    id,
                    onPayLoadRecieved: (endid, payload) async {
                      if (payload.type == PayloadType.BYTES) {
                        String str = String.fromCharCodes(payload.bytes);
                        //showSnackbar(endid + ": " + str);
                        Scaffold.of(context).showSnackBar(SnackBar(
                            content:
                            Text(endid + ": " + str)));

                        if (str.contains(':')) {
                          // used for file payload as file payload is mapped as
                          // payloadId:filename
                          int payloadId = int.parse(str.split(':')[0]);
                          String fileName = (str.split(':')[1]);

                          if (map.containsKey(payloadId)) {
                            if (await tempFile.exists()) {
                              tempFile.rename(
                                  tempFile.parent.path + "/" + fileName);
                            } else {
                             // showSnackbar("File doesnt exist");
                             Scaffold.of(context).showSnackBar(SnackBar(
                                content:
                                Text("File doesnt exist")));
                            }
                          } else {
                            //add to map if not already
                            map[payloadId] = fileName;
                          }
                        }
                      } else if (payload.type == PayloadType.FILE) {
                        //showSnackbar(endid + ": File transfer started");
                        Scaffold.of(context).showSnackBar(SnackBar(
                            content:
                            Text(endid + ": File transfer started")));
                        tempFile = File(payload.filePath);
                      }
                    },
                    onPayloadTransferUpdate: (endid, payloadTransferUpdate) {
                      if (payloadTransferUpdate.status ==
                          PayloadStatus.IN_PROGRRESS) {
                        print(payloadTransferUpdate.bytesTransferred);
                      } else if (payloadTransferUpdate.status ==
                          PayloadStatus.FAILURE) {
                        print("failed");
                        //showSnackbar(endid + ": FAILED to transfer file");
                        Scaffold.of(context).showSnackBar(SnackBar(
                            content:
                            Text(endid + ": FAILED to transfer file")));
                      } else if (payloadTransferUpdate.status ==
                          PayloadStatus.SUCCESS) {
                        //showSnackbar( "success, total bytes = ${payloadTransferUpdate.totalBytes}");
                          Scaffold.of(context).showSnackBar(SnackBar(
                            content:
                            Text("success, total bytes = ${payloadTransferUpdate.totalBytes}")));
                        if (map.containsKey(payloadTransferUpdate.id)) {
                          //rename the file now
                          String name = map[payloadTransferUpdate.id];
                          tempFile.rename(tempFile.parent.path + "/" + name);
                        } else {
                          //bytes not received till yet
                          map[payloadTransferUpdate.id] = "";
                        }
                      }
                    },
                  );
                },
              ),
              RaisedButton(
                child: Text("Reject Connection"),
                onPressed: () async {
                  Navigator.pop(context);
                  try {
                    await Nearby().rejectConnection(id);
                  } catch (e) {
                    //showSnackbar(e);
                    Scaffold.of(context).showSnackBar(SnackBar(
                            content:
                            Text(e.toString())));
                  }
                },
              ),
            ],
          ),
        );
      },
    );
  }
  Future<void> getCurrentUser() async {
    try {
      final user = await _auth.currentUser();
      if (user != null) {
        loggedInUser = user;
      }
    } catch (e) {
      print(e);
    }
  }

  Future<void> addContactsToList() async {
    await getCurrentUser();

    await _firestore
        .collection('users')
        .document(loggedInUser.uid)
        .collection('met_with')
        .snapshots()
        .listen((snapshot) {
      for (var doc in snapshot.documents) {
        String currUsername = doc.data['username'];
        DateTime currTime = doc.data.containsKey('contact time')
            ? (doc.data['contact time'] as Timestamp).toDate()
            : null;
        /*String currLocation = doc.data.containsKey('contact location')
            ? doc.data['contact location']
            : null;*/

        if (!contactTraces.contains(currUsername)) {
          contactTraces.add(currUsername);
          contactTimes.add(currTime);
          //contactLocations.add(currLocation);
        }
      }
      setState(() {});
      print(loggedInUser.email);
    });
  }
}