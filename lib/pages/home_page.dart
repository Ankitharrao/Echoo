import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:voicebloom/pages/senses_page.dart';
import 'package:voicebloom/pages/subcategories/colors_page.dart';
import 'package:voicebloom/pages/subcategories/family_page.dart';
import 'package:voicebloom/pages/subcategories/feelings_page.dart';
import 'package:voicebloom/pages/subcategories/food_page.dart';
import 'package:voicebloom/pages/subcategories/activity_page.dart';
import 'package:voicebloom/pages/subcategories/helpers_page.dart';
import 'package:voicebloom/pages/subcategories/periods_page.dart';
import 'package:voicebloom/pages/subcategories/places_page.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:voicebloom/pages/subcategories/room_page.dart';
import 'package:voicebloom/pages/subcategories/vehicle_page.dart';

import '../main.dart';


class HomePage extends StatefulWidget {
  final String name;
  final int age;
  final String gender;
  const HomePage({super.key,required this.name,required this.age,required  this.gender});




  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final FlutterTts flutterTts = FlutterTts();
  final List<Map<String, String>> items = [];

  @override
  void initState() {
    super.initState();

    // Add common items
    items.addAll([
      {"images": "assets/images/food.png", "text": "Food"},
      {"images": "assets/images/activity.png", "text": "Activity"},
      {"images": "assets/images/family.png", "text": "Family"},
      {"images": "assets/images/places.png", "text": "Places"},
      {"images": "assets/images/feelings.png", "text": "Feelings"},
      {"images": "assets/images/rooms.png", "text": "Room"},
      {"images": "assets/images/colors.png", "text": "Colors"},
      {"images": "assets/images/vehicle.png", "text": "Vehicle"},
      {"images": "assets/images/senses.jpeg", "text": "Sense"},
      {"images": "assets/images/communityhelpers.png", "text": "Helpers"},
    ]);

    // Conditionally add "Periods"
    if (widget.age > 10 && widget.gender.toLowerCase() == 'female') {
      items.add({"images": "assets/images/periods.png", "text": "Periods"});
    }
  }
  String buildSentence(String category) {
    if (category == "Places") {
      return "I want to go to " + category;
    } else if (category == "Rooms") {
      return "I want to go to " + category;
    }
    else if (category == "Periods") {
      return "I have " + category;
    }
    else if (category == "Activity") {
      return "I want to do " + category;
    }
    else if (category == "Feelings") {
      return "I have " + category;
    }
    else if (category == "Sense") {
      return "I want to " + category;
    }
    else if (category == "Vehicle") {
      return "I want to go in " + category;
    }else {
      return "I want " + category;
    }
  }
  String buildNegativeSentence(String category) {
    if (category == "Places") {
      return "I don't want to go to " + category;
    } else if (category == "Rooms") {
      return "I don't want to go to " + category;
    } else if (category == "Periods") {
      return "I don't have " + category;
    } else if (category == "Activity") {
      return "I don't want to do " + category;
    } else if (category == "Feelings") {
      return "I don't have " + category;
    } else if (category == "Sense") {
      return "I don't want to " + category;
    } else if (category == "Vehicle") {
      return "I don't want to go in " + category;
    } else {
      return "I don't want " + category;
    }
  }





  Future<void> _speak(String text) async{
    await flutterTts.stop();
    await flutterTts.setLanguage("en-IN");
    await flutterTts.setPitch(1.0);
    await flutterTts.setSpeechRate(0.5);
    await flutterTts.speak(text);
  }
  void _navigateToCategory(String category) {
    Widget page;
    switch (category) {
      case "Food":
        page = const FoodPage();
        break;
      case "Activity":
        page = const ActivityPage();
        break;
      case "Family":
        page = const FamilyPage();
        break;
      case "Places":
        page = const PlacesPage();
        break;
      case "Room":
        page = const RoomPage();
        break;
      case "Vehicle":
        page = const VehiclePage();
        break;
      case "Sense":
        page = const SensesPage();
        break;
      case "Helpers":
        page = const HelpersPage();
        break;
      case "Colors":
        page = const ColorsPage();
        break;
      case "Periods":
        page = const PeriodsPage();
        break;
      case "Feelings":
        page = const FeelingsPage();
        break;
      default:
        page = Scaffold(body: Center(child: Text("Page not found")));
    }

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => page,
      ),
    );
  }
  Future<void> logoutUser() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.clear(); // clear saved name/age/gender

    // Go back to start and rebuild app
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => MyAppStarter()),
          (route) => false, // remove all previous routes
    );
  }
  @override
  Widget build(BuildContext context) {
    //final String name;




    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text("Hello " + widget.name),
        backgroundColor: Colors.blue,
        actions: [
          IconButton(
            icon: Icon(Icons.logout),
            onPressed: logoutUser,
          ),
        ],
      ),
      body: PageView.builder(
          itemCount: items.length,
          itemBuilder: (context,index){
            final item=items[index];
            return GestureDetector(
              onTap: ()=> _speak(item["text"]!),
              onVerticalDragEnd: (details){
                if(details.primaryVelocity!<0){
                  _navigateToCategory(item["text"]!);
                }
              },
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(item["images"]!,height: 400,),
                    SizedBox(height: 40.0,),
                    Text(item["text"]!,style: TextStyle(fontSize: 28,fontWeight:FontWeight.bold ),),
                    SizedBox(height: 40.0,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,

                      children: [

                        ElevatedButton.icon(onPressed: ()=>_speak(buildSentence(item["text"]!)), icon: Icon(Icons.check,size:32),label:Text("yes",style: TextStyle(fontSize: 22,fontWeight: FontWeight.bold)),
                            style: ElevatedButton.styleFrom(backgroundColor: Colors.green,
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                            padding: const EdgeInsets.symmetric(horizontal:28,vertical:15))),
                        SizedBox(width: 40.0,),

                        ElevatedButton.icon(onPressed: ()=>_speak(buildNegativeSentence(item["text"]!)), icon: Icon(Icons.do_not_disturb_alt_outlined,size: 32,),label:Text("no",style: TextStyle(fontSize: 22,fontWeight: FontWeight.bold)),
                        style: ElevatedButton.styleFrom(backgroundColor: Colors.red,shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                            padding: const EdgeInsets.symmetric(horizontal:28,vertical:15))),
                      ],
                    ),


                  ],

                ),
              ),

            );


      }
      ),

    );
  }
}

