import 'package:das_info/screens/home/bottom_navigation/add_new_expo.dart';
import 'package:das_info/screens/home/bottom_navigation/personal_leads_screen.dart';
import 'package:das_info/screens/home/bottom_navigation/scan_page.dart';
import 'package:das_info/screens/home/profile_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../widgets/introduction/animated_bar.dart';
import 'bottom_navigation/home_page.dart';

class EntryPoint extends StatefulWidget {
  const EntryPoint({super.key});

  @override
  State<EntryPoint> createState() => _EntryPointState();
}

class _EntryPointState extends State<EntryPoint> {
  List navScreens = [
    HomePage(),
    const ScanPage(),
    AddNewExpo(),
    PersonalLeadsScreen(),
    HomePage(),
  ];

  void changeScreen(int i) {
    setState(() {
      indexScreen = i % (navScreens.length);
    });
  }

  List navScreenIcons = [
    Icons.home,
    Icons.qr_code_scanner,
    Icons.add_circle,
    Icons.group,
    Icons.settings,
  ];

  int indexScreen = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Image.asset(
          'assets/images/logo.png',
          scale: 4,
        ),
        title: const Text('Home'),
        backgroundColor: const Color(0xFFC4C4C4),
        actions: [
          IconButton(
            onPressed: () {
              Get.to(() => ProfilePage());
            },
            icon: const Icon(Icons.account_circle),
          ),
        ],
      ),
      bottomNavigationBar: SafeArea(
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 5),
          margin: const EdgeInsets.symmetric(
            horizontal: 15,
            vertical: 5,
          ),
          decoration: BoxDecoration(
              color: Colors.white, borderRadius: BorderRadius.circular(24)),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ...List.generate(
                navScreens.length,
                (index) => GestureDetector(
                  behavior: HitTestBehavior.translucent,
                  onTap: () {
                    setState(() {
                      indexScreen = index;
                    });
                  },
                  child: SizedBox(
                    width: (MediaQuery.of(context).size.width - 30) / 5,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(
                            vertical: 10,
                          ),
                          child: Icon(
                            navScreenIcons[index],
                            color: Colors.black,
                          ),
                        ),
                        AnimatedBar(
                          isActive: index == indexScreen,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      body: navScreens[indexScreen],
    );
  }
}
