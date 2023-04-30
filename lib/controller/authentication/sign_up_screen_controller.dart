import 'dart:async';

import 'package:das_info/screens/authentication/login_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../../screens/home/bottom_navigation/home_page.dart';
import '../../screens/home/entry_point.dart';

class SignUpController extends GetxController {
  var isLoading = false.obs;
  var isCodeSent = false.obs;

  //two forms keys one for all details other for otp specifically
  final formKey = GlobalKey<FormState>();
  final otpFormKey = GlobalKey<FormState>();

  //UI elements controllers
  TextEditingController nameController = TextEditingController();
  TextEditingController mobileNumberController = TextEditingController();
  TextEditingController phoneNoController = TextEditingController();
  TextEditingController emailAddressController = TextEditingController();
  TextEditingController websiteLinkController = TextEditingController();
  TextEditingController genderController = TextEditingController();
  TextEditingController organizationController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController otpController = TextEditingController();
  TextEditingController designationController = TextEditingController();

  final FirebaseAuth _auth = FirebaseAuth.instance;
  late String mVerificationId;
  String mobileNumber = "";
  late int? resendTkn;
  var start = 60.obs;
  var isResendActive = false.obs;
  late final Timer _timer;
  var isCodeResent = false.obs;
  final data = GetStorage();

  void sendOtp() async {
    isLoading.value = true;
    final isValid = formKey.currentState!.validate();
    if (!isValid) {
      isLoading.value = false;
      return;
    }
    if (await checkUserRegistered()) {
      // Get.offAll(() => LogIn());
      Get.snackbar(
        'Already Registered',
        'You are already registered. Please try another mobile number.',
        snackPosition: SnackPosition.BOTTOM,
      );
      isLoading.value = false;
      return;
    }
    mobileNumber = mobileNumberController.text;
    await _auth.verifyPhoneNumber(
      phoneNumber: "+91$mobileNumber",
      verificationCompleted: (PhoneAuthCredential credential) {},
      verificationFailed: (FirebaseAuthException e) {
        isLoading.value = false;
        print(e.toString());
        Get.snackbar(
            "Verification failed", "Please recheck your mobile number.",
            snackPosition: SnackPosition.BOTTOM);
      },
      codeSent: (String verificationId, int? resendToken) async {
        isCodeSent.value = true;
        mVerificationId = verificationId;
        isLoading.value = false;
        isCodeSent.value = true;
        resendTkn = resendToken;
        const oneSec = Duration(seconds: 1);
        _timer = Timer.periodic(oneSec, (timer) {
          if (start.value == 0) {
            timer.cancel();
            isResendActive.value = true;
          } else {
            start.value--;
          }
        });
      },
      codeAutoRetrievalTimeout: (String verificationId) {},
    );
  }

  Future<bool> checkUserRegistered() async {
    final ref = FirebaseDatabase.instance.ref();
    final snapshot =
        await ref.child("users/${mobileNumberController.text}").get();
    if (snapshot.exists) {
      return true;
    } else {
      return false;
    }
  }

  void resendOtp() async {
    isLoading.value = true;
    await _auth.verifyPhoneNumber(
        phoneNumber: "+91$mobileNumber",
        verificationCompleted: (PhoneAuthCredential credential) {},
        verificationFailed: (FirebaseAuthException e) {
          isLoading.value = false;
          Get.snackbar(
              "Verification failed", "Please recheck your mobile number.",
              snackPosition: SnackPosition.BOTTOM);
        },
        codeSent: (String verificationId, int? resendToken) {
          mVerificationId = verificationId;
          isLoading.value = false;
          isCodeSent.value = true;
        },
        codeAutoRetrievalTimeout: (String verificationId) {},
        forceResendingToken: resendTkn);
    isCodeSent.value = true;
  }

  void verifyOtp() async {
    isLoading.value = true;
    final isValid = otpFormKey.currentState!.validate();
    if (!isValid) {
      isLoading.value = false;
      return;
    }
    try {
      final credential = PhoneAuthProvider.credential(
          verificationId: mVerificationId, smsCode: otpController.text);
      await _auth.signInWithCredential(credential);
    } on Exception {
      isLoading.value = false;
      Get.snackbar(
        "Wrong OTP",
        "Please enter valid OTP",
        snackPosition: SnackPosition.BOTTOM,
      );
      return;
    }

    registerUser();
  }

  void registerUser() async {
    final currentUser = _auth.currentUser;
    DatabaseReference ref =
        FirebaseDatabase.instance.ref("users/${mobileNumberController.text}");
    await ref.set({
      "uid": currentUser?.uid,
      "mobileNumber": mobileNumber,
      "name": nameController.text,
      "emailId": emailAddressController.text,
      "website": websiteLinkController.text,
      "address": addressController.text,
      "organization": organizationController.text,
      "designation": designationController.text,
    }).then((value) {
      isLoading.value = false;
      Get.offAll(EntryPoint());
    }).catchError((error) {
      isLoading.value = false;
      Get.snackbar(
        "Registration Failed",
        "Something went wrong please try later!",
        snackPosition: SnackPosition.BOTTOM,
      );
    });
  }

  Future<String?> generateFCMToken() async {
    final fcmToken = await FirebaseMessaging.instance.getToken();
    return fcmToken;
  }

  void loadUserData() async {
    final currentUser = _auth.currentUser;
    final ref = FirebaseDatabase.instance.ref();
    final snapshot = await ref.child("students/${currentUser?.uid}").get();
    if (snapshot.exists) {
      isLoading.value = false;
      Get.offAll(EntryPoint());
    } else {
      isLoading.value = false;
      Get.snackbar(
        "Fetching user Data Failed",
        "Something went wrong please try later!",
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }
}
