import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
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


 Future<MyUser> connect(String mail, String password) async {
   UserCredential result = await auth.signInWithEmailAndPassword(email: mail, password: password);
   return getUser(result.user!.uid);
  }

  Future<MyUser> getUser(String uid) async {
    DocumentSnapshot snapshot = await cloudUsers.doc(uid).get();
    return MyUser(snapshot);
  }

  addUser(String uid, Map<String,dynamic> map){
    cloudUsers.doc(uid).set(map);
  }

}