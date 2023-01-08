import 'dart:typed_data';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:untitled/services/FireStoreHelper.dart';
import 'package:untitled/services/constants.dart';
import 'package:file_picker/file_picker.dart';

class MyDrawer extends StatefulWidget {
  const MyDrawer({Key? key}) : super(key: key);

  @override
  State<MyDrawer> createState() => _MyDrawerState();
}

class _MyDrawerState extends State<MyDrawer> {

  //variable
  String? nameImage;
  String? urlImage;
  Uint8List? bytesData;



  //Méthode interne fonction

  pickerImage() async {
    //récupération des informations de l'image
    FilePickerResult? resulat = await FilePicker.platform.pickFiles(
      type: FileType.image,
      withData: true,
    );
    //vérifier si l'utilisateur a cliqué sur une image
    if(resulat != null){
      nameImage = resulat.files.first.name;
      bytesData = resulat.files.first.bytes;
      //Lancer une boite de dialogue
      MyDialog();
    }

  }

  //Création de la boite de dialogue pour l'affichage de l'image
  MyDialog(){
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context){
          if(Platform.isAndroid){
            return AlertDialog(
              title: const Text("Souhaitez-vous enregister cette photo ?"),
              content: Image.memory(bytesData!),
              actions: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    TextButton(
                        onPressed: (){
                          //Retour en arrière sur le context  appelant
                          Navigator.pop(context);
                        },
                        child: Text("Annulation")),
                    TextButton(
                        onPressed: () async {
                          urlImage = await FireStoreHelper().stockageImage(nameImage!, bytesData!);
                          setState(() {
                            myGlobalUser.avatar = urlImage!;
                          });
                          //Enregistrement de la photo sur le serveur
                          Map<String,dynamic> map = {
                            "AVATAR":urlImage
                          };
                          FireStoreHelper().updateUser(myGlobalUser.id, map);
                          Navigator.pop((context));
                        },
                        child: Text("Validation")
                    )
                  ],
                ),
              ],
            );
          }
          else
          {
            return CupertinoAlertDialog(
              title: const Text("Souhaitez-vous enregister cette photo ?"),
              content: Image.memory(bytesData!),
              actions: [
                TextButton(
                    onPressed: (){
                      //Retour en arrière sur le context  appelant
                      Navigator.pop(context);
                    },
                    child: Text("Annulation")),
                TextButton(
                    onPressed: (){
                      //Enregistrement de la photo sur le serveur

                    },
                    child: Text("Validation")
                ),
              ],

            );

          }

        }
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(

      children: [
        SizedBox(height: MediaQuery.of(context).size.height/8),
        //Afficher le logo/image
        InkWell(
          //Inkweel est le widget qui rend tout widget cliquable
          child: CircleAvatar(
            radius: 80,
            backgroundImage: NetworkImage(myGlobalUser.avatar!),
          ),
          onTap: (){
            //Appeler les éléemnts dans la librairie
            pickerImage();

          },
        ),
        const SizedBox(height: 10,),



        //Afficher le mail
        Text(myGlobalUser.mail),
        const SizedBox(height: 10,),


        // Pseudo
        Text(myGlobalUser.pseudo!),
        const SizedBox(height: 10,),

        //Afficher le nom et prénom de l'utilsateur

        Text(myGlobalUser.fullName),
        const SizedBox(height: 10,),

        //Text("${myGlobalUser.prenom} ${myGlobalUser.nom}") cette ligne est identique à la ligne précédente





      ],
    );
  }
}