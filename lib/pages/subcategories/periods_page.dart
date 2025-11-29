import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';

class PeriodsPage extends StatelessWidget {
  const PeriodsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final FlutterTts flutterTts = FlutterTts();


    String buildPositivePeriodSentence(String item) {
      switch (item) {
        case "Tampon":
          return "I need a tampon";
        case "Pad":
          return "I need a pad";
        case "Cramps":
          return "I have cramps";
        case "Hot water bag":
          return "I want a hot water bag";
        default:
          return "I want " + item;
      }
    }

    // NEGATIVE SENTENCE BUILDER
    String buildNegativePeriodSentence(String item) {
      switch (item) {
        case "Tampon":
          return "I don't need a tampon";
        case "Pad":
          return "I don't need a pad";
        case "Cramps":
          return "I don't have cramps";
        case "Hot water bag":
          return "I don't want a hot water bag";
        default:
          return "I don't want " + item;
      }
    }

    // TTS FUNCTION
    Future<void> _speak(String text) async {
      await flutterTts.setLanguage("en-IN");
      await flutterTts.setPitch(1.0);
      await flutterTts.setSpeechRate(0.5);
      await flutterTts.speak(text);
    }

    final List<Map<String, String>> periodItems = [
      {"images": "assets/images/pad.png", "text": "Pad"},
      {"images": "assets/images/tampoon.png", "text": "Tampon"},
      {"images": "assets/images/cramps.png", "text": "Cramps"},
      {"images": "assets/images/hotwaterbag.png", "text": "Hot water bag"},
    ];

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text("Periods"),
        backgroundColor: Colors.orange,
      ),
      body: PageView.builder(
        itemCount: periodItems.length,
        itemBuilder: (context, index) {
          final item = periodItems[index];

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
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [

                      ElevatedButton.icon(
                        onPressed: () => _speak(
                          buildPositivePeriodSentence(item["text"]!),
                        ),
                        icon: const Icon(Icons.check),
                        label: const Text("yes"),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.green,
                        ),
                      ),

                      const SizedBox(width: 20),

                      // SPEAK BUTTON
                      ElevatedButton.icon(
                        onPressed: () => _speak(item["text"]!),
                        icon: const Icon(Icons.volume_up),
                        label: const Text("Speak"),
                      ),

                      const SizedBox(width: 20),

                      // NO BUTTON - NEGATIVE SENTENCE
                      ElevatedButton.icon(
                        onPressed: () => _speak(
                          buildNegativePeriodSentence(item["text"]!),
                        ),
                        icon: const Icon(Icons.do_not_disturb_alt_outlined),
                        label: const Text("no"),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.red,
                        ),
                      ),
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
