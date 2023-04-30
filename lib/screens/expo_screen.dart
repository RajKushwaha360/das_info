import 'package:das_info/controller/exposcreen_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qr_flutter/qr_flutter.dart';

import '../widgets/expo_details_tab.dart';
import '../widgets/expo_leads_tab.dart';

class ExpoScreen extends StatelessWidget {
  ExpoScreen({Key? key, required this.expoKey}) : super(key: key);
  final String expoKey;

  ExpoScreenController expoScreenController = Get.put(ExpoScreenController());

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
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
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
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
                Container( 
                  color: Colors.white,
                  child: QrImage(
                    data: expoKey,
                    version: QrVersions.auto,
                    size: 320,
                    gapless: false,
                  ),
                ),
                ElevatedButton(
                    onPressed: () {
                      Get.to(() => ExpoLeadsTab());
                    },
                    child: Text('View visitors')),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
