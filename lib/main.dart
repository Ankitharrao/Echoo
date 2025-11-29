import 'package:flutter/material.dart';
import 'package:voicebloom/pages/home_page.dart';
import 'package:voicebloom/pages/registration.dart';
import 'package:voicebloom/pages/welcome_page.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:voicebloom/utils/routes.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyAppStarter());
}
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MyAppStarter();
  }
}


class MyAppStarter extends StatefulWidget {
  @override
  State<MyAppStarter> createState() => _MyAppStarterState();
}

class _MyAppStarterState extends State<MyAppStarter> {
  String? name;
  int? age;
  String? gender;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    loadData();
  }

  Future<void> loadData() async {
    final prefs = await SharedPreferences.getInstance();
    name = prefs.getString("name");
    age = prefs.getInt("age");
    gender = prefs.getString("gender");

    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return const MaterialApp(
        home: Scaffold(
          body: Center(child: CircularProgressIndicator()),
        ),
      );
    }

    return MaterialApp(
      themeMode: ThemeMode.light,
      darkTheme: ThemeData(brightness: Brightness.dark),
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
        fontFamily: GoogleFonts.lato().fontFamily,
      ),
      home: (name != null && age != null && gender != null)
          ? HomePage(name: name!, age: age!, gender: gender!)
          : const WelcomePage(), // go to WelcomePage first if no prefs
      routes: {
        "/registration": (context) => const Registration(),
        MyRoutes.homeRoute: (context) {
          final args = ModalRoute.of(context)!.settings.arguments
          as Map<String, dynamic>;
          return HomePage(
            name: args['name'],
            age: args['age'],
            gender: args['gender'],
          );
        },
      },
    );
  }
}
