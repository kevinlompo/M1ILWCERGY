import 'dart:io';
import 'package:flutter/material.dart';
import 'package:untitled/model/my_user.dart';
import 'package:untitled/services/constants.dart';
import '../services/FireStoreHelper.dart';
import 'AllFirebase_View.dart';

class DetailViewController extends StatefulWidget {
  MyUser monUtilisateur;
  DetailViewController({Key? key, required this.monUtilisateur}) : super(key: key);
  @override
  State<DetailViewController> createState() => _DetailViewControllerState();

}

class _DetailViewControllerState extends State<DetailViewController> {
  File? imageFile;
  TextEditingController? nom = TextEditingController();
  /* Map<String,dynamic> map = {
    "NOM":nom!.text
  };*/

  @override
  // TODO: implement widget
  DetailViewController get widget => super.widget;

  @override
  Widget build(BuildContext context) {
    double imageSize = MediaQuery.of(context).size.width /4;
    return Scaffold(
        body: Center(
          child: bodyPage(imageSize),
        )
    );
  }

  Widget bodyPage(double imageSize){
    return Card(
        color: Colors.teal.shade100,
        elevation: 10,
        child: Center(
            child:   Container(
                width: MediaQuery.of(context).size.width,
                margin: const EdgeInsets.all(10),
                padding: const EdgeInsets.only(top: 50),
                child: Column(
                  children: [
                    Center(
                        child: Text(widget.monUtilisateur.nom)
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          width: MediaQuery.of(context).size.width / 4,
                          child: (imageFile == null)
                              ? Image.network(widget.monUtilisateur.avatar!, height: imageSize, width: imageSize,)
                              : Image.file(imageFile!, height: imageSize, width: imageSize,),
                        ),
                        Column(
                          children: [
                            Text("Genre: ${widget.monUtilisateur.genderString()}"),
                          ],
                        )
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        ElevatedButton(
                            onPressed: () {
                              showDialog(
                                  context: context,
                                  barrierDismissible: false,
                                  builder: (context){
                                    return   AlertDialog(
                                      title:  const Text('UPDATE'),
                                      content:  const Text('Modifier le nom'),
                                      actions: [
                                        TextField(
                                          controller: nom,
                                        ),
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                          children: [
                                            TextButton(
                                                onPressed: (){
                                                  //Retour en arrière sur le context  appelant
                                                  Navigator.pop(context);
                                                },
                                                child: const Text("Annulation")
                                            ),
                                            TextButton(
                                                onPressed: () {
                                                  FireStoreHelper().updateUsingController(widget.monUtilisateur.id, nom); //'NOM' : nom!.text
                                                  Navigator.pop(context);
                                                  Navigator.pop(context);
                                                }, child: const Text("Ok")
                                            )
                                          ],
                                        )
                                      ],
                                    );
                                  }
                              );
                            },
                            child: const Text('Update')
                        ),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.red
                          ),
                          onPressed: () {
                            showDialog(
                                context: context,
                                barrierDismissible: false,
                                builder: (context){
                                  return   AlertDialog(
                                    title:  const Text('DELETE'),
                                    content:  const Text('Souhaitez-vous supprimer cet utilisateur ?'),
                                    actions: [
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                        children: [
                                          TextButton(
                                              onPressed: (){
                                                //Retour en arrière sur le context  appelant
                                                Navigator.pop(context);
                                              },
                                              child: const Text("Annulation")
                                          ),
                                          TextButton(
                                              onPressed: () {
                                                FireStoreHelper().deleteUserWithUid(widget.monUtilisateur.id);
                                                if(myGlobalUser.favoris!.contains(widget.monUtilisateur.id)){
                                                  myGlobalUser.favoris!.remove(widget.monUtilisateur.id);
                                                  FireStoreHelper().updateFavoris(myGlobalUser);
                                                }
                                                Navigator.pop(context);
                                                Navigator.pop(context);
                                                },
                                              child: const Text("Validation")
                                          )
                                        ],
                                      ),
                                    ],
                                  );
                                }
                            );
                          }, child: const Text('Delete'),
                        ),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.green
                          ),
                          onPressed: () {
                            showDialog(
                                context: context,
                                barrierDismissible: false,
                                builder: (context){
                                  return   AlertDialog(
                                    title:  const Text('ADD'),
                                    content:  const Text('Souhaitez-vous ajouter cet utilisateur en favoris ?'),
                                    actions: [
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                        children: [
                                          TextButton(
                                              onPressed: (){
                                                //Retour en arrière sur le context  appelant
                                                Navigator.pop(context);
                                              },
                                              child: const Text("Annulation")
                                          ),
                                          TextButton(
                                              onPressed: () {
                                                if(!myGlobalUser.favoris!.contains(widget.monUtilisateur.id)){
                                                  myGlobalUser.favoris!.add(widget.monUtilisateur.id);
                                                  FireStoreHelper().updateFavoris(myGlobalUser);
                                                }
                                                Navigator.pop(context);
                                                Navigator.pop(context);
                                                },
                                              child: const Text("Validation")
                                          )
                                        ],
                                      ),
                                    ],
                                  );
                                }
                            );
                          }, child: const Text('Add Favoris'),
                        )
                      ],
                    )

                  ],
                )
            )
        )

    );
  }
}
