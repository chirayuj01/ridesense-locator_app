import 'dart:convert';

import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:http/http.dart' as http;
import 'package:uuid/uuid.dart';
import 'package:ridesense_app/maps_page.dart';

class LocationGetter extends StatefulWidget {
  @override
  _LocationGetterState createState() => _LocationGetterState();
}

class _LocationGetterState extends State<LocationGetter> {
  Uuid uuid = Uuid();
  TextEditingController _locationController = TextEditingController();
  TextEditingController _latitudeController = TextEditingController();
  TextEditingController _longitudeController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  String Api_key = 'AIzaSyAmsk8XE1tF2xjCGpZEQfRoBNFqxicVgJc';
  String url = 'https://maps.googleapis.com/maps/api/place/autocomplete/json';
  String token_API = '37465';
  List<dynamic> suggestions = [];

  void giveSuggestions(String input) async {
    String httpRequest =
        '$url?input=$input&key=$Api_key&sessiontoken=$token_API';

    var response = await http.get(Uri.parse(httpRequest));

    if (response.statusCode == 200) {
      var result = jsonDecode(response.body);
      setState(() {
        suggestions = result['predictions'];
      });
    } else {
      throw Exception('Cannot load results');
    }
  }

  void onModify() {
    if (token_API == null) {
      setState(() {
        token_API = uuid.v4();
      });
    }
    giveSuggestions(_locationController.text.toString());
  }

  @override
  void initState() {
    super.initState();
    _locationController.addListener(() {
      onModify();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: <Widget>[
            Expanded(
              child: Divider(
                color: Colors.white.withOpacity(0.8),
                thickness: 2,
                endIndent: 10,
              ),
            ),
            Text(
              'Location',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.white,
                fontSize: 45,
                fontFamily: 'heading',
              ),
            ),
            Expanded(
              child: Divider(
                color: Colors.white.withOpacity(0.8),
                thickness: 2,
                indent: 10,
              ),
            ),
          ],
        ),
        centerTitle: true,
        backgroundColor: Colors.blueAccent.withOpacity(1),
        elevation: 0,
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.blueAccent, Colors.lightBlueAccent],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 60),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => locator_page()));
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue.shade800,
                  padding: EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Icon(Icons.my_location_sharp, color: Colors.white, size: 27),
                    Text(
                      '  Get Current Location',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.only(left: 60.0, right: 60.0),
                child: Row(
                  children: [
                    Expanded(
                      child: Divider(
                        color: Colors.black.withOpacity(0.8),
                        thickness: 2,
                        endIndent: 10,
                      ),
                    ),
                    Text(
                      'or ',
                      style: TextStyle(fontFamily: 'header', fontSize: 30),
                    ),
                    Expanded(
                      child: Divider(
                        color: Colors.black.withOpacity(0.8),
                        thickness: 2,
                        endIndent: 10,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 30),
              AnimatedTextKit(
                isRepeatingAnimation: false,
                animatedTexts: [
                  TypewriterAnimatedText('Find Your Location',
                      textStyle: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                      speed: Duration(milliseconds: 100))
                ],
              ),
              SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.only(left: 16.0, right: 16.0),
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black12,
                        blurRadius: 10,
                        spreadRadius: 2,
                      ),
                    ],
                  ),
                  child: Form(
                    key: formKey,
                    child: Column(
                      children: [
                        // Location Input
                        TextFormField(
                          controller: _locationController,
                          decoration: InputDecoration(
                            hintText: 'Enter your location',
                            hintStyle: TextStyle(
                              color: Colors.grey,
                              fontWeight: FontWeight.bold,
                            ),
                            border: InputBorder.none,
                            icon: Icon(Icons.location_on,
                                size: 30, color: Colors.blueAccent),
                          ),
                          validator: (value) {
                            if(_longitudeController==null && _latitudeController==null && _locationController==null){
                              return 'Please enter a location';
                            }
                            return null;
                          },
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: Divider(
                                color: Colors.grey.withOpacity(0.8),
                                thickness: 2,
                                endIndent: 10,
                              ),
                            ),
                            Text(
                              'or ',
                              style: TextStyle(fontFamily: 'header', fontSize: 25,color: Colors.grey),
                            ),
                            Expanded(
                              child: Divider(
                                color: Colors.grey.withOpacity(0.8),
                                thickness: 2,
                                endIndent: 10,
                              ),
                            ),
                          ],
                        ),
                        TextFormField(
                          controller: _latitudeController,
                          keyboardType: TextInputType.numberWithOptions(signed: true,decimal: true),
                          decoration: InputDecoration(
                            hintText: 'Enter latitude',
                            hintStyle: TextStyle(
                              color: Colors.grey,
                              fontWeight: FontWeight.bold,
                            ),
                            border: InputBorder.none,
                            icon: Icon(Icons.map,
                                size: 30, color: Colors.blueAccent),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return null;
                            }
                            final lat = double.tryParse(value);
                            if (lat == null || lat < -90 || lat > 90) {
                              return 'Please enter a valid latitude';
                            }
                            return null;
                          },
                        ),
                        TextFormField(
                          controller: _longitudeController,
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                            hintText: 'Enter longitude',
                            hintStyle: TextStyle(
                              color: Colors.grey,
                              fontWeight: FontWeight.bold,
                            ),
                            border: InputBorder.none,
                            icon: Icon(Icons.map_outlined,
                                size: 30, color: Colors.blueAccent),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return null;
                            }
                            final lng = double.tryParse(value);
                            if (lng == null || lng < -180 || lng > 180) {
                              return 'Please enter a valid longitude';
                            }
                            return null;
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(height: 30),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue.shade800,
                  padding: EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                onPressed: () async {
                  if (formKey.currentState!.validate()) {
                    if(_locationController.text.isNotEmpty &&_latitudeController.text.isNotEmpty && _longitudeController.text.isNotEmpty){
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                            elevation: 10,
                            behavior: SnackBarBehavior.floating,
                            content: Text(
                                'enter either coordinates or location not both')),
                      );
                    }
                    else if (_locationController.text.isNotEmpty) {
                      try {
                        List<Location> locations = await locationFromAddress(
                            _locationController.text);
                        double latitude = locations.first.latitude;
                        double longitude = locations.first.longitude;
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => locator_page(
                                coordinates: [latitude, longitude]),
                          ),
                        );
                      } catch (e) {
                        print('Error: $e');
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                              behavior: SnackBarBehavior.floating,
                              elevation: 10,
                              content: Text(
                                  'Failed to fetch location. Please try again.')),
                        );
                      }
                    }
                    else if (_latitudeController.text.isNotEmpty &&
                        _longitudeController.text.isNotEmpty) {
                      double latitude = double.parse(_latitudeController.text);
                      double longitude = double.parse(_longitudeController.text);
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => locator_page(
                              coordinates: [latitude, longitude]),
                        ),
                      );
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(
                              'Please provide either a location or coordinates'),
                        ),
                      );
                    }
                  }
                },
                child: Text('Proceed',style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 20),),
              ),
              SizedBox(height: 20),
              Image.asset(
                'assets/images/logo_app.png',
                height: 230,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
