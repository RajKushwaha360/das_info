import 'package:das_info/controller/home/add_new_expo_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:get/get.dart';

class AddNewExpo extends StatelessWidget {
  AddNewExpo({super.key});

  final AddNewExpoController addNewExpoController =
      Get.put(AddNewExpoController());

  @override
  Widget build(BuildContext context) {
    return Obx(
      () {
        return addNewExpoController.isLoading.value
            ? Center(
                child: CircularProgressIndicator(),
              )
            : SingleChildScrollView(
                child: Form(
                  key: addNewExpoController.formKey,
                  child: Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 20,
                    ),
                    child: Column(
                      children: [
                        Text(
                          'Create New Expo',
                          style: TextStyle(
                              fontSize: 30, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        TextFormField(
                          controller: addNewExpoController.expoNameController,
                          keyboardType: TextInputType.name,
                          decoration: const InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: 'Expo Name',
                              hintText: 'Enter Expo Name'),
                          validator: (val) {
                            if (val.toString().trim().isEmpty) {
                              return "Please Enter Expo Name";
                            }
                            return null;
                          },
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        TextFormField(
                          controller:
                              addNewExpoController.eventDescriptionController,
                          keyboardType: TextInputType.multiline,
                          decoration: const InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: 'Event Description',
                              hintText: 'Enter Event Description'),
                          validator: (val) {
                            if (val.toString().trim().isEmpty) {
                              return "Please Enter Event Description";
                            }
                            return null;
                          },
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        TextFormField(
                          controller:
                              addNewExpoController.organizerNameController,
                          keyboardType: TextInputType.name,
                          decoration: const InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: 'Organizer Name',
                              hintText: 'Enter Organizer Name'),
                          validator: (val) {
                            if (val.toString().trim().isEmpty) {
                              return 'Please Enter Organizer Name';
                            }
                            return null;
                          },
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        TextFormField(
                          controller:
                              addNewExpoController.emailAddressController,
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
                          height: 15,
                        ),
                        TextFormField(
                          controller:
                              addNewExpoController.mobileNumberController,
                          keyboardType: TextInputType.number,
                          decoration: const InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: 'Mobile Number',
                              hintText: 'Enter Your Mobile Number'),
                          validator: (val) {
                            if (val.toString().isEmpty) {
                              return "Please Enter Your Mobile Number";
                            }
                            return null;
                          },
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        TextFormField(
                          controller:
                              addNewExpoController.websiteLinkController,
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
                          height: 15,
                        ),
                        TextFormField(
                          controller:
                              addNewExpoController.eventAddressController,
                          keyboardType: TextInputType.streetAddress,
                          decoration: const InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: 'Event Address',
                              hintText: 'Enter Event Address'),
                          validator: (val) {
                            if (val.toString().isEmpty) {
                              return "Please Enter Your Event Address";
                            }
                            return null;
                          },
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        TextFormField(
                          controller:
                              addNewExpoController.predefinedMessageController,
                          keyboardType: TextInputType.multiline,
                          decoration: const InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: 'Predefined Message',
                              hintText: 'Enter Your Message'),
                          validator: (val) {
                            if (val.toString().isEmpty) {
                              return "Please Enter Your Predefined Message";
                            }
                            return null;
                          },
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        ElevatedButton(
                          onPressed: () {
                            addNewExpoController.createNewExpo();
                          },
                          child: Text('Create New Expo'),
                        ),
                      ],
                    ),
                  ),
                ),
              );
      },
    );
  }
}
