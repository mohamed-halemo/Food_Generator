// Create a Form widget.
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:html/parser.dart';
import 'package:myapp/models/meal.dart';
import 'package:http/http.dart' as http;
import 'package:myapp/screens/BackGround_Image.dart';
class Add extends StatelessWidget {
  const Add({super.key});

  @override
  Widget build(BuildContext context) {
    const appTitle = 'Add Food Here';

    return MaterialApp(
      debugShowCheckedModeBanner:false,
      title: appTitle,
      home: Scaffold(
        
        appBar: AppBar(
          backgroundColor: Colors.pink,
          title: const Text(appTitle,style: TextStyle(color: Colors.white),),
        ),
        body: const MyCustomForm(),
      ),
    );
  }
}
class MyCustomForm extends StatefulWidget {
  const MyCustomForm({super.key});

  @override
  MyCustomFormState createState() {
    return MyCustomFormState();
  }
}

// Create a corresponding State class.
// This class holds data related to the form.
class MyCustomFormState extends State<MyCustomForm> {
  // Create a global key that uniquely identifies the Form widget
  // and allows validation of the form.
  //
  // Note: This is a GlobalKey<FormState>,
  // not a GlobalKey<MyCustomFormState>.
  final _formKey = GlobalKey<FormState>();
  late String food;
  MealModel NewFood = MealModel(categories:"food",name:"f",image: "https://i.imgur.com/YIxUMdR.jpeg");
  @override
  Widget build(BuildContext context) {
    // Build a Form widget using the _formKey created above.
    return Stack(
      children: [
         BackgroundImage(
          image: 'assets/images/login_bg.png',
        ),
        Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
               SizedBox(
                        height: 25,
                      ),
              TextFormField(
                style: TextStyle(color: Colors.white),
                decoration: new InputDecoration.collapsed(
                  
                        hintText: 'Enter Food Name Here',
                        hintStyle: TextStyle(fontSize: 20.0, color: Colors.white),
                    ),
                // The validator receives the text that the user has entered.
                validator: (value) {
                  food=value.toString();
                  if (value == null || value.isEmpty) {
                    return 'Please enter a food  name';
                  }
                  return null;
                },
              ),
               SizedBox(
                        height: 25,
                      ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 16.0),
                
                child: ElevatedButton(

                  onPressed: () async{
                    // Validate returns true if the form is valid, or false otherwise.
                    if (_formKey.currentState!.validate()) {
                        NewFood.name = food;
                        var meal = NewFood.toJson();
                        
                        var url = Uri.parse('http://foodrecommender.rf.gd/public/api/recommender/len');
                        final cookie = await http.get(url).timeout(const Duration(seconds: 10));
                        var document = parse(cookie.body);
                        List<String> cookieValue = document.getElementsByTagName('script')[0].innerHtml.split(';');
                        // print(cookieValue);
                        String cookieRequest = cookieValue[0].substring(17);
                        url = Uri.parse('http://foodrecommender.rf.gd/public/api/recommend/add');
                        final response = await http.post(url,headers: {'Cookie': cookieRequest,'Content-Type':'application/json; charset=UTF-8'},body: jsonEncode(meal)).timeout(const Duration(seconds: 10));
                        print(response.statusCode);
                      // If the form is valid, display a snackbar. In the real world,
                      // you'd often call a server or save the information in a database.
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Processing Data')),
                      );
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    primary: Colors.pinkAccent,
                    padding: EdgeInsets.symmetric(horizontal: 50, vertical: 20),
                    textStyle: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold)
                  ),
                  child: const Text('Submit'),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  
  }
}