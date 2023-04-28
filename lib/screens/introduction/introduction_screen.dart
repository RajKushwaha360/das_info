import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../controller/introduction/introduction_screen_controller.dart';
import '../../widgets/introduction/hostel_fees.dart';
import '../../widgets/introduction/room_allotment.dart';
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
            padding: const EdgeInsets.symmetric(vertical: 100, horizontal: 20),
            color: Theme.of(context).primaryColor,
            child: Container(
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(100),
                  bottomRight: Radius.circular(100),
                ),
              ),
              child: Stack(
                children: [
                  Container(
                    height: (MediaQuery.of(context).size.height / 3) * 2,
                    alignment: Alignment.topCenter,
                    child: PageView(
                      controller: introductionScreenController.controller,
                      onPageChanged:
                          introductionScreenController.currentPageIndex,
                      children: const [
                        RoomAllotment(),
                        HostelFees(),
                      ],
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(bottom: 100),
                    alignment: Alignment.bottomCenter,
                    child: SmoothPageIndicator(
                      controller: introductionScreenController.controller,
                      count: 2,
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
                    margin: const EdgeInsets.only(bottom: 25),
                    alignment: Alignment.bottomCenter,
                    child: ElevatedButton(
                      onPressed: () {
                        if (introductionScreenController
                                .currentPageIndex.value <
                            1) {
                          introductionScreenController.goToNextPage();
                        } else {
                          Get.offAll(LogIn());
                        }
                      },
                      child: Container(
                        margin: const EdgeInsets.symmetric(
                            vertical: 5, horizontal: 15),
                        child: Obx(
                          () => Text(introductionScreenController
                                      .currentPageIndex.value ==
                                  1
                              ? "Let's Start"
                              : "Next"),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
          Container(
            margin: const EdgeInsets.only(top: 25, right: 10),
            alignment: Alignment.topRight,
            child: TextButton(
              onPressed: () {
                introductionScreenController.goToLastPage();
              },
              child: const Text(
                "Skip",
                style: TextStyle(color: Colors.white),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
