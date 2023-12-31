import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'dart:ui';
import '../../api_connection/api_connection.dart';
import 'event_posted.dart';

class NewPostPage extends StatefulWidget {
  @override
  _NewPostPageState createState() => _NewPostPageState();
}

class _NewPostPageState extends State<NewPostPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController username = TextEditingController();
  TextEditingController imageUrl = TextEditingController();
  TextEditingController caption = TextEditingController();
  String? selectedEvent;

  Future<void> sendDataToServer() async {
    final Uri url = Uri.parse(API.createPost);

    Map<String, dynamic> eventData = {
      'event': selectedEvent,
      'username': username.text,
      'imageUrl': imageUrl.text,
      'caption': caption.text,
    };

    final http.Response response = await http.post(
      url,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(eventData),
    );

    print('API Response: ${response.body}');

    // Handle the response as needed
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 7, sigmaY: 7),
        child: Center(
          child: SingleChildScrollView(
            child: Container(
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
                      "Post your event!",
                      style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 20),
                    DropdownButtonFormField(
                      items: [
                        DropdownMenuItem(
                            value: 'Event 1', child: Text('Event 1')),
                        DropdownMenuItem(
                            value: 'Event 2', child: Text('Event 2')),
                        DropdownMenuItem(
                            value: 'Event 3', child: Text('Event 3')),
                      ],
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
                        labelText: 'Approved Event',
                      ),
                    ),
                    SizedBox(height: 15),
                    TextFormField(
                      controller: username,
                      decoration: InputDecoration(labelText: 'Username'),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your username';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 15),
                    TextFormField(
                      controller: imageUrl,
                      decoration: InputDecoration(labelText: 'Image'),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter image url';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 15),
                    TextFormField(
                      controller: caption,
                      decoration: InputDecoration(labelText: 'Caption'),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter the captions';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        ElevatedButton(
                          onPressed: () async {
                            if (_formKey.currentState!.validate()) {
                              await sendDataToServer();
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => EventPostedPage(),
                                ),
                              );

                              // Handle navigation or display success message
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
                            "Post Event",
                            style: TextStyle(
                              color: Colors.white,
                              fontFamily: 'NotoSans-Regular',
                              fontSize: 16,
                            ),
                          ),
                        ),
                        ElevatedButton(
                          onPressed: () {
                            Navigator.pop(context); // Navigate back
                          },
                          style: ButtonStyle(
                            backgroundColor:
                                MaterialStateProperty.all(Colors.red),
                            overlayColor: MaterialStateProperty.all(
                              Color.fromARGB(119, 53, 53, 53),
                            ),
                            elevation: MaterialStateProperty.all(10),
                            fixedSize: MaterialStateProperty.all(
                              Size(100, 50),
                            ),
                          ),
                          child: Text(
                            "Cancel",
                            style: TextStyle(
                              color: Colors.white,
                              fontFamily: 'NotoSans-Regular',
                              fontSize: 16,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 30),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
