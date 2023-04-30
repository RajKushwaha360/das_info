import 'package:das_info/controller/home/result_display_controller.dart';
import 'package:das_info/screens/home/entry_point.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class QrResultsPage extends StatelessWidget {
  QrResultsPage(
      {super.key,
      required this.mobileNumber,
      this.isFromExpo = false,
      this.expoKey = ''});
  final String mobileNumber;
  final bool isFromExpo;
  final String expoKey;

  final ResultDisplayController resultDisplayController =
      Get.put(ResultDisplayController());

  @override
  Widget build(BuildContext context) {
    resultDisplayController.loadData(mobileNumber);
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.close),
          onPressed: () {
            Get.back();
          },
        ),
        title: Text('Result Display'),
        centerTitle: true,
      ),
      body: Obx(
        () {
          return resultDisplayController.isLoading.value
              ? Center(
                  child: CircularProgressIndicator(),
                )
              : Container(
                  padding: EdgeInsets.all(15),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Name : ${resultDisplayController.name.value}',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        'Mobile : +91${resultDisplayController.mobile.value}',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        'Mail : ${resultDisplayController.email.value}',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        'Website : ${resultDisplayController.website.value}',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        'Organization : ${resultDisplayController.organization.value}',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Center(
                        child: ElevatedButton(
                          onPressed: () {
                            if (isFromExpo) {
                              resultDisplayController.addAsVisitor(
                                  expoKey, mobileNumber);
                            } else {
                              resultDisplayController
                                  .addToContactBook(mobileNumber);
                            }
                          },
                          child: isFromExpo
                              ? Text('Add as visitor')
                              : Text('Save to Contact Book'),
                        ),
                      ),
                    ],
                  ),
                );
        },
      ),
    );
  }
}
