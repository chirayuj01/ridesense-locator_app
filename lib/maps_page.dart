import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

class locator_page extends StatefulWidget {
  final List<double>? coordinates;

  locator_page({this.coordinates});

  @override
  State<locator_page> createState() => _locator_pageState();
}

class _locator_pageState extends State<locator_page> {
  final Completer<GoogleMapController> _controller = Completer<GoogleMapController>();
  Location currentposition = new Location();
  LatLng? currentcoordinates;
  final LatLng initialPosition = LatLng(37.4223, -122.08484);
  bool flag = false;

  @override
  void initState() {
    super.initState();
    getcurrentlocation();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Map Locator',
          style: TextStyle(
            color: Colors.white,
            fontFamily: 'heading',
            fontWeight: FontWeight.bold,
            fontSize: 35,
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16.0),
            child: InkWell(
              onTap: () {
                flag = !flag;
                setState(() {});
              },
              child: Column(
                children: [
                  flag == false
                      ? Icon(Icons.satellite_alt, size: 30,color: Colors.white70,)
                      : Icon(Icons.maps_home_work_outlined, size: 30,color: Colors.white70,),
                  flag == false
                      ? Text('Satellite', style: TextStyle(fontWeight: FontWeight.bold,color: Colors.white70))
                      : Text('terrain', style: TextStyle(fontWeight: FontWeight.bold,color: Colors.white70)),
                ],
              ),
            ),
          )
        ],
        backgroundColor: Colors.blueAccent.withOpacity(1),
        elevation: 0,
      ),
      body: currentcoordinates == null
          ? Center(child: CircularProgressIndicator())
          : GoogleMap(
        mapType: flag == false ? MapType.terrain : MapType.hybrid,
        initialCameraPosition: CameraPosition(
          target: currentcoordinates ?? initialPosition,
          zoom: 14,
        ),
        onMapCreated: (GoogleMapController controller) {
          _controller.complete(controller);
        },
        markers: {
          Marker(
            markerId: MarkerId("currentlocation"),
            icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue),
            position: currentcoordinates!, // Use the current coordinates here
            draggable: true,
          ),
        },
      ),
    );
  }

  Future<void> cameraposition(LatLng pos) async {
    final GoogleMapController controller = await _controller.future;
    CameraPosition newcameraposition = new CameraPosition(target: pos, zoom: 14);
    await controller.animateCamera(CameraUpdate.newCameraPosition(newcameraposition));
  }

  Future<void> getcurrentlocation() async {
    // Check if coordinates were passed from previous screen
    if (widget.coordinates != null) {
      LatLng position = LatLng(widget.coordinates![0], widget.coordinates![1]);
      setState(() {
        currentcoordinates = position;
      });
      cameraposition(currentcoordinates!);
      return;
    }
    // If no coordinates were passed, use current location
    bool serviceEnabled;
    PermissionStatus permissionGranted;

    serviceEnabled = await currentposition.serviceEnabled();
    if (!serviceEnabled) {
      serviceEnabled = await currentposition.requestService();
      if (!serviceEnabled) {
        return;
      }
    }

    permissionGranted = await currentposition.hasPermission();
    if (permissionGranted == PermissionStatus.denied) {
      permissionGranted = await currentposition.requestPermission();
      if (permissionGranted == PermissionStatus.denied) {
        return;
      }
    }

    LocationData latlong = await currentposition.getLocation();
    LatLng position = LatLng(latlong.latitude!, latlong.longitude!);
    setState(() {
      currentcoordinates = position;
    });

    cameraposition(currentcoordinates!);
  }
}
