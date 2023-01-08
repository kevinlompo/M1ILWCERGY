import 'package:flutter/material.dart';
import 'package:untitled/delay_animation.dart';
import 'package:untitled/firebase_options.dart';
import 'package:untitled/services/permission_handler.dart';
import 'package:untitled/social_page.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  PermissionHandler().start();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(

        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
      debugShowCheckedModeBanner: false,

    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {


  @override
  Widget build(BuildContext context) {

    return Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.transparent,
        ),
        backgroundColor: Colors.purpleAccent,
        body: Padding(
          padding: const EdgeInsets.all(20),
          child: SingleChildScrollView(
            child: Center(
              child: Column(
                children: [


                  DelayAnimation(
                      duration: 2000,
                      child: Image.asset("assets/images/logo.png",width: 150,height: 150,)),
                  const SizedBox(height: 15,),
                  DelayAnimation(
                      duration: 3000,
                      child: Image.asset("assets/images/fond.png",width: 350,height: 350,)
                  ),
                  const SizedBox(height: 15,),
                  DelayAnimation(
                    duration: 4000,
                    child: const Text("Bievenue dans l'antre du bien être et de la relaxation",
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 30,
                          fontWeight: FontWeight.w600
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),

                  const SizedBox(height: 15,),
                  DelayAnimation(

                    duration: 5000,
                    child: SizedBox(
                      height: 40,
                      width: double.infinity,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            primary: Colors.red,
                            shape: const StadiumBorder()
                        ),
                        onPressed: (){
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context)=>SocialPageView()));
                        },
                        child: const Text("Bienvenue"),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        )


    );
  }
}