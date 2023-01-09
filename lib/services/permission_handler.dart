import 'dart:async';
import 'dart:io';
import 'package:permission_handler/permission_handler.dart';

class PermissionHandler {




  //Méthode pour lancer nos permissions
  start () async{
    if(Platform.isAndroid){
      //Systeme android
      PermissionStatus storage = await Permission.storage.status;
      PermissionStatus gps = await Permission.location.status;

      //Vérifier le statut pour le stockage
      checkStatusStorage(storage);

      //Vérifier le statut du gps
      checkStatusLocation(gps);


    }
    else
    {
      //Systeme ios
      PermissionStatus status = await Permission.photos.status;
      PermissionStatus gps = await Permission.location.status;

      //Vérifier le status pour les photos
      checkStatusPhoto(status);
      checkStatusLocation(gps);
    }

  }


  //Vérification du gps
  Future<PermissionStatus> checkStatusLocation(PermissionStatus permissionStatus) async {
    switch(permissionStatus){
    //cas toujours refusé
      case PermissionStatus.permanentlyDenied : return Future.error("L'accès du gps est refusé");



    //cas réfusé
      case PermissionStatus.denied : return await Permission.location.request().then((value) => checkStatusLocation(value));
    //cas seulement cette fois


      case PermissionStatus.restricted : return await Permission.location.request().then((value) => checkStatusLocation(value));
    //cas réussi
      case PermissionStatus.granted : return await Permission.location.request().then((value) => checkStatusLocation(value));
      default : return Future.error("Erreur au niveau de la récupération du statuts");
    }
  }



  Future<PermissionStatus> checkStatusPhoto(PermissionStatus permissionStatus) async {
    switch(permissionStatus){
    //cas toujours refusé
      case PermissionStatus.permanentlyDenied : return Future.error("L'accès des photos est refusé");



    //cas réfusé
      case PermissionStatus.denied : return await Permission.photos.request().then((value) => checkStatusPhoto(value));
    //cas seulement cette fois


      case PermissionStatus.restricted : return await Permission.photos.request().then((value) => checkStatusPhoto(value));
    //cas réussi
      case PermissionStatus.granted : return await Permission.photos.request().then((value) => checkStatusPhoto(value));
      default : return Future.error("Erreur au niveau de la récupération du statuts");
    }
  }


//verification du stockage ou disque interne android
  Future<PermissionStatus> checkStatusStorage(PermissionStatus permissionStatus) async {
    switch(permissionStatus){
    //cas toujours refusé
      case PermissionStatus.permanentlyDenied : return Future.error("L'accès des photos est refusé");
      break;
    //cas réfusé
      case PermissionStatus.denied : return await Permission.storage.request().then((value) => checkStatusPhoto(value));
    //cas seulement cette fois

      case PermissionStatus.restricted : return await Permission.storage.request().then((value) => checkStatusPhoto(value));
    //cas réussi
      case PermissionStatus.granted : return await Permission.storage.request().then((value) => checkStatusPhoto(value));
      default : return Future.error("Erreur au niveau de la récupération du statuts");
    }
  }



}