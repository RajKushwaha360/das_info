import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controller/authentication/login_screen_controller.dart';

class LogIn extends StatelessWidget {
  LogIn({Key? key}) : super(key: key);

  final LoginController loginController = Get.put(LoginController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height,
          padding: const EdgeInsets.symmetric(vertical: 100, horizontal: 20),
          color: Theme.of(context).primaryColor,
          child: Container(
            height: MediaQuery.of(context).size.height - 200,
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(100),
                bottomRight: Radius.circular(100),
              ),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 200,
                  height: 200,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    image: DecorationImage(
                      image: NetworkImage(
                          "https://www.slntechnologies.com/wp-content/uploads/2017/08/ef3-placeholder-image.jpg"),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                const Align(
                  alignment: Alignment.center,
                  child: Text(
                    "Log in",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 36,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 25,
                ),
                Obx(
                  () {
                    if (loginController.isLoading.value) {
                      return const CircularProgressIndicator();
                    } else {
                      return loginController.isCodeSent.value
                          ? Padding(
                              padding: const EdgeInsets.all(20),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Form(
                                    key: loginController.otpFormKey,
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
                                              loginController.otpController,
                                          decoration: const InputDecoration(
                                            border: OutlineInputBorder(),
                                            labelText: "Enter OTP",
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 20,
                                        ),
                                        if (!loginController.isCodeResent.value)
                                          Row(
                                            mainAxisSize: MainAxisSize.max,
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                loginController
                                                        .isResendActive.value
                                                    ? ""
                                                    : "After ${loginController.start} sec\nyou can resend code.",
                                                textAlign: TextAlign.center,
                                              ),
                                              ElevatedButton(
                                                onPressed: loginController
                                                        .isResendActive.value
                                                    ? () {
                                                        loginController
                                                            .resendOtp();
                                                        loginController
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
                                      loginController.verifyOtp();
                                    },
                                    child: const Text("Verify OTP"),
                                  ),
                                ],
                              ),
                            )
                          : Padding(
                              padding: const EdgeInsets.all(20),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const SizedBox(height: 10),
                                  Form(
                                    key: loginController.formKey,
                                    child: TextFormField(
                                      validator: (value) {
                                        if (value!.isEmpty) {
                                          return "Please enter mobile number";
                                        }
                                        if (value.length != 10) {
                                          return "Please enter a valid mobile number";
                                        }
                                        return null;
                                      },
                                      keyboardType: TextInputType.number,
                                      controller:
                                          loginController.numberController,
                                      decoration: const InputDecoration(
                                        border: OutlineInputBorder(),
                                        labelText: "Enter mobile no.",
                                      ),
                                    ),
                                  ),
                                  const SizedBox(height: 5),
                                  Align(
                                    alignment: Alignment.topRight,
                                    child: TextButton(
                                      onPressed: () {
                                        loginController.sendOtp();
                                      },
                                      child: const Text("Send OTP"),
                                    ),
                                  ),
                                ],
                              ),
                            );
                    }
                  },
                ),
                const SizedBox(
                  height: 100,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
