//import 'package:flutter/cupertino.dart';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:untitled/View/dashboard_view.dart';
//import 'package:untitled/View/profile_page.dart';
import 'package:untitled/services/FireStoreHelper.dart';
import 'package:untitled/services/constants.dart';

class RegisterView extends StatefulWidget{

  @override
  RegisterViewState createState() => RegisterViewState();
}

class RegisterViewState extends State<RegisterView> {
  TextEditingController? nom = TextEditingController();
  TextEditingController? prenom = TextEditingController();
  TextEditingController? mail = TextEditingController();
  TextEditingController? password = TextEditingController();
  bool genre = true;
  popUp(){
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context){
          if(Platform.isAndroid){
            return  AlertDialog(
              title: const Text("erreur"),
              content: const Text("Votre adresse ou mot de passe n'est pas valide"),
              actions: [
                TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    }, child: const Text("Ok"))
              ],
            );
          }
          else
          {
            return CupertinoAlertDialog(
              title: const Text("erreur"),
              content: const Text("Votre adresse ou mot de passe n'est pas valide"),
              actions: [
                TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    }, child: const Text("Ok"))
              ],
            );
          }
        }
    );
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      body: bodyPage(),
    );
  }

  Widget bodyPage(){
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        children: [
          TextField(
            controller: nom,
            decoration: const InputDecoration(
                hintText: "Entrer votre nom"
            ),
          ),
          const SizedBox(height: 10,),
          TextField(
            controller: prenom,
            decoration: const InputDecoration(
                hintText: "Entrer votre prenom"
            ),
          ),
          const SizedBox(height: 10,),
          TextField(
            controller: mail,
            decoration: const InputDecoration(
                hintText: "Entrer votre adresse mail"
            ),
          ),
          TextField(
            controller: password,
            decoration: const InputDecoration(
                hintText: "Entrer votre mot de passe"
            ),
            obscureText: true,
          ),
          const SizedBox(height: 10,),
          SwitchListTile(
              title: const Text("Masculin ou Féminin"),
              value: genre,
              onChanged: (bool s){
                setState(() {
                  genre = s;
                  print(genre);
                });
              }
          ),
          const SizedBox(height: 10,),
          ElevatedButton(
              onPressed: () {
                FireStoreHelper().register(nom!.text, prenom!.text, mail!.text, password!.text, genre).then((value){
                  myGlobalUser = value;
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return DashboardView();
                  }));
                }).catchError((onError){
                  popUp();
                });
              }, child: const Text("Inscription")
          )
        ],
      ),
    ) ;
  }
}