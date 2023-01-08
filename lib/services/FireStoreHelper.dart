import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:untitled/model/my_user.dart';

class FireStoreHelper {
  final auth = FirebaseAuth.instance;
  final storage = FirebaseStorage.instance;
  final cloudUsers = FirebaseFirestore.instance.collection("UTILISATEURS");


  Future<MyUser> register(String nom, String prenom, String mail, String password, bool genre) async {
    UserCredential result = await auth.createUserWithEmailAndPassword(email: mail, password: password);
    String uid = result.user!.uid;
    Map<String,dynamic> map = {
      "NOM":nom,
      "PRENOM":prenom,
      "MAIL":mail,
      "GENRE":genre
    };
    addUser(uid, map);
    return getUser(uid);

  }

  Future<String> getuid() async {
    String currentuser = await auth.currentUser!.uid;
    return currentuser;
  }


 Future<MyUser> connect(String mail, String password) async {
   UserCredential result = await auth.signInWithEmailAndPassword(email: mail, password: password);
   return getUser(result.user!.uid);
  }

  Future<MyUser> getUser(String uid) async {
    DocumentSnapshot snapshot = await cloudUsers.doc(uid).get();
    return MyUser(snapshot);
  }

  //ajouter un utilisateur
  addUser(String uid, Map<String,dynamic> map){
    cloudUsers.doc(uid).set(map);
  }



  //mettre à jours les infos de l'utilisateurs
  updateUser(String uid , Map<String,dynamic>map){
    cloudUsers.doc(uid).update(map);
  }

  updateUsingController(String uid, TextEditingController? controller){
    cloudUsers.doc(uid).update({
      "NOM":controller!.text,
     /* "PRENOM" :controller.text,
      "MAIL" : controller.text,
      "GENRE"   :controller.text,*/
    });
  }

  updateFavoris(MyUser user){
    Map<String,dynamic> map = {
      "FAVORIS":user.favoris,
    };
    cloudUsers.doc(user.id).update(map);
  }

  deleteUserWithUid(String uid){
    cloudUsers.doc(uid).delete();
  }

  //Supprimer l'utilisateur
  deleteUser(){
    cloudUsers.doc(auth.currentUser!.uid).delete();
    auth.currentUser!.delete();

  }

  //Stocker les images
Future<String>stockageImage(String nameImage, Uint8List data) async {
    TaskSnapshot snapshot = await storage.ref("profil/$nameImage").putData(data);
    String urlImage = await snapshot.ref.getDownloadURL();
    return urlImage;
}
}