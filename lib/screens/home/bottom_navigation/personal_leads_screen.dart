import 'package:das_info/controller/home/personal_leads_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:whatsapp_unilink/whatsapp_unilink.dart';

class PersonalLeadsScreen extends StatelessWidget {
  PersonalLeadsScreen({super.key});

  final PersonalLeadsController personalLeadsController =
      Get.put(PersonalLeadsController());

  launchWhatsApp(String number) async {
    final link = WhatsAppUnilink(
      phoneNumber: '+91$number',
      text: "Hey! Thanks for visiting.",
    );
    await launch('$link');
  }

  @override
  Widget build(BuildContext context) {
    personalLeadsController.loadData();
    return Obx(
      () {
        return personalLeadsController.isLoading.value
            ? Center(
                child: CircularProgressIndicator(),
              )
            : ListView.builder(
                itemCount: personalLeadsController.data.length,
                itemBuilder: (ctx, i) {
                  return Card(
                    child: Container(
                      padding: EdgeInsets.all(15),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Name : ${personalLeadsController.data.elementAt(i).child('name').value}',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            'Mobile : +91${personalLeadsController.data.elementAt(i).child('mobileNumber').value}',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            'Mail : ${personalLeadsController.data.elementAt(i).child('emailId').value}',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            'Website : ${personalLeadsController.data.elementAt(i).child('website').value}',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            'Organization : ${personalLeadsController.data.elementAt(i).child('organization').value}',
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
                              onPressed: () async {
                                launchWhatsApp(personalLeadsController.data
                                    .elementAt(i)
                                    .child('mobileNumber')
                                    .value);
                              },
                              child: Text('Send Message'),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              );
      },
    );
  }
}
