import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:untitled/controller/MapsController.dart';
import 'package:untitled/services/LocationManager.dart';
import 'package:untitled/controller/NoDataMapsController.dart';

class MapsViewController extends StatefulWidget {
  const MapsViewController({Key? key}) : super(key: key);

  @override
  State<MapsViewController> createState() => _MapsViewControllerState();
}

class _MapsViewControllerState extends State<MapsViewController> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Position>(
      future: LocationManager().start(),
        builder: (context,position){
        if(position.hasData){
          return MapsController(maPosition: position.data!);
        }
        else {
          return const NoDataMapsController();
        }
        }
    );
  }
}
