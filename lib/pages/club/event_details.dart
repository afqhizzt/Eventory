// event_page.dart

import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../api_connection/api_connection.dart';
import 'club_homepage.dart';
import 'rules_regulations.dart';
import 'club_profile.dart';
import 'view_details.dart';

class EventPage extends StatefulWidget {
  @override
  _EventPageState createState() => _EventPageState();
}

class _EventPageState extends State<EventPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String? selectedEvent;
  List<Map<String, dynamic>> eventsData = [];

  @override
  void initState() {
    super.initState();
    fetchApprovedEvents();
  }

  Future<void> fetchApprovedEvents() async {
    final Uri url = Uri.parse(API.eventDetail);
    final http.Response response = await http.get(url);

    if (response.statusCode == 200) {
      eventsData = List<Map<String, dynamic>>.from(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load events');
    }
  }

  Future<void> sendDataToServer() async {
    final Uri url = Uri.parse(API.eventDetail);
    Map<String, dynamic> eventData = {
      'activityName': selectedEvent, // Include activityName in the request
    };

    final http.Response response = await http.post(
      url,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(eventData),
    );

    print('API Response: ${response.body}');

    if (response.statusCode == 200) {
      Map<String, dynamic> eventDetails =
          jsonDecode(response.body); // Assuming the response is a JSON object

      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ViewEventPage(eventDetails: eventDetails),
        ),
      );
    } else {
      // Handle the error
      print('Failed to fetch event details');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 0, 0, 0),
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.0),
            child: Column(
              children: [
                Image.asset(
                  'images/img_saly_42.png', // Replace with your image file path
                  height: 350, // Adjust the height as needed
                  width: double.infinity,
                  fit: BoxFit
                      .cover, // Use BoxFit.cover to cover the entire space
                ),

                SizedBox(
                    height:
                        16), // Adjust the spacing between image and container

                // White container with form
                Container(
                  padding: EdgeInsets.all(16.0),
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Your Events",
                          style: TextStyle(
                            fontSize: 25,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 20),
                        DropdownButtonFormField<String>(
                          items: eventsData.map((event) {
                            return DropdownMenuItem<String>(
                              value: event['activityName'],
                              child: Text(event['activityName']),
                            );
                          }).toList(),
                          onChanged: (String? value) {
                            setState(() {
                              selectedEvent = value;
                            });
                          },
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please select an event';
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                            labelText: 'Choose Event',
                          ),
                        ),
                        SizedBox(height: 40),
                        Center(
                          child: ElevatedButton(
                            onPressed: () async {
                              if (_formKey.currentState!.validate()) {
                                await sendDataToServer();
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
                              "View Details",
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
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: Theme(
        data: Theme.of(context).copyWith(
          canvasColor: Colors.white,
        ),
        child: BottomNavigationBar(
          showSelectedLabels: true,
          showUnselectedLabels: true,
          unselectedItemColor: const Color.fromARGB(255, 40, 40, 40),
          selectedItemColor: Colors.black,
          backgroundColor: Colors.white,
          onTap: (index) {
            if (index == 1) {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => RulesReguPage()),
              );
            } else if (index == 0) {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ClubHomePage()),
              );
            } else if (index == 2) {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => EventPage()),
              );
            } else if (index == 3) {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ClubProfilePage()),
              );
            }
          },
          items: [
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.add),
              label: 'Create',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.today),
              label: 'Event',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person),
              label: 'Profile',
            ),
          ],
        ),
      ),
    );
  }
}
