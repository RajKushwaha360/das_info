import 'package:das_info/widgets/introduction/connect_intro.dart';
import 'package:das_info/widgets/introduction/organise_intro.dart';
import 'package:das_info/widgets/introduction/scan_intro.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../controller/introduction/introduction_screen_controller.dart';
import '../../widgets/introduction/welcome_screen.dart';
import '../authentication/login_page.dart';

class IntroductionScreen extends StatelessWidget {
  IntroductionScreen({Key? key}) : super(key: key);

  final IntroductionScreenController introductionScreenController =
      Get.put(IntroductionScreenController());

  @override
  Widget build(BuildContext context) {
    introductionScreenController.loadData();
    return Scaffold(
      body: Stack(
        children: [
          Container(
            alignment: Alignment.topCenter,
            child: PageView(
              controller: introductionScreenController.controller,
              onPageChanged: introductionScreenController.currentPageIndex,
              children: const [
                WelcomeScreen(),
                ScanIntro(),
                OrganiseIntro(),
                ConnectIntro(),
              ],
            ),
          ),
          Container(
            margin: const EdgeInsets.only(bottom: 100),
            alignment: Alignment.bottomCenter,
            child: SmoothPageIndicator(
              controller: introductionScreenController.controller,
              count: 4,
              effect: SlideEffect(
                  spacing: 8.0,
                  radius: 10,
                  dotHeight: 12,
                  dotWidth: 12,
                  dotColor: Colors.grey,
                  activeDotColor: Theme.of(context).primaryColor),
            ),
          ),
          Container(
            margin: const EdgeInsets.only(
              bottom: 25,
              left: 20,
              right: 20,
            ),
            alignment: Alignment.bottomCenter,
            child: ElevatedButton(
              onPressed: () {
                if (introductionScreenController.currentPageIndex.value < 3) {
                  introductionScreenController.goToNextPage();
                } else {
                  Get.offAll(LogIn());
                }
              },
              child: Container(
                child: Obx(
                  () => Text(
                      introductionScreenController.currentPageIndex.value == 3
                          ? "Get Started"
                          : "Next"),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
