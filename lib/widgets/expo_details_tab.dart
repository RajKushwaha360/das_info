import 'package:das_info/screens/expo_screen.dart';
import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';

class ExpoDetailsTab extends StatelessWidget {
  const ExpoDetailsTab({Key? key}) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(10),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "ASIAN AGRICULTURE EXPO",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                ),
                IconButton(onPressed: () {}, icon: Icon(Icons.edit))
              ],
            ),
            SizedBox(
              height: 5,
            ),
            Text(
                "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nam porta sagittis nibh vitae vestibulum. Sed et dui pellentesque, sagittis augue nec, fringilla odio. Nullam sem felis, finibus ut consectetur eu, volutpat lobortis urna. "),
            SizedBox(
              height: 15,
            ),
            Text(
              "Mobile Number",
              style: TextStyle(fontWeight: FontWeight.w500, fontSize: 16),
            ),
            SizedBox(
              height: 5,
            ),
            Text(
              "+911234567890",
            ),
            SizedBox(
              height: 15,
            ),
            Text(
              "Mail ID",
              style: TextStyle(fontWeight: FontWeight.w500, fontSize: 16),
            ),
            SizedBox(
              height: 5,
            ),
            Text("abc@xyz.com"),
            SizedBox(
              height: 15,
            ),
            Text(
              "Address",
              style: TextStyle(fontWeight: FontWeight.w500, fontSize: 16),
            ),
            SizedBox(
              height: 5,
            ),
            Text("Room no. 2106, VGEC Boys Hostel-2, Chandkheda"),
            SizedBox(
              height: 15,
            ),
            Text(
              "Predefine Message",
              style: TextStyle(fontWeight: FontWeight.w500, fontSize: 16),
            ),
            SizedBox(
              height: 5,
            ),
            Text("Thanks for visiting our agro boot"),
            SizedBox(
              height: 15,
            ),
          ],
        ),
      ),
    );
  }
}
