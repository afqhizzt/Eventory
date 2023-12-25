import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'dart:ui';
import 'dart:io';
import 'dart:convert';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../form_fields.dart';
import 'wait_approval.dart';

final supabase = Supabase.instance.client;

class CreateEventPage extends StatelessWidget {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  File? selectedFile;

  TextEditingController activityNameController = TextEditingController();
  TextEditingController venueController = TextEditingController();
  TextEditingController startDateController = TextEditingController();
  TextEditingController endDateController = TextEditingController();
  TextEditingController maxParticipantsController = TextEditingController();
  TextEditingController organizerNameController = TextEditingController();

  String? selectedCategory;
  String? selectedType;
  String? selectedLevel;
  String? selectedOrganizerCategory;
  String? selectedOrganizerLevel;

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
                                // File Upload Field
                                /*ElevatedButton(
                                  onPressed: () async {
                                    FilePickerResult? result =
                                        await FilePicker.platform.pickFiles(
                                      type: FileType.custom,
                                      allowedExtensions: ['pdf'],
                                    );

                                    if (result != null) {
                                      selectedFile =
                                          File(result.files.single.path!);
                                    }
                                  },
                                  style: ButtonStyle(
                                    backgroundColor: MaterialStateProperty.all(
                                      Colors.grey[200],
                                    ),
                                  ),
                                  child: Row(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.only(
                                          right: 8.0,
                                        ),
                                        child: Image.asset(
                                          'images/img_upload.png',
                                          width: 24,
                                          height: 24,
                                        ),
                                      ),
                                      Text(
                                        "         Click to upload your proposal",
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontFamily: 'NotoSans',
                                          fontSize: 16,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(height: 15),

                                if (selectedFile != null)
                                  Text(
                                    "Selected File: ${selectedFile!.path}",
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 14,
                                    ),
                                  ),*/
                              ],
                            ),
                          ),
                        ),
                        SizedBox(height: 20),
                        Center(
                          child: ElevatedButton(
                            onPressed: () async {
                              if (_formKey.currentState!.validate()) {
                                List<int> fileBytes =
                                    await selectedFile!.readAsBytes();
                                String fileData = base64Encode(fileBytes);

                                Map<String, dynamic> eventData = {
                                  'category': selectedCategory,
                                  'type': selectedType,
                                  'level': selectedLevel,
                                  'activityName': activityNameController.text,
                                  'venue': venueController.text,
                                  'startDate': startDateController.text,
                                  'endDate': endDateController.text,
                                  'maxParticipants':
                                      maxParticipantsController.text,
                                  'organizerName': organizerNameController.text,
                                  'organizerCategory':
                                      selectedOrganizerCategory,
                                  'organizerLevel': selectedOrganizerLevel,
                                  //'fileData': fileData,
                                };

                                // Print the eventData for debugging
                                print('Event Data: $eventData');

                                final response = await supabase
                                    .from('events')
                                    .upsert([eventData]).execute();

                                // Print the response for debugging
                                print('Response: $response');

                                if (response != null &&
                                        response.status == 201 ||
                                    response.status == 200) {
                                  print('Event created successfully!');
                                  // Navigate to WaitApprovalPage
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => WaitApprovalPage(),
                                    ),
                                  );
                                } else {
                                  print(
                                      'Error inserting data: ${response.data}');
                                }
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
