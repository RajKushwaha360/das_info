import 'package:das_info/screens/home/entry_point.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddNewExpoController extends GetxController {
  var isLoading = false.obs;

  final formKey = GlobalKey<FormState>();
  DatabaseReference ref = FirebaseDatabase.instance.ref();
  FirebaseAuth _auth = FirebaseAuth.instance;

  //UI elements controllers
  TextEditingController expoNameController = TextEditingController();
  TextEditingController mobileNumberController = TextEditingController();
  TextEditingController eventDescriptionController = TextEditingController();
  TextEditingController emailAddressController = TextEditingController();
  TextEditingController websiteLinkController = TextEditingController();
  TextEditingController organizerNameController = TextEditingController();
  TextEditingController eventAddressController = TextEditingController();
  TextEditingController predefinedMessageController = TextEditingController();

  void createNewExpo() async {
    isLoading.value = true;
    final isValid = formKey.currentState!.validate();
    if (!isValid) {
      isLoading.value = false;
      return;
    }
    final phoneNumber = _auth.currentUser!.phoneNumber!.substring(3);

    final snapshot = ref.child('users/$phoneNumber');
    await snapshot.child('expo').push().set(
      {
        'expoName': expoNameController.text,
        'mobileNumber': mobileNumberController.text,
        'eventDescription': eventDescriptionController.text,
        'emailAddress': emailAddressController.text,
        'website': websiteLinkController.text,
        'organizerName': organizerNameController.text,
        'eventAddress': eventAddressController.text,
        'predefineMessage': predefinedMessageController.text,
      },
    );

    Get.snackbar('Expo Created', 'New Expo has been created.');

    clearUp();
  }

  void clearUp() {
    expoNameController.clear();
    mobileNumberController.clear();
    eventDescriptionController.clear();
    emailAddressController.clear();
    websiteLinkController.clear();
    organizerNameController.clear();
    eventAddressController.clear();
    predefinedMessageController.clear();
    isLoading.value = false;
  }
}
