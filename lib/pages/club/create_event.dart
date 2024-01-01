import 'package:flutter/material.dart';
import 'dart:ui';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:supabase_flutter/supabase_flutter.dart';
import '../form_fields.dart';
import 'wait_approval.dart';
import '../../api_connection/api_connection.dart';
import 'post_events.dart';

final supabase = Supabase.instance.client;

class CreateEventPage extends StatelessWidget {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  //File? selectedFile;

  TextEditingController activityNameController = TextEditingController();
  TextEditingController directorNameController = TextEditingController();
  TextEditingController venueController = TextEditingController();
  TextEditingController startDateController = TextEditingController();
  TextEditingController endDateController = TextEditingController();
  TextEditingController maxParticipantsController = TextEditingController();
  TextEditingController organizerNameController = TextEditingController();
  TextEditingController imageUrlController = TextEditingController();

  String? selectedCategory;
  String? selectedType;
  String? selectedLevel;
  String? selectedOrganizerCategory;
  String? selectedOrganizerLevel;

  Future<void> sendDataToServer(Map<String, dynamic> eventData) async {
    final Uri url = Uri.parse(API.events);
    final http.Response response = await http.post(
      url,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(eventData),
    );

    print('API Response: ${response.body}');

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = jsonDecode(response.body);
      if (data['status'] == 'success') {
        print('Event created successfully!');
      } else {
        print('Error inserting data: ${data['message']}');
      }
    } else {
      print('Failed to load data, status code: ${response.statusCode}');
    }
  }

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
              SizedBox(height: 150),
              Container(
                height: MediaQuery.of(context).size.height - 150,
                child: SingleChildScrollView(
                  child: Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(30),
                        topRight: Radius.circular(30),
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: EdgeInsets.all(16.0),
                          child: Text(
                            "Fill in event details",
                            style: TextStyle(
                              fontSize: 25,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.all(10.0),
                          child: Form(
                            key: _formKey,
                            child: Column(
                              children: [
                                DropDownFormField(
                                  label: "Category",
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Please select a category';
                                    }
                                    return null;
                                  },
                                  items: [
                                    'Work Experience',
                                    'Career Development',
                                    'Counseling'
                                  ],
                                  onChanged: (value) {
                                    selectedCategory = value;
                                  },
                                ),
                                SizedBox(height: 15),
                                DropDownFormField(
                                  label: "Type",
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Please select a type';
                                    }
                                    return null;
                                  },
                                  items: [
                                    'Seminar',
                                    'Workshop',
                                    'Conference',
                                    'Forum'
                                  ],
                                  onChanged: (value) {
                                    selectedType = value;
                                  },
                                ),
                                SizedBox(height: 15),
                                DropDownFormField(
                                  label: "Level",
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Please select a level';
                                    }
                                    return null;
                                  },
                                  items: [
                                    'International',
                                    'National',
                                    'State',
                                    'UTM',
                                    'Club'
                                  ],
                                  onChanged: (value) {
                                    selectedLevel = value;
                                  },
                                ),
                                SizedBox(height: 15),
                                SignUpFormField(
                                  label: "Activity Name",
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Please enter activity name';
                                    }
                                    return null;
                                  },
                                  controller: activityNameController,
                                ),
                                SizedBox(height: 15),
                                SignUpFormField(
                                  label: "Director Name",
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Please enter director name';
                                    }
                                    return null;
                                  },
                                  controller: directorNameController,
                                ),
                                SizedBox(height: 15),
                                SignUpFormField(
                                  label: "Venue",
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Please enter venue';
                                    }
                                    return null;
                                  },
                                  controller: venueController,
                                ),
                                SizedBox(height: 15),
                                SignUpFormField(
                                  label: "Start Date",
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Please enter start date';
                                    }
                                    return null;
                                  },
                                  controller: startDateController,
                                ),
                                SizedBox(height: 15),
                                SignUpFormField(
                                  label: "End Date",
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Please enter end date';
                                    }
                                    return null;
                                  },
                                  controller: endDateController,
                                ),
                                SizedBox(height: 15),
                                SignUpFormField(
                                  label: "Max Participants",
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Please enter max participants';
                                    }
                                    return null;
                                  },
                                  controller: maxParticipantsController,
                                ),
                                SizedBox(height: 15),
                                SignUpFormField(
                                  label: "Organizer Name",
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Please enter organizer name';
                                    }
                                    return null;
                                  },
                                  controller: organizerNameController,
                                ),
                                SizedBox(height: 15),
                                DropDownFormField(
                                  label: "Organizer Category",
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Please select organizer category';
                                    }
                                    return null;
                                  },
                                  items: [
                                    'UTM',
                                    'NGO',
                                  ],
                                  onChanged: (value) {
                                    selectedOrganizerCategory = value;
                                  },
                                ),
                                SizedBox(height: 15),
                                DropDownFormField(
                                  label: "Organizer Level",
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Please select organizer level';
                                    }
                                    return null;
                                  },
                                  items: [
                                    'UTM',
                                    'Outsider',
                                  ],
                                  onChanged: (value) {
                                    selectedOrganizerLevel = value;
                                  },
                                ),
                                SizedBox(height: 15),
                                SignUpFormField(
                                  label: "Activity Poster",
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Please enter poster activity URL';
                                    }
                                    return null;
                                  },
                                  controller: imageUrlController,
                                ),
                                SizedBox(height: 15),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(height: 20),
                        Center(
                          child: ElevatedButton(
                            onPressed: () async {
                              if (_formKey.currentState!.validate()) {
                                // Extract text values from controllers
                                String directorName =
                                    directorNameController.text;
                                String imageUrl = imageUrlController.text;

                                // Create the eventData map
                                Map<String, dynamic> eventData = {
                                  'category': selectedCategory,
                                  'type': selectedType,
                                  'level': selectedLevel,
                                  'activityName': activityNameController.text,
                                  'director': directorName,
                                  'venue': venueController.text,
                                  'startDate': startDateController.text,
                                  'endDate': endDateController.text,
                                  'maxParticipants':
                                      maxParticipantsController.text,
                                  'organizerName': organizerNameController.text,
                                  'organizerCategory':
                                      selectedOrganizerCategory,
                                  'organizerLevel': selectedOrganizerLevel,
                                  'imageUrl': imageUrl,
                                };

                                print('Event Data: $eventData');
                                print('Before sendDataToServer');
                                await sendDataToServer(eventData);
                                print('After sendDataToServer');

                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => WaitApprovalPage(),
                                  ),
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
                              "Create Event",
                              style: TextStyle(
                                color: Colors.white,
                                fontFamily: 'NotoSans-Regular',
                                fontSize: 16,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 30),
                      ],
                    ),
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
