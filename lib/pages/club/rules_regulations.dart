import 'package:flutter/material.dart';
import 'create_event.dart';

class RulesReguPage extends StatefulWidget {
  @override
  _RulesReguPageState createState() => _RulesReguPageState();
}

class _RulesReguPageState extends State<RulesReguPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool _agreeToRules = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  "Rules and",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 30,
                    fontFamily: 'NotoSans',
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  "Regulations",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 30,
                    fontFamily: 'NotoSans',
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 20),
                Container(
                  width: MediaQuery.of(context).size.width * 0.9,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        SizedBox(height: 20),
                        // Rules section (replace with your specific rules)
                        Text(
                          "Posting an event online will help draw people to your event. Make sure that you make the most of this opportunity. Below are a few best practices for submitting your event: (Event/Announcement Title, Start Date and Time, End Date and Time, Location, Description, Image, Your Contact Details)",
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 16,
                            fontFamily: 'NotoSans-Thin',
                          ),
                        ),
                        SizedBox(height: 10),
                        // Rules section (replace with your specific rules)
                        Text(
                          "ONLY EVENTS ARRANGED BY UNIT/DEPARTMENT/FACULTIES/ASSOCIATIONS UNDER UNIVERSITI TEKNOLOGI MALAYSIA WILL BE PUBLISHED IN THIS CALENDAR OF EVENTS. EVENTS THAT ARE NOT RELATED WILL NOT BE PUBLISHED.",
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 16,
                            fontFamily: 'NotoSans-Thin',
                          ),
                        ),
                        // Checkbox for agreeing to rules
                        SizedBox(height: 16),
                        Row(
                          children: [
                            Checkbox(
                              value: _agreeToRules,
                              onChanged: (value) {
                                setState(() {
                                  _agreeToRules = value!;
                                });
                              },
                            ),
                            Text(
                              "I agree to the rules and regulations",
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 16,
                                fontFamily: 'NotoSans-Thin',
                              ),
                            ),
                          ],
                        ),
                        // Buttons
                        SizedBox(height: 16),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            ElevatedButton(
                              onPressed: () {
                                if (_formKey.currentState!.validate() &&
                                    _agreeToRules) {
                                  // If the form is valid and rules are agreed, perform submission.
                                  // Handle submit logic here
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => CreateEventPage(),
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
                              ),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 12.0),
                                child: Text(
                                  "OK",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontFamily: 'NotoSans-Regular',
                                    fontSize: 16,
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(width: 8),
                            ElevatedButton(
                              onPressed: () {
                                // Handle Cancel button logic here
                                Navigator.pop(
                                    context); // Go back to the previous page
                              },
                              style: ButtonStyle(
                                backgroundColor:
                                    MaterialStateProperty.all(Colors.grey),
                                overlayColor: MaterialStateProperty.all(
                                  Color.fromARGB(119, 120, 53, 53),
                                ),
                                elevation: MaterialStateProperty.all(10),
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
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
