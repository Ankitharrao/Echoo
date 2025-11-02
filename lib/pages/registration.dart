import "package:flutter/material.dart";
import "package:voicebloom/utils/routes.dart";

class Registration extends StatefulWidget {
  const Registration({super.key});

  @override
  State<Registration> createState() => _RegistrationState();
}

class _RegistrationState extends State<Registration> {
  String name= "";
  String? selectedGender="";
  int? age;
  final _formKey = GlobalKey<FormState>();
  moveToHome(BuildContext context){
    if(_formKey.currentState!.validate()) {
      Navigator.pushNamed(context, MyRoutes.homeRoute, arguments: {
        "name": name ,
        "age": age,
        "gender": selectedGender,
      },);
    }

  }
  @override
  Widget build(BuildContext context) {
    return Material(
      child: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            children:[
              SizedBox(
                height: 40.0,
              ),
              Text("Registration Form",style: TextStyle(fontSize: 30,color: Colors.blueAccent,fontWeight: FontWeight.bold),),
              Text("Welcome $name",style: TextStyle(fontSize: 20,color: Colors.blueAccent,fontWeight: FontWeight.bold),),
              SizedBox(
                height: 40.0,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 16.0,horizontal: 32.0),
                child: Column(
                  children: [
                    TextFormField(
                      decoration: InputDecoration(hintText: "Enter child name",labelText: "name",border: OutlineInputBorder()),
                      validator: (value){
                        if( value == null || value.isEmpty ){
                          return "Enter the child name";
                        }
                        return null;
                      },
                      onChanged: (value){
                        name=value;
                        setState(() {

                        });
                        },
                    ),
                    SizedBox(
                      height: 20.0,
                    ),
                    DropdownButtonFormField<String>(
                      decoration: InputDecoration(hintText: "Enter child gender",labelText: "gender",border: OutlineInputBorder()),
                        items: ["male", "female"].map((gender){
                          return DropdownMenuItem(
                            value: gender,
                            child: Text(gender),
                          );
                        }).toList(), onChanged: (value){
                          selectedGender= value;
                    },
                      validator: (value){
                        if(value==null||value.isEmpty){
                          return "Enter gender";
                        }
                        return null;
                      },


                    ),
                    SizedBox(
                      height: 20.0,
                    ),
                    TextFormField(
                      decoration: InputDecoration(hintText: "Enter child age",labelText: "age",border: OutlineInputBorder(),),
                      keyboardType: TextInputType.number,
                      validator: (value){
                        if( value == null || value.isEmpty ){
                          return "Enter the child age";
                        }
                        return null;
                      },
                      onChanged: (value){
                        age = int.tryParse(value);

                      },
                    ),


                    SizedBox(height: 50.0),
                    ElevatedButton(onPressed: ()=>moveToHome(context),
                        child: Text("login")
                    )
                  ],
                ),
              )
            ]
          ),
        ),
      )
    );
  }
}
