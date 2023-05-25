import 'package:flutter/material.dart';
import'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import'package:geolocator/geolocator.dart';
import'package:geocoding/geocoding.dart';
import 'Login.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  MaterialApp(home: location(),);

}



class location extends StatefulWidget {
  const location({Key? key}) : super(key: key);

  @override
  State<location> createState() => _menuPageState();
}

class _menuPageState extends State<location> {
  var _latitude ="";
  var _longitude ="";
  var _altitude="";
  var _speed ="";
  var _address = "";

  Future<void>_updatePosition() async {
    Position pos = await _determinePosition();
    List pm = await placemarkFromCoordinates(pos.latitude, pos.longitude);
    setState(() {
      _latitude = pos.latitude.toString();
      _longitude = pos.longitude.toString();
      _altitude = pos.altitude.toString();
      _speed = pos.speed.toString();
      _address = pm[0].toString();
    });
  }
  Future <Position>_determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Location services are disabled.');
    }
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }
    if (permission == LocationPermission.deniedForever) {
      return Future.error(
          "Location permissions are permanently denied,we cannot request permissions.");
    }
    return await Geolocator.getCurrentPosition();
  }




  @override

  bool _obscuretext = false;
  IconData id = Icons.visibility_off;
  Widget build(BuildContext context) =>
      Scaffold(appBar: AppBar(
        title: const Text('Main Page', style: TextStyle(fontSize: 12,color: Colors.black),),
        backgroundColor: Colors.grey,),
        resizeToAvoidBottomInset: false,
        body: GestureDetector(
          onTap: () {
            FocusScope.of(context).requestFocus(new FocusNode());
          },
          child: Container(
            decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('images/backround.jpg'),
                  colorFilter: new ColorFilter.mode(
                      Colors.black.withOpacity(0.6), BlendMode.color),
                  fit: BoxFit.fill,
                )),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  SizedBox(
                    child: Image(
                      image: AssetImage('images/logo.jpg'),),
                    height: 200,),
                  SizedBox(
                    height: 20,),
                      const Text(
            'Your last known location is:',
          ),
          Text(
            "Latidude:"+_latitude,style: TextStyle(color: Colors.white),

          ),// Text
          Text(
            "Longitude:"+_longitude,
              style: TextStyle(color: Colors.white)
          ),// Text
          Text(
              "Altitude:"+_altitude,
              style: TextStyle(color: Colors.white)
        ),
                  Text(
                    "Speed:"+_speed,
                      style: TextStyle(color: Colors.white)
                  ),
                  const Text('Address: ', style: TextStyle(color: Colors.white)),
                  Text(_address,style: TextStyle(color: Colors.white)),
            FlatButton(
                child: Text("get Gps Location", style: TextStyle(color: Colors
                    .indigo[900]),),
                color: Colors.blue[100],
                minWidth: 200,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                  side: BorderSide(color: Colors.white),),
  onPressed: _updatePosition,
            ),


                ],),),),

        ),);
}
