import 'package:flutter/material.dart';
import '../form_fields.dart';
import 'dart:ui';
import 'package:http/http.dart' as http;
import '../../api_connection/api_connection.dart';

class JoinEventPage extends StatelessWidget {
  TextEditingController nameController = TextEditingController();
  TextEditingController matricNoController = TextEditingController();
  TextEditingController yearAndCourseController = TextEditingController();
  TextEditingController icNumberController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();

  bool paymentRequired = false;

  bool isPaymentRequired() {
    // Determine whether payment is required based on your logic.
    // For example, you can check some conditions or user inputs.
    // Return true if payment is required, false otherwise.
    return true;
  }

  @override
  Widget build(BuildContext context) {
    paymentRequired = isPaymentRequired();
    return Scaffold(
      backgroundColor: Colors.black,
      body: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 7, sigmaY: 7),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(height: 5),
              Expanded(
                child: Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsets.all(16.0),
                        child: Text(
                          "Fill in your details",
                          style: TextStyle(
                            fontSize: 25,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(16.0),
                        child: Form(
                          child: Column(
                            children: [
                              SignUpFormField(
                                label: "Name",
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please enter your name';
                                  }
                                  return null;
                                },
                                controller: nameController,
                              ),
                              SizedBox(height: 25),
                              SignUpFormField(
                                label: "Matric No.",
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please enter your matric number';
                                  }
                                  return null;
                                },
                                controller: matricNoController,
                              ),
                              SizedBox(height: 25),
                              SignUpFormField(
                                label: "Year and Course",
                                validator: (value) {
                                  RegExp regex = RegExp(r'^[0-9]/[A-Z]+$',
                                      caseSensitive: false);
                                  if (!regex.hasMatch(value ?? '')) {
                                    return 'Invalid format. Example: 1/SECBH';
                                  }
                                  return null;
                                },
                                controller: yearAndCourseController,
                              ),
                              SizedBox(height: 25),
                              SignUpFormField(
                                label: "IC number",
                                validator: (value) {
                                  RegExp regex = RegExp(r'^\d{6}-\d{2}-\d{4}$');
                                  if (!regex.hasMatch(value ?? '')) {
                                    return 'Invalid format. Example: 021103-10-2392';
                                  }
                                  return null;
                                },
                                controller: icNumberController,
                              ),
                              SizedBox(height: 25),
                              SignUpFormField(
                                label: "Phone Number",
                                validator: (value) {
                                  RegExp regex = RegExp(r'^\d{3}-\d{7}$');
                                  if (!regex.hasMatch(value ?? '')) {
                                    return 'Invalid format. Example: 018-9114102';
                                  }
                                  return null;
                                },
                                controller: phoneNumberController,
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(height: 40),
                      Center(
                        child: ElevatedButton(
                          onPressed: () async {
                            String name = nameController.text;
                            String matricNo = matricNoController.text;
                            String yearAndCourse = yearAndCourseController.text;
                            String icNumber = icNumberController.text;
                            String phoneNumber = phoneNumberController.text;

                            final response = await http.post(
                              Uri.parse(API.registerEvent),
                              body: {
                                'name': name,
                                'matricNo': matricNo,
                                'yearAndCourse': yearAndCourse,
                                'icNumber': icNumber,
                                'phoneNumber': phoneNumber,
                              },
                            );

                            if (response.statusCode == 200) {
                              // Registration successful

                              // Decide whether payment is required
                              if (paymentRequired) {
                                // Close the dialog and set paymentRequired to true
                                Navigator.of(context).pop(true);
                              } else {
                                // Show success dialog
                                showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return AlertDialog(
                                      title: Row(
                                        children: [
                                          Icon(Icons.done, color: Colors.green),
                                          SizedBox(width: 8.0),
                                          Text('Success'),
                                        ],
                                      ),
                                      content: Text(
                                          'You have successfully registered!'),
                                      actions: [
                                        TextButton(
                                          onPressed: () {
                                            // Close the dialog when "OK" is pressed
                                            Navigator.of(context).pop();
                                          },
                                          child: Text('OK'),
                                        ),
                                      ],
                                    );
                                  },
                                );
                              }
                            } else {
                              // Registration failed
                              // Show failure dialog
                              showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    title: Row(
                                      children: [
                                        Icon(Icons.error, color: Colors.red),
                                        SizedBox(width: 8.0),
                                        Text('Error'),
                                      ],
                                    ),
                                    content: Text(
                                        'Registration failed. Please try again.'),
                                    actions: [
                                      TextButton(
                                        onPressed: () {
                                          // Close the dialog when "OK" is pressed
                                          Navigator.of(context).pop();
                                        },
                                        child: Text('OK'),
                                      ),
                                    ],
                                  );
                                },
                              );
                            }
                          },
                          style: ButtonStyle(
                            backgroundColor:
                                MaterialStateProperty.all(Colors.black),
                            overlayColor: MaterialStateProperty.all(
                              Color.fromARGB(119, 53, 53, 53),
                            ),
                            elevation: MaterialStateProperty.all(10),
                            fixedSize: MaterialStateProperty.all(
                              Size(200, 50),
                            ),
                          ),
                          child: Text(
                            "Register Now",
                            style: TextStyle(
                              color: Colors.white,
                              fontFamily: 'NotoSans-Regular',
                              fontSize: 16,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
