import 'dart:async';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:untitled/services/FireStoreHelper.dart';
//import 'package:untitled/services/FirestoreHelper.dart';
import 'package:untitled/services/constants.dart';

class MapsController extends StatefulWidget {
  Position maPosition;
  MapsController({Key? key,required this.maPosition}) : super(key: key);

  @override
  State<MapsController> createState() => _MapsControllerState();
}

class _MapsControllerState extends State<MapsController> {
  //variables
  LatLng tourEiffel = const LatLng(48.858278, 2.29425);
  late CameraPosition initCamera;
  Completer<GoogleMapController> controllerGoogleMaps = Completer();
  Set<Marker> myMarkers = Set();


  @override
  void iniState(){
    Map<String,dynamic> map = {
      "GPS":widget.maPosition
    };
    FireStoreHelper().updateUser(myGlobalUser.id, map);
  }
  @override
  Widget build(BuildContext context) {
    initCamera = CameraPosition(target: LatLng(widget.maPosition.latitude,widget.maPosition.longitude),zoom: 15);
    myMarkers.add(
      Marker(
          markerId: const MarkerId("0"),
          position: tourEiffel,
          infoWindow: const InfoWindow(
              title: 'Tour Eiffel',
              snippet: 'La dame de fer de Paris'
          )
      ),
    );
    return GoogleMap(
      initialCameraPosition: initCamera,
      markers: myMarkers,
      myLocationEnabled: true,
      onMapCreated: (GoogleMapController control) async{
        String newStyle = await DefaultAssetBundle.of(context).loadString("lib/services/stylemaps.json");
        control.setMapStyle(newStyle);
        controllerGoogleMaps.complete(control);
      },
    );
  }
}