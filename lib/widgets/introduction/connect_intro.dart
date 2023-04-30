import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class ConnectIntro extends StatelessWidget {
  const ConnectIntro({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: 100,
            ),
            Image.asset(
              'assets/images/connect_intro.png',
            ),
            SizedBox(
              height: 60,
            ),
            Text(
              'SCAN',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 30,
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Text(
                'Stay connected! Connect with any lead',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 18,
                  
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}