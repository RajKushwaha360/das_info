import 'package:das_info/controller/home/profile_page_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qr_flutter/qr_flutter.dart';

class ProfilePage extends StatelessWidget {
  ProfilePage({super.key});

  final ProfilePageController profilePageController =
      Get.put(ProfilePageController());

  @override
  Widget build(BuildContext context) {
    profilePageController.loadData();
    return Scaffold(
        // appBar: AppBar(
        //   title: Text('Profile'),
        // ),
        body: Obx(() {
      if (profilePageController.isLoading.value) {
        return Center(child: CircularProgressIndicator());
      }
      return Stack(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: 50,
              ),
              Center(
                child: InkWell(
                  onTap: () {
                    profilePageController.isShowQr.value = true;
                  },
                  splashColor: Colors.transparent,
                  child: Stack(
                    children: [
                      Icon(
                        Icons.account_circle,
                        color: Colors.grey,
                        size: 200,
                      ),
                      Container(
                        alignment: Alignment.bottomRight,
                        width: 185,
                        height: 185,
                        child: CircleAvatar(
                          backgroundColor: Color(0xFFC4C4C4),
                          radius: 30,
                          child: Icon(
                            Icons.qr_code,
                            color: Colors.black,
                            size: 40,
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
              Text(
                profilePageController.name.value,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 25,
                ),
              ),
              Text(
                profilePageController.designation.value,
                style: TextStyle(
                  fontWeight: FontWeight.w400,
                  fontSize: 20,
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Expanded(
                child: Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(30),
                      topRight: Radius.circular(30),
                    ),
                    color: Color(0xFFE7E5E5),
                  ),
                  padding: EdgeInsets.symmetric(
                    horizontal: 30,
                    vertical: 30,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Mobile Number',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                '+91${profilePageController.mobile.value}',
                                style: TextStyle(
                                  fontSize: 20,
                                ),
                              ),
                            ],
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Whatsapp Number',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                '+91${profilePageController.mobile.value}',
                                style: TextStyle(
                                  fontSize: 20,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Mail ID',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            profilePageController.email.value,
                            style: TextStyle(
                              fontSize: 20,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Organization',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            profilePageController.organization.value,
                            style: TextStyle(
                              fontSize: 20,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Website',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            profilePageController.website.value,
                            style: TextStyle(
                              fontSize: 20,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Address',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            profilePageController.address.value,
                            style: TextStyle(
                              fontSize: 20,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          if (profilePageController.isShowQr.value)
            SafeArea(
              child: Container(
                height: double.infinity,
                width: double.infinity,
                color: Colors.black38,
                padding: EdgeInsets.all(15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    IconButton(
                      icon: CircleAvatar(
                        backgroundColor: Colors.black54,
                        child: Icon(
                          Icons.close,
                          size: 30,
                        ),
                      ),
                      onPressed: () {
                        profilePageController.isShowQr.value = false;
                      },
                    ),
                    Center(
                      child: Container(
                        color: Colors.white,
                        child: QrImage(
                          data: profilePageController.mobile.value,
                          version: QrVersions.auto,
                          size: 320,
                          gapless: false,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
        ],
      );
    }));
  }
}
