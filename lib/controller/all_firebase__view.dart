import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:untitled/model/my_user.dart';
import 'package:untitled/services/FirestoreHelper.dart';
import 'package:untitled/services/constants.dart';

class AllFirebaseView extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return AllFirebaseViewState();
  }

}

class AllFirebaseViewState extends State<AllFirebaseView>{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
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
            //Il y a des données
            List documents = snapshot.data!.docs;
            return ListView.builder(
                itemCount: documents.length,
                itemBuilder: (context,index){
                  MyUser monUtilisateur = MyUser(documents[index]);
                  if(monUtilisateur.id != myGlobalUser.id){
                    return ListTile(
                      leading: CircleAvatar(
                        backgroundImage: NetworkImage(monUtilisateur.avatar!),
                      ),
                      title: Text(monUtilisateur.mail),
                      trailing: const FaIcon(FontAwesomeIcons.message),

                    );
                  }
                  else{
                    return Container();
                  }

                }
            );

          }
        }
    );
  }

}