import 'package:das_info/controller/authentication/sign_up_screen_controller.dart';
import 'package:das_info/screens/authentication/login_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:get/get.dart';

class SignUpPage extends StatelessWidget {
  SignUpPage({super.key});

  final SignUpController signUpController = Get.put(SignUpController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
            child: Column(
              children: [
                Form(
                  key: signUpController.formKey,
                  child: Column(
                    children: [
                      Text(
                        'Register',
                        style: TextStyle(
                            fontSize: 30, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      TextFormField(
                        controller: signUpController.nameController,
                        keyboardType: TextInputType.name,
                        decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'Name',
                            hintText: 'Enter Your Name'),
                        validator: (val) {
                          if (val.toString().trim().isEmpty) {
                            return "Please Enter Name";
                          }
                          return null;
                        },
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      TextFormField(
                        controller: signUpController.mobileNumberController,
                        keyboardType: TextInputType.number,
                        decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'Contact Number',
                            hintText: 'Enter Contact Number'),
                        validator: (val) {
                          if (val.toString().trim().isEmpty) {
                            return "Please Enter Contact Number";
                          } else if (val.toString().trim().length != 10) {
                            return "Please Enter Correct Number";
                          }
                          return null;
                        },
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      TextFormField(
                        controller: signUpController.phoneNoController,
                        keyboardType: TextInputType.number,
                        decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'Tele Phone Number (Optional)',
                            hintText: 'Enter Phone Number'),
                        validator: (val) {
                          if (val.toString().trim().isEmpty) {
                            return null;
                          }
                          if (val.toString().trim().length != 11) {
                            return 'Please Enter Correct Phone Number';
                          }
                          return null;
                        },
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      TextFormField(
                        controller: signUpController.emailAddressController,
                        keyboardType: TextInputType.emailAddress,
                        decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'Email Address',
                            hintText: 'Enter Email Address'),
                        validator: (val) {
                          if (val.toString().isEmpty) {
                            return "Please Enter Email Address";
                          }
                          return null;
                        },
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      TextFormField(
                        controller: signUpController.designationController,
                        keyboardType: TextInputType.name,
                        decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'Designation',
                            hintText: 'Enter Your Designation'),
                        validator: (val) {
                          if (val.toString().isEmpty) {
                            return "Please Enter Your Designation";
                          }
                          return null;
                        },
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      TextFormField(
                        controller: signUpController.websiteLinkController,
                        keyboardType: TextInputType.url,
                        decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'Website',
                            hintText: 'Enter Your Website'),
                        validator: (val) {
                          if (val.toString().isEmpty) {
                            return "Please Enter Your Website";
                          }
                          return null;
                        },
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      TextFormField(
                        controller: signUpController.organizationController,
                        keyboardType: TextInputType.name,
                        decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'Organization',
                            hintText: 'Enter Your Organization'),
                        validator: (val) {
                          if (val.toString().isEmpty) {
                            return "Please Enter Your Organization";
                          }
                          return null;
                        },
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      TextFormField(
                        controller: signUpController.addressController,
                        keyboardType: TextInputType.streetAddress,
                        decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'Address',
                            hintText: 'Enter Your Address'),
                        validator: (val) {
                          if (val.toString().isEmpty) {
                            return "Please Enter Your Address";
                          }
                          return null;
                        },
                      ),
                    ],
                  ),
                ),
                Obx(
                  () {
                    if (signUpController.isLoading.value) {
                      return CircularProgressIndicator();
                    } else {
                      if (signUpController.isCodeSent.value) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(
                            vertical: 20,
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Form(
                                key: signUpController.otpFormKey,
                                child: Column(
                                  children: [
                                    TextFormField(
                                      validator: (value) {
                                        if (value!.isEmpty) {
                                          return "Please enter OTP";
                                        }
                                        return null;
                                      },
                                      keyboardType: TextInputType.number,
                                      controller:
                                          signUpController.otpController,
                                      decoration: const InputDecoration(
                                        border: OutlineInputBorder(),
                                        labelText: "Enter OTP",
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 20,
                                    ),
                                    if (!signUpController.isCodeResent.value)
                                      Row(
                                        mainAxisSize: MainAxisSize.max,
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            signUpController
                                                    .isResendActive.value
                                                ? ""
                                                : "After ${signUpController.start} sec\nyou can resend code.",
                                            textAlign: TextAlign.center,
                                          ),
                                          ElevatedButton(
                                            onPressed: signUpController
                                                    .isResendActive.value
                                                ? () {
                                                    signUpController
                                                        .resendOtp();
                                                    signUpController
                                                        .isCodeResent
                                                        .value = true;
                                                  }
                                                : null,
                                            child: const Text("Resend OTP"),
                                          )
                                        ],
                                      ),
                                  ],
                                ),
                              ),
                              const SizedBox(height: 10),
                              ElevatedButton(
                                onPressed: () {
                                  signUpController.verifyOtp();
                                },
                                child: const Text("Verify OTP"),
                              ),
                            ],
                          ),
                        );
                      } else {
                        return Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Align(
                                alignment: Alignment.topRight,
                                child: TextButton(
                                  onPressed: () {
                                    signUpController.sendOtp();
                                  },
                                  child: const Text("Send OTP"),
                                ),
                              ),
                            ],
                          ),
                        );
                      }
                    }
                  },
                ),
                TextButton(
                  child: Text('Already Registered? Click here to Login'),
                  onPressed: () {
                    Get.offAll(LogIn());
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
