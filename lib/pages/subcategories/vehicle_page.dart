import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
class VehiclePage extends StatelessWidget {
  const VehiclePage({super.key});

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
      {"images": "assets/images/bus.png", "text": "Bus"},
      {"images": "assets/images/van.png", "text": "Van"},
      {"images": "assets/images/bike.png", "text": "Bike"},
      {"images": "assets/images/cycle.png", "text": "Cycle"},
      {"images": "assets/images/train.png", "text": "Train"},
      {"images": "assets/images/metro.png", "text": "metro"},
    ];

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text("Vehicle"),
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
                      ElevatedButton.icon(onPressed: ()=>_speak("I want to go in " + item["text"]!), icon: Icon(Icons.check),label:Text("yes"),
                          style: ElevatedButton.styleFrom(backgroundColor: Colors.green)),
                      ElevatedButton.icon(
                        onPressed: () => _speak(item["text"]!),
                        icon: const Icon(Icons.volume_up),
                        label: const Text("Speak"),
                      ),
                      ElevatedButton.icon(onPressed: ()=>_speak("I don't want to go in " + item["text"]!), icon: Icon(Icons.do_not_disturb_alt_outlined),label:Text("no"),
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