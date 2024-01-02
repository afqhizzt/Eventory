import 'package:flutter/material.dart';
import '../form_fields.dart';
import 'dart:ui';

class JoinEventPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 7, sigmaY: 7),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(height: 5), // Adjusted height
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
                              ),
                              SizedBox(height: 25),
                              SignUpFormField(
                                label: "Year and Course",
                                validator: (value) {
                                  // Format: 1/SECBH
                                  RegExp regex = RegExp(r'^[0-9]/[A-Z]+$',
                                      caseSensitive: false);
                                  if (!regex.hasMatch(value ?? '')) {
                                    return 'Invalid format. Example: 1/SECBH';
                                  }
                                  return null;
                                },
                              ),
                              SizedBox(height: 25),
                              SignUpFormField(
                                label: "IC number",
                                validator: (value) {
                                  // Format: 021103-10-2392
                                  RegExp regex = RegExp(r'^\d{6}-\d{2}-\d{4}$');
                                  if (!regex.hasMatch(value ?? '')) {
                                    return 'Invalid format. Example: 021103-10-2392';
                                  }
                                  return null;
                                },
                              ),
                              SizedBox(height: 25),
                              SignUpFormField(
                                label: "Phone Number",
                                validator: (value) {
                                  // Format: 018-9114102
                                  RegExp regex = RegExp(r'^\d{3}-\d{7}$');
                                  if (!regex.hasMatch(value ?? '')) {
                                    return 'Invalid format. Example: 018-9114102';
                                  }
                                  return null;
                                },
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(height: 40), // Adjusted height
                      Center(
                        child: ElevatedButton(
                          onPressed: () {
                            // Add your registration logic here
                          },
                          style: ButtonStyle(
                            backgroundColor:
                                MaterialStateProperty.all(Colors.black),
                            overlayColor: MaterialStateProperty.all(
                              Color.fromARGB(119, 53, 53, 53),
                            ),
                            elevation: MaterialStateProperty.all(10),
                            fixedSize: MaterialStateProperty.all(
                              Size(200, 50), // Adjust the size as needed
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
