import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:tryyy/pages/club/reminder.dart';
import '../../api_connection/api_connection.dart';

void main() {
  runApp(EventoryApp());
}

class EventoryApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Eventory',
      theme: ThemeData(
        primaryColor: Colors.black,
      ),
      home: EventoryHomePage(),
    );
  }
}

class EventoryHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Eventory',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        backgroundColor: Colors.black,
      ),
      body: FeedbackAndReviews(),
    );
  }
}

class FeedbackAndReviews extends StatefulWidget {
  @override
  _FeedbackAndReviewsState createState() => _FeedbackAndReviewsState();
}

class _FeedbackAndReviewsState extends State<FeedbackAndReviews> {
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController feedbackController = TextEditingController();

  Future<void> sendFeedback(String name, String email, String feedback) async {
    final response = await http.post(
      Uri.parse(API.feedback), // Replace with your server URL
      body: {
        'name': name,
        'email': email,
        'feedback': feedback,
      },
    );

    if (response.statusCode == 200) {
      final responseData = json.decode(response.body);
      if (responseData['status'] == 'success') {
        _showSuccessDialog(); // Show success dialog if feedback is submitted successfully
      } else {
        print('Error submitting feedback: ${responseData['message']}');
      }
    } else {
      print('HTTP request error: ${response.statusCode}');
    }
  }

 void _showSuccessDialog() {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text('Successful Submit'),
        content: Text('Feedback submitted successfully'),
        actions: <Widget>[
          TextButton(
            onPressed: () {
              Navigator.of(context).pop(); // Close the dialog
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => HomePage() // Navigate back to HomePage
              ));
            },
            child: Text('OK'),
          ),
        ],
      );
    },
  );
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Feedback and Reviews',
          style: TextStyle(
            color: Colors.white,
            fontSize: 24.0,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Container(
        color: Colors.black,
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              'Your Feedback:',
              style: TextStyle(
                color: Colors.white,
                fontSize: 18.0,
              ),
            ),
            SizedBox(height: 10.0),
            TextFormField(
              controller: nameController,
              decoration: InputDecoration(
                labelText: 'Name',
                labelStyle: TextStyle(color: Colors.white),
                border: OutlineInputBorder(),
              ),
              style: TextStyle(color: Colors.white),
            ),
            SizedBox(height: 10.0),
            TextFormField(
              controller: emailController,
              decoration: InputDecoration(
                labelText: 'Email',
                labelStyle: TextStyle(color: Colors.white),
                border: OutlineInputBorder(),
              ),
              style: TextStyle(color: Colors.white),
            ),
            SizedBox(height: 10.0),
            TextFormField(
              controller: feedbackController,
              maxLines: 3,
              decoration: InputDecoration(
                labelText: 'Feedback',
                labelStyle: TextStyle(color: Colors.white),
                border: OutlineInputBorder(),
              ),
              style: TextStyle(color: Colors.white),
            ),
            SizedBox(height: 10.0),
            ElevatedButton(
              onPressed: () {
                sendFeedback(
                  nameController.text,
                  emailController.text,
                  feedbackController.text,
                );
              },
              style: ElevatedButton.styleFrom(
                primary: Colors.red, // Change button color to red
              ),
              child: Text(
                'Submit',
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
