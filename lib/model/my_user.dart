import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:geolocator/geolocator.dart';
import 'package:untitled/services/constants.dart';

class MyUser {
  late String id;
  String? pseudo;
  late String nom;
  late String prenom;
  late String mail;
  late bool genre;
  Position? gps;
  List? favoris;
  //gps,
   String? avatar;

  String get fullName {
    return prenom +" "+ nom;
  }

  MyUser(DocumentSnapshot snapshot){
    String? provisoirePseudo;
    String? provisoireAvatar;
    List? provisoireFavoris;
    id = snapshot.id;
    Map<String,dynamic> map = snapshot.data() as Map<String,dynamic>;
    nom = map["NOM"];
    prenom = map["PRENOM"];
    mail = map["MAIL"];
    genre = map["GENRE"];
    gps = map["GPS"];

    provisoireFavoris = map["FAVORIS"];
    if(provisoireFavoris == null){
      favoris = [];
    }
    else
    {
      favoris = provisoireFavoris;
    }

    provisoirePseudo = map["PSEUDO"];
    if(provisoirePseudo == null){
      pseudo = "";
    }
    else
    {
      pseudo = provisoirePseudo;
    }

    provisoireAvatar = map["AVATAR"];
    if(provisoireAvatar == null){
      avatar = avatarDeafult;
    }
    else
    {
      avatar = provisoireAvatar;
    }
  }

  MyUser.empty(){
    id = "";
    nom = "";
    prenom = "";
    mail = "";
    genre = true;
  }

  String genderString() => (genre) ? "Féminin" : "Masculin";
}