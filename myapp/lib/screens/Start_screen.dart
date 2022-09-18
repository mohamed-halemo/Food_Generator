import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:myapp/home_page.dart';
import 'package:myapp/screens/Add.dart';
import '../pallete.dart';
import '../widgets.dart';
import 'BackGround_Image.dart';



class StarterScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
    
        BackgroundImage(
          image: 'assets/images/Pink.jpg',
        ),
        Scaffold(
          backgroundColor: Colors.transparent,
          body: Column(
            children: [
              const Flexible(
                child: Center(
                  child: Text(
                    'Akelny',
                    style: TextStyle(
                        color: Colors.pinkAccent,
                        fontSize: 60,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                    ElevatedButton(
                    
          child: const Text(' Add your food Now!'),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const Add()));},
              style: ElevatedButton.styleFrom(
                primary: Colors.pinkAccent,
                padding: EdgeInsets.symmetric(horizontal: 50, vertical: 20),
                textStyle: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold)
              ),
              ) ,
                 
                  SizedBox(
                    height: 25,
                  ),
                   ElevatedButton(
                    
          child: const Text('Start Recomminding'),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const HomePage()));},
              style: ElevatedButton.styleFrom(
                primary: Colors.pinkAccent,
                padding: EdgeInsets.symmetric(horizontal: 50, vertical: 20),
                textStyle: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold)
              ),
              ) ,
                  SizedBox(
                    height: 25,
                  ),
                ],
              ),
              SizedBox(
                height: 20,
              ),
            ],
          ),
        )
      ],
    );
  }
}