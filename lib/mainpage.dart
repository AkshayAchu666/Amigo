import 'package:flutter/material.dart';
import'package:flutter/material.dart';
import'package:geolocator/geolocator.dart';
import'package:geocoding/geocoding.dart';
import 'package:telephony/telephony.dart';
import 'Login.dart';
import 'package:amigo_app/loction.dart';



class Mainmenu extends StatefulWidget {
  const Mainmenu({Key? key}) : super(key: key);

  @override
  State<Mainmenu> createState() => _menuPageState();
}

 class _menuPageState extends State<Mainmenu> {



   final Telephony telephony = Telephony.instance;

   final _formKey = GlobalKey<FormState>();

   final TextEditingController homeController = TextEditingController();
   final TextEditingController PoliceController = TextEditingController();
   final TextEditingController _msgController = TextEditingController();
   final TextEditingController _valueSms = TextEditingController();
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
   void initState() {
     super.initState();
     PoliceController.text = '8589006333';
     homeController.text = '8136945286';
     _msgController.text = _latitude;  _longitude ; _altitude;
     _valueSms.text = '10';
   }




          @override
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
                                  children: [
                                    SizedBox(
                              child: Image(
                              image: AssetImage('images/logo.jpg'),),
                            height: 200,),
                                    SizedBox(
                                      height: 20,),
                                    FlatButton(
                                        child: Text(
                                          "Send My Location",
                                          style: TextStyle(color: Colors.white),
                                        ),
                                        color: Colors.blue[600],
                                        minWidth: 160,
                                        onPressed: () {
                                          showDialog(
                                            context: context, barrierDismissible: false,
                                            builder: (context) => Center(child: CircularProgressIndicator()),
                                          );
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(builder: (context) => location()),
                                          );

                                            }),
                                    FlatButton(
                                        child: Text(
                                          "Police Station",
                                          style: TextStyle(color: Colors.white),
                                        ),
                                        color: Colors.blue[600],
                                        minWidth: 160,
                                        onPressed: ()  async {
                        int _sms = 0;
                        while (_sms < int.parse(_valueSms.text)) {
                        telephony.sendSms(to: PoliceController.text, message: _msgController.text);
                        _sms ++;
                        }
                        }
                                        ),
                                    FlatButton(
                                        child: Text(
                                          "Home",
                                          style: TextStyle(color: Colors.white),
                                        ),
                                        color: Colors.blue[600],
                                        minWidth: 160,
                                        onPressed: () => _sendSMS(),
                                    ),





                        ],),),),),);



   _sendSMS() async {
     int _sms = 0;
     while (_sms < int.parse(_valueSms.text)) {
       telephony.sendSms(to: homeController.text, message: _msgController.text);
       _sms ++;
     }
   }
   _sendSMS1() async {
     int _sms = 1;
     while (_sms < int.parse(_valueSms.text)) {
       telephony.sendSms(to: PoliceController.text, message: _msgController.text);
       _sms ++;
     }
   }
  }
