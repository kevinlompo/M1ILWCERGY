import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:untitled/services/constants.dart';

class MyUser {
  late String id;
  String? pseudo;
  late String nom;
  late String prenom;
  late String mail;
  late bool genre;
  //gps,
  String? avatar;



  MyUser(DocumentSnapshot snapshot){
    String? provisoirePseudo;
    String? provisoireAvatar;
    id = snapshot.id;
    Map<String,dynamic> map = snapshot.data() as Map<String,dynamic>;
      nom = map["NOM"];
      prenom = map["PRENOM"];
      mail = map["MAIL"];
      genre = map["GENRE"];


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