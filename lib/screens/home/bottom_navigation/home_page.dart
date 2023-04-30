import 'package:das_info/controller/home/home_page_controller.dart';
import 'package:das_info/screens/expo_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../widgets/scan_tools/qr_code_widget.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});

  final HomePageController homePageController = Get.put(HomePageController());

  @override
  Widget build(BuildContext context) {
    homePageController.loadData();
    return Obx(
      () {
        return homePageController.isLoading.value
            ? Center(
                child: CircularProgressIndicator(),
              )
            : Container(
                color: const Color(0xFFC4C4C4),
                padding: const EdgeInsets.all(10),
                child: Column(
                  children: [
                    Expanded(
                      child: ListView.separated(
                        itemCount: homePageController.expoList.length,
                        itemBuilder: (ctx, i) {
                          return InkWell(
                            onTap: () {
                              Get.to(() => ExpoScreen(
                                    expoKey: homePageController.expoList
                                        .elementAt(i)
                                        .key
                                        .toString(),
                                  ));
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: Colors.white,
                              ),
                              padding: const EdgeInsets.only(
                                left: 10,
                                right: 10,
                                bottom: 10,
                              ),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                    children: [
                                      Text(
                                        homePageController.expoList
                                            .elementAt(i)
                                            .child('expoName')
                                            .value
                                            .toString(),
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 18,
                                        ),
                                      ),
                                      Text(
                                        homePageController.expoList
                                            .elementAt(i)
                                            .child('eventDescription')
                                            .value
                                            .toString(),
                                      ),
                                    ],
                                  ),
                                  IconButton(
                                    icon: const Icon(Icons.qr_code),
                                    onPressed: () {
                                      Get.to(
                                        QrCodeScanner(
                                          expoKey: homePageController.expoList
                                              .elementAt(i)
                                              .key
                                              .toString(),
                                        ),
                                      );
                                    },
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                        separatorBuilder: (ctx, i) {
                          return const SizedBox(
                            height: 10,
                          );
                        },
                      ),
                    ),
                  ],
                ),
              );
      },
    );
  }
}
