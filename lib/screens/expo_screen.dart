import 'package:das_info/controller/exposcreen_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../widgets/expo_details_tab.dart';
import '../widgets/expo_leads_tab.dart';

class ExpoScreen extends StatelessWidget {
  ExpoScreen({Key? key, required this.expoKey}) : super(key: key);
  final String expoKey;

  ExpoScreenController expoScreenController = Get.put(ExpoScreenController());

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: SafeArea(
        child: Scaffold(
          body: Column(
            children: const [
              Material(
                color: Colors.blue,
                child: TabBar(
                  tabs: [
                    Tab(
                      text: "Expo Details",
                    ),
                    Tab(
                      text: "Expo Leads",
                    )
                  ],
                ),
              ),
              Expanded(
                child: TabBarView(
                  children: [
                    ExpoDetailsTab(),
                    ExpoLeadsTab(),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
