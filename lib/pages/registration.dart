import "package:flutter/material.dart";
import "package:voicebloom/utils/routes.dart";
import 'package:shared_preferences/shared_preferences.dart';

class Registration extends StatefulWidget {
  const Registration({super.key});

  @override
  State<Registration> createState() => _RegistrationState();
}

class _RegistrationState extends State<Registration> {
  String name = "";
  String? selectedGender = "";
  int? age;
  final _formKey = GlobalKey<FormState>();
  Future<void> saveUserData() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString("name", name);
    await prefs.setInt("age", age ?? 0);
    await prefs.setString("gender", selectedGender ?? "");
    await prefs.setBool("isRegistered", true);
  }

  moveToHome(BuildContext context) async{
    if (_formKey.currentState!.validate()) {
      await saveUserData();
      Navigator.pushNamed(
        context,
        MyRoutes.homeRoute,
        arguments: {
          "name": name,
          "age": age,
          "gender": selectedGender,
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFE7F2FF), // Soft pastel blue background
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 40),

              // Cute Icon
              const Icon(
                Icons.record_voice_over,
                size: 90,
                color: Colors.blueAccent,
              ),

              const SizedBox(height: 10),

              // Title
              Text(
                "Registration Form",
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  color: Colors.blueAccent.shade700,
                ),
              ),

              const SizedBox(height: 5),

              Text(
                "Welcome $name",
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w500,
                  color: Colors.black54,
                ),
              ),

              const SizedBox(height: 30),

              // Rounded Card
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.blueAccent.withOpacity(0.15),
                      blurRadius: 15,
                      spreadRadius: 2,
                      offset: const Offset(0, 4),
                    )
                  ],
                ),
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      // Name Field
                      TextFormField(
                        decoration: InputDecoration(
                          hintText: "Enter child name",
                          labelText: "Name",
                          filled: true,
                          fillColor: const Color(0xFFF7FBFF),
                          prefixIcon: const Icon(Icons.person, color: Colors.blueAccent),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Enter the child name";
                          }
                          return null;
                        },
                        onChanged: (value) {
                          name = value;
                          setState(() {});
                        },
                      ),

                      const SizedBox(height: 20),

                      // Gender Dropdown
                      DropdownButtonFormField<String>(
                        decoration: InputDecoration(
                          labelText: "Gender",
                          filled: true,
                          fillColor: const Color(0xFFF7FBFF),
                          prefixIcon: const Icon(Icons.wc, color: Colors.blueAccent),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                        ),
                        items: ["male", "female"].map((gender) {
                          return DropdownMenuItem(
                            value: gender,
                            child: Text(gender),
                          );
                        }).toList(),
                        onChanged: (value) {
                          selectedGender = value;
                        },
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Enter gender";
                          }
                          return null;
                        },
                      ),

                      const SizedBox(height: 20),

                      // Age Field
                      TextFormField(
                        decoration: InputDecoration(
                          hintText: "Enter child age",
                          labelText: "Age",
                          filled: true,
                          fillColor: const Color(0xFFF7FBFF),
                          prefixIcon: const Icon(Icons.cake, color: Colors.blueAccent),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                        ),
                        keyboardType: TextInputType.number,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Enter the child age";
                          }
                          return null;
                        },
                        onChanged: (value) {
                          age = int.tryParse(value);
                        },
                      ),

                      const SizedBox(height: 35),

                      // Button
                      SizedBox(
                        width: double.infinity,
                        height: 55,
                        child: ElevatedButton(
                          onPressed: () => moveToHome(context),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.blueAccent,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15),
                            ),
                          ),
                          child: const Text(
                            "Login",
                            style: TextStyle(fontSize: 20, color: Colors.white),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }
}