import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:untitled/View/dashboard_view.dart';
//import 'package:untitled/View/profile_page.dart';
import 'package:untitled/View/register_view.dart';
import 'package:untitled/services/FireStoreHelper.dart';
import 'package:untitled/services/constants.dart';

class SocialPageView extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return SocialPageViewState();
  }

}

class SocialPageViewState extends State<SocialPageView>{
  String mail = "";
  String password = "";

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return  Scaffold(
        body:  Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text("Bienvenue dans l'ancre du massage et de la relaxation",
              style: TextStyle(
                color: Colors.black,
                fontSize: 30,
                fontWeight: FontWeight.w600
              ),
              textAlign: TextAlign.center,
              ),
               TextField(
                onChanged: (newValue){
                  mail = newValue;
                },
                decoration: const InputDecoration(
                  hintText: "Entrer une adresse mail"
                ),

              ),
               TextField(
                onChanged: (value){
                  password = value;
                },
                decoration: const InputDecoration(
                    hintText: "Entrer un mot de passe",
                ),
                 obscureText: true,
              ),
              const SizedBox(height: 10,),

              ElevatedButton(onPressed: (){
                FireStoreHelper().connect(mail, password).then((value){
                  myGlobalUser = value;
                    Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return DashboardView();
                  }));
                }).catchError((onError){

                });
              }, child: const Text("Connexion")),
              const SizedBox(height: 10,),
              ElevatedButton.icon(
                icon: const FaIcon(FontAwesomeIcons.google),
                  onPressed: (){

              }, label: const Text("Google")),
              const SizedBox(height: 10,),
              ElevatedButton.icon(
                  icon: const FaIcon  (FontAwesomeIcons.facebook),
                  onPressed: (){

              }, label: const Text("Facebook")),
              const SizedBox(height: 10,),
              TextButton(onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context){
                  return RegisterView();
                }));

              }, child: const Text("Inscription"))
            ],
          )
          ,
        )
    );
  }

}