import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:untitled/model/my_user.dart';
import 'dart:io';
import '../services/FireStoreHelper.dart';
import '../services/constants.dart';

class ProfilePage extends StatefulWidget {
  @override
  ProfilePageState createState() => ProfilePageState();
}

class ProfilePageState extends State<ProfilePage> {
  TextEditingController? nom = TextEditingController();
  ImagePicker picker = new ImagePicker();
  File? imageFile;

  @override
  Widget build(BuildContext context) {
    double imageSize = MediaQuery.of(context).size.width /4;
    return StreamBuilder<QuerySnapshot>(
        stream: FireStoreHelper().cloudUsers.snapshots(),
        builder: (context,snapshot){
          if(!snapshot.hasData){
            //Il n'y a pas de donnée dans Firebase
            return const Center(
                child: CircularProgressIndicator()
            );
          }
          else
          {
            List documents = snapshot.data!.docs;
            final docUser = FirebaseFirestore.instance.collection('UTILISATEURS').doc('MprP723hixSdFQ6QR7coth6gCku2');


            return ListView.builder(
                itemCount: documents.length,
                itemBuilder: (context,index){
                  MyUser monUtilisateur = MyUser(documents[index]);
                  if(monUtilisateur.id != myGlobalUser.id){
                    return Card(
                      color: Colors.teal.shade100,
                      elevation: 10,
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        margin: const EdgeInsets.all(10),
                        padding: const EdgeInsets.all(8),
                        child: Column(
                          children: [
                            Text(documents[index]['NOM']),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  width: MediaQuery.of(context).size.width / 3.5,
                                  child: (imageFile == null)
                                      ? Image.network(avatarDeafult, height: imageSize, width: imageSize,)
                                      : Image.file(imageFile!, height: imageSize, width: imageSize,),
                                ),
                                Column(
                                  children: [
                                    Text("Genre: ${monUtilisateur.genderString()}"),
                                  ],
                                )
                              ],
                            ),
                            SwitchListTile(
                                title: const Text("Changer le genre"),
                                value: documents[index]['GENRE'],
                                onChanged: (bool s){
                                  setState(() {
                                    monUtilisateur.genre = s;
                                    //documents[index]["GENRE"] = monUtilisateur.genre;
                                    print(documents[index]['GENRE']);
                                    //setGenre(documents[index], s, docUser);
                                    docUser.update({
                                      'GENRE': s,
                                    });
                                  });
                                }
                            ),
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
                                            TextButton(
                                                onPressed: () {
                                                //FireStoreHelper().updateUser(, 'NOM':nom!.text); //'NOM' : nom!.text
                                                  Navigator.pop(context);
                                                }, child: const Text("Ok")),
                                          ],
                                        );
                                      }
                                  );
                                },
                                child: const Text('Update')),


   Switch(
                                value: monUtilisateur.genre,
                                onChanged: ((bool newBool) {
                                  monUtilisateur.genre = newBool;
                                  documents[index]["GENRE"] = newBool;
                                  setState(() {
                                    final docUser = FirebaseFirestore.instance.collection("UTILISATEURS").doc("U8Thk4Sl6rUI2rxvmlSyJV7xP5x1");

                                    docUser.update({
                                      "GENRE":newBool,
                                      "MAIL":documents[index]["MAIL"],
                                      "NOM":documents[index]["NOM"],
                                      "PRENOM":documents[index]["PRENOM"]
                                    });

                                  });
                                }))
,
                          ],
                        ),
                      ),
                    );
                  }
                  else
                  {
                    return Container();
                  }
                }
            );
          }
        }
    );

  }

/* Future<void> setGenre(MyUser user, bool newBool, DocumentReference<Map<String, dynamic>> ) async {
   docUser.update()
  }
*/
}
