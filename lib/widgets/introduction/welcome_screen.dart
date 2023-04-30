import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          SizedBox(
            height: 60,
          ),
          Text(
            'Welcome to',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 30,
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Text(
            'ExpoMate',
            style: TextStyle(
              color: Color(0xFF2F58CD),
              fontWeight: FontWeight.bold,
              fontSize: 30,
            ),
          ),
          SizedBox(height: 100,),
          Image.asset('assets/images/welcomescreen.png'),
        ],
      ),
    );
  }
}
