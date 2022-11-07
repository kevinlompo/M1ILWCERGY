import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:untitled/controller/all_firebase__view.dart';
import 'package:untitled/services/constants.dart';

class DashboardView extends StatefulWidget {
  @override
  DashbordViewState createState()=> DashbordViewState();

}

class DashbordViewState extends State<DashboardView> {
  int pageIndex = 0;
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: const Text("Dashbord", style: TextStyle(
            fontWeight: FontWeight.w500,
            fontSize: 24
        ),),
      ),
      body:  AllFirebaseView(),//bodyPage(pageIndex),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: pageIndex,
        onTap: (value) {
          setState(() {
            pageIndex = value;
          });
        },
        items: const [
          BottomNavigationBarItem(
              icon: FaIcon(FontAwesomeIcons.facebook),
            label: "Facebook"
          ),
          BottomNavigationBarItem(
              icon: FaIcon(FontAwesomeIcons.google),
          label: "Google"),
          BottomNavigationBarItem(
              icon: FaIcon(FontAwesomeIcons.amazon),
          label: "Amazon"),
        ],
      ),
    );
  }

  Widget bodyPage(int pageChoix){
    switch(pageChoix){
      case 0 : return const Center(child: Text("Ma page"));
      case 1 : return const Center(child: Text("Ma deuxième page"));
      case 2 :return const Center(child: Text("Ma troisième page"));
      default: return const Center(child: Text("Aucune page"));
    }
    return Center(
      child: SizedBox(
        height: 100,
        width: 300,
        child: Image.network(avatarDeafult),
      ),
    );
  }
}