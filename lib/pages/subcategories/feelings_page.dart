import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
class FeelingsPage extends StatelessWidget {
  const FeelingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final FlutterTts flutterTts = FlutterTts();

    Future<void> _speak(String text) async {
      await flutterTts.setLanguage("en-IN");
      await flutterTts.setPitch(1.0);
      await flutterTts.setSpeechRate(0.5);
      await flutterTts.speak(text);
    }

    final List<Map<String, String>> foodItems = [
      {"images": "assets/images/happy.png", "text": "Happy"},
      {"images": "assets/images/sad.png", "text": "Sad"},
      {"images": "assets/images/angry.png", "text": "Angry"},
      {"images": "assets/images/disgusted.png", "text": "Disgusted"},
      {"images": "assets/images/excited.png", "text": "Excited"},


    ];

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text("Feelings"),
        backgroundColor: Colors.orange,
      ),
      body: PageView.builder(
        itemCount: foodItems.length,
        itemBuilder: (context, index) {
          final item = foodItems[index];
          return GestureDetector(
            onTap: () => _speak(item["text"]!),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 400,
                    child: Image.asset(
                      item["images"]!,
                      fit: BoxFit.cover,
                    ),
                  ),
                  const SizedBox(height: 30),
                  Text(
                    item["text"]!,
                    style: const TextStyle(
                      fontSize: 26,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 30),
                  Row(
                    mainAxisAlignment:MainAxisAlignment.center,
                    children: [
                      ElevatedButton.icon(onPressed: ()=>_speak("I am " + item["text"]!), icon: Icon(Icons.check),label:Text("yes"),
                          style: ElevatedButton.styleFrom(backgroundColor: Colors.green)),
                      ElevatedButton.icon(
                        onPressed: () => _speak(item["text"]!),
                        icon: const Icon(Icons.volume_up),
                        label: const Text("Speak"),
                      ),
                      ElevatedButton.icon(onPressed: ()=>_speak("I am not " + item["text"]!), icon: Icon(Icons.do_not_disturb_alt_outlined),label:Text("no"),
                          style: ElevatedButton.styleFrom(backgroundColor: Colors.red)),
                    ],
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}