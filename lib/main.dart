import 'package:flutter/material.dart';
import 'package:voicebloom/pages/home_page.dart';
import 'package:voicebloom/pages/registration.dart';
import 'package:voicebloom/pages/welcome_page.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:voicebloom/utils/routes.dart';

void main(){
  runApp(myApp());
}
class myApp extends StatelessWidget {
  const myApp({super.key});


  @override
  Widget build(BuildContext context) {

    return MaterialApp(

      themeMode: ThemeMode.light,
      darkTheme: ThemeData(
        brightness: Brightness.dark,

      ),
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
        fontFamily: GoogleFonts.lato().fontFamily,

      ),

        initialRoute: "/welcome",
        routes: {
        "/": (context) => Registration(),
          MyRoutes.homeRoute: (context) =>HomePage(),
          "/welcome": (context)=>WelcomePage(),
    },

      
    );
  }
}



