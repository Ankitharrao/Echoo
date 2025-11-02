import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:voicebloom/pages/subcategories/family_page.dart';
import 'package:voicebloom/pages/subcategories/food_page.dart';
import 'package:voicebloom/pages/subcategories/activity_page.dart';

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
      {"images": "assets/images/hygiene.png", "text": "Activity"},
      {"images": "assets/images/family.png", "text": "Family"},
    ]);

    // Conditionally add "Periods"
    if (widget.age > 10 && widget.gender.toLowerCase() == 'female') {
      items.add({"images": "assets/images/food.png", "text": "Periods"});
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
  @override
  Widget build(BuildContext context) {
    //final String name;




    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(widget.name),
        backgroundColor: Colors.blue,
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

                        ElevatedButton.icon(onPressed: ()=>_speak("I want " + item["text"]!), icon: Icon(Icons.check,size:32),label:Text("yes",style: TextStyle(fontSize: 22,fontWeight: FontWeight.bold)),
                            style: ElevatedButton.styleFrom(backgroundColor: Colors.green,
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                            padding: const EdgeInsets.symmetric(horizontal:28,vertical:15))),
                        SizedBox(width: 40.0,),

                        ElevatedButton.icon(onPressed: ()=>_speak("I don't want" + item["text"]!), icon: Icon(Icons.do_not_disturb_alt_outlined,size: 32,),label:Text("no",style: TextStyle(fontSize: 22,fontWeight: FontWeight.bold)),
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
      drawer: Drawer(),
    );
  }
}

