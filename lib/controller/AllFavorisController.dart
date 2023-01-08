import 'package:flutter/material.dart';
import 'package:untitled/model/my_user.dart';
import 'package:untitled/services/FireStoreHelper.dart';
import 'package:untitled/services/constants.dart';

class AllFavorisController extends StatefulWidget {
  const AllFavorisController({Key? key}) : super(key: key);

  @override
  State<AllFavorisController> createState() => _AllFavorisControllerState();
}

class _AllFavorisControllerState extends State<AllFavorisController> {
  //variable
  MyUser stockage = MyUser.empty();
  @override
  Widget build(BuildContext context) {
    return GridView.builder (
      itemCount: myGlobalUser.favoris!.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3),
      itemBuilder: (context,index)  {
        MyUser monUtilisateur = stockageUser(index);

        return Container(
          width: 200,
          height: 200,
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: NetworkImage(monUtilisateur.avatar!)
              )
          ),
        );
      },
    );
  }

  MyUser stockageUser(int index) {

    FireStoreHelper().getUser(myGlobalUser.favoris![index]).then((value) {
      setState((){
        stockage = value;
      });
    });
    return stockage;
  }
}