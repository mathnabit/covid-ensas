import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:covidensa/services/database.dart';
import 'package:covidensa/models/zone.dart';

class MapePage extends StatefulWidget {
  @override
  _MapePageState createState() => _MapePageState();
  
}

class _MapePageState extends State<MapePage> {
 Completer<GoogleMapController> _controller = Completer();

  /*GoogleMapController mapController;
  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }*/
  //mapController.future 
  double zoomVal=5.0;
  //objet database
  final DatabaseService _db = DatabaseService();
  List<Zone> zones;
  Zone biyada,jrifat,essaada;
  //bool
  bool test = false;
  @override
  void initState() {
   _getZoneEtat(); 
  super.initState();
  }
  //zones etats
  Future<bool>  _getZoneEtat() async {
    zones = await _db.zoneEtat();
    biyada =  zones.where((zone) => zone.uid == "7qKYjq5V8gRPPsnuq7Rr").first;
    jrifat =  zones.where((zone) => zone.uid == "4zjWZu1YUH3aUaSHVnCM").first;
    essaada =  zones.where((zone) => zone.uid == "srTcEgPLd6ElivpJqg3f").first;
    return true;
    //print(jrifat.uid);
    //print(jrifat.nom);
    //print(biyada.nom);
   // print(essaada.nom);
    //print(jrifat.gueris);
  }

  @override
  Widget build(BuildContext context) {
    /*return FutureBuilder<bool>(
      future:  _getZoneEtat(),
      builder: (context, AsyncSnapshot<bool> snapshot) {
        if (snapshot.data == true) {*/
          return Scaffold(
              appBar: AppBar(
        leading: Icon(
          Icons.menu,
          color: Colors.white,
        ),
        centerTitle: true,
        title: Text(
          'Map covid safi',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 22.0,
          ),
        ),
        backgroundColor: Colors.deepPurple[800],
      ),
              body: Stack(
                  children: <Widget>[
                    _buildGoogleMap(context),
                    _zoomminusfunction(),
                    _zoomplusfunction(),
                    _buildContainer(),
                  ],
                ),
              
            );
        /*} else {
          return CircularProgressIndicator();
        }
      }
    );*/
    }


//widget google map
Widget _buildGoogleMap(BuildContext context) {
    
    return Container(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      child: GoogleMap(
        mapType: MapType.normal ,
        initialCameraPosition:  CameraPosition(target: LatLng(32.2833322 , -9.2333324), zoom: 13),
        onMapCreated: (GoogleMapController controller) async{
          await _controller.complete(controller);
        },
        markers: {
          biyadaMarker,jrifatMarker,essaadaMarker
        },
         zoomControlsEnabled: false,
      ),
    );
  }
Future<void> _gotoLocation(double lat,double long) async {
    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(target: LatLng(lat, long), zoom: 15,tilt: 50.0,
      bearing: 45.0,)));
  }


//boxes container
Widget _buildContainer() {
  return FutureBuilder<bool>(
      future:  _getZoneEtat(),
      builder: (context, AsyncSnapshot<bool> snapshot) {
        if (snapshot.data == true) {
    return Align(
      alignment: Alignment.bottomLeft,
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 20.0),
        height: 150.0,
        child: ListView(
          scrollDirection: Axis.horizontal,
          children: <Widget>[
            SizedBox(width: 10.0),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: _boxes(
                  "assets/images/safi.jpg",
                  32.304559, -9.234414,biyada),
            ),
            SizedBox(width: 10.0),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: _boxes(
                  "assets/images/byada.jpg",
                  32.285600, -9.222647,jrifat),
            ),
            SizedBox(width: 10.0),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: _boxes(
                  "assets/images/byada.jpg",
                  32.297463, -9.219042,essaada),
            ),
          ],
        ),
      ),
    );
    } else {
          return CircularProgressIndicator();
        }
      }
    );
  }

  //one boxe
  Widget _boxes(String _image, double lat,double long,Zone zoneObject) {
    return  GestureDetector(
        onTap: () async{
          await _gotoLocation(lat,long);
        },
        child:Container(
              child: new FittedBox(
                child: Material(
                    color: Colors.white,
                    elevation: 14.0,
                    borderRadius: BorderRadius.circular(24.0),
                    shadowColor: Color(0x802196F3),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Container(
                          width: 180,
                          height: 200,
                          child: ClipRRect(
                            borderRadius: new BorderRadius.circular(24.0),
                            child: Image(
                              fit: BoxFit.fill,
                              image: AssetImage(_image),
                            ),
                          ),),
                          Container(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: myDetailsContainer1(zoneObject),
                          ),
                        ),

                      ],)
                ),
              ),
            ),
    );
  }


  //details container
  Widget myDetailsContainer1(Zone zoneObject) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(left: 8.0),
          child: Container(
              child: Text(zoneObject != null ? zoneObject.nom : 'null',
            style: TextStyle(
                color: Color(0xff6200ee),
                fontSize: 24.0,
                fontWeight: FontWeight.bold),
          )),
        ),
        SizedBox(height:5.0),
        Container(
              child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              
              Container(
                child: Icon(
                  FontAwesomeIcons.virus,
                  color: Colors.deepPurpleAccent[700],
                  size: 16.0,
                ),
              ),
             
               Container(
                  child: Text(
                "Infectés : " + (zoneObject != null ? zoneObject.infectes.toString() : 'null'),
                style: TextStyle(
                  color: Colors.black54,
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold
                ),
                
              )),
            ],
          )),
        SizedBox(height:5.0),
        Container(
              child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              
              Container(
                child: Icon(
                  FontAwesomeIcons.solidDizzy,
                  color: Colors.deepPurpleAccent[700],
                  size: 16.0,
                ),
              ),
             
               Container(
                  child: Text(
                "Morts : " + (zoneObject != null ? zoneObject.morts.toString() : 'null'),
                style: TextStyle(
                  color: Colors.black54,
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold
                ),
              )),
            ],
          )),
        SizedBox(height:5.0),
        Container(
              child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              
              Container(
                child: Icon(
                  FontAwesomeIcons.shieldVirus,
                  color: Colors.deepPurpleAccent[700],
                  size: 16.0,
                ),
              ),
             
               Container(
                  child: Text(
                "Guéris : " + (zoneObject != null ? zoneObject.gueris.toString() : 'null'),
                style: TextStyle(
                  color: Colors.black54,
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold
                ),
                
              )),
            ],
          )),
      ],
    );
  }

//


//zoom
Future<void> _minus(double zoomVal) async{
  final GoogleMapController controller = await _controller.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(target: LatLng(32.2833322 , -9.2333324), zoom: zoomVal)));
  }
  Future<void> _plus(double zoomVal) async{
    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(target: LatLng(32.2833322 , -9.2333324), zoom: zoomVal)));
  }

Widget _zoomminusfunction() {
    
    return Align(
      alignment: Alignment.topLeft,
      child: IconButton(
            icon: Icon(FontAwesomeIcons.searchMinus,color:Color(0xff6200ee)),
            onPressed: () {
              zoomVal--;
              _minus( zoomVal);
            }),
    );
 }
 Widget _zoomplusfunction() {
 
    return Align(
      alignment: Alignment.topRight,
      child: IconButton(
            icon: Icon(FontAwesomeIcons.searchPlus,color:Color(0xff6200ee)),
            onPressed: () {
              zoomVal++;
               _plus(zoomVal);
            }),
    );
 }
}


  //Markers
Marker biyadaMarker = Marker(
  markerId: MarkerId('biyada'),
  position: LatLng(32.304559, -9.234414),
  infoWindow: InfoWindow(
    title:'Biyada',
    snippet: 'Danger'
  ),
  icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRose),
);

Marker jrifatMarker = Marker(
  markerId: MarkerId('jrifat'),
  position: LatLng(32.285600, -9.222647),
  infoWindow: InfoWindow(
    title:'Jrifat'
  ),
  icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRose),
);

Marker essaadaMarker = Marker(
  markerId: MarkerId('essaada'),
  position: LatLng(32.297463, -9.219042),
  infoWindow: InfoWindow(
    title:'Essaada'
  ),
  icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRose),
);
 