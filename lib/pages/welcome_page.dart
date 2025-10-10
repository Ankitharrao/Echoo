import 'package:flutter/material.dart';
import 'dart:async';

import 'package:voicebloom/pages/registration.dart';
class WelcomePage extends StatefulWidget {
  const WelcomePage({super.key});

  @override
  State<WelcomePage> createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  @override
  void initState() {
    super.initState();
    Timer(Duration(seconds: 3), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => Registration()),
      );
    });
  }
  @override
  Widget build(BuildContext context) {

    return Material(
      color: Colors.white,
      child: Column(
        children: [
          SizedBox(
            height: 50.0,
          ),
          Image.asset("assets/images/voicebloom1.png",fit: BoxFit.cover,),
          SizedBox(
            height: 30.0,
          ),
          Text("  Welcome\n         To\n     Echoo",style: TextStyle(fontSize: 30,fontWeight: FontWeight.bold,color: Colors.black)),
          SizedBox(
            height: 30.0,
          ),
          Image.asset("assets/images/loading.gif",fit: BoxFit.cover,height: 200.0,),
          Text("A communication app for special need children"),


        ],
      ),
    );
  }
}
