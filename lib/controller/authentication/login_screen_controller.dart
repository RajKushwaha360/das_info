import 'dart:async';

import 'package:das_info/screens/home/home_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class LoginController extends GetxController {
  var isLoading = false.obs;
  var isCodeSent = false.obs;
  final formKey = GlobalKey<FormState>();
  final otpFormKey = GlobalKey<FormState>();
  TextEditingController numberController = TextEditingController();
  TextEditingController otpController = TextEditingController();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  late String mVerificationId;
  String mobileNumber = "";
  late int? resendTkn;
  var start = 60.obs;
  var isResendActive = false.obs;
  late final Timer _timer;
  var isCodeResent = false.obs;
  final data = GetStorage();
  var isRegistered = false.obs;

  void sendOtp() async {
    isLoading.value = true;
    final isValid = formKey.currentState!.validate();
    if (!isValid) {
      isLoading.value = false;
      return;
    }
    mobileNumber = numberController.text;
    await _auth.verifyPhoneNumber(
      phoneNumber: "+91$mobileNumber",
      verificationCompleted: (PhoneAuthCredential credential) {},
      verificationFailed: (FirebaseAuthException e) {
        isLoading.value = false;
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

  Future<void> checkUserRegistered() async {
    final currentUser = _auth.currentUser;
    final ref = FirebaseDatabase.instance.ref();
    final snapshot = await ref.child("students/${currentUser?.uid}").get();
    if (snapshot.exists) {
      isRegistered.value = true;
    } else {
      isRegistered.value = false;
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
    await checkUserRegistered();
    if (isRegistered.value) {
      loadUserData();
    } else {
      registerUser();
    }
  }

  void registerUser() async {
    final currentUser = _auth.currentUser;
    DatabaseReference ref =
        FirebaseDatabase.instance.ref("students/${currentUser?.uid}");
    await ref.set({
      "uid": currentUser?.uid,
      "mobileNumber": mobileNumber,
      "studentDetails": {}
    }).then((value) {
      isLoading.value = false;
      Get.offAll(const HomePage());
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
      Get.offAll(const HomePage());
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
