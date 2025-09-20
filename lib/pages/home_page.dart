import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final FlutterTts flutterTts = FlutterTts();
  final List<Map<String,String>> items =[
    {"images":"assets/images/food.png","text":"Food"},
    {"images":"assets/images/hygiene.png","text":"Hygiene"},
    {"images":"assets/images/family.png","text":"Family"},


  ];
  Future<void> _speak(String text) async{
    await flutterTts.setLanguage("en-IN");
    await flutterTts.setPitch(1.0);
    await flutterTts.setSpeechRate(0.5);
    await flutterTts.speak(text);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text("echo"),
        backgroundColor: Colors.blue,
      ),
      body: PageView.builder(
          itemCount: items.length,
          itemBuilder: (context,index){
            final item=items[index];
            return GestureDetector(
              onTap: ()=> _speak(item["text"]!),
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

                        ElevatedButton.icon(onPressed: ()=>_speak("I want " + item["text"]!), icon: Icon(Icons.check),label:Text("yes"),
                            style: ElevatedButton.styleFrom(backgroundColor: Colors.green)),
                        ElevatedButton.icon(onPressed: ()=>_speak(item["text"]!), icon: Icon(Icons.volume_up),label:Text("speak")),
                        ElevatedButton.icon(onPressed: ()=>_speak("I don't want" + item["text"]!), icon: Icon(Icons.do_not_disturb_alt_outlined),label:Text("no"),
                        style: ElevatedButton.styleFrom(backgroundColor: Colors.red)),
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
