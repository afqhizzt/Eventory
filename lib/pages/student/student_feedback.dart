import 'package:flutter/material.dart';

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
            color: Colors.white, // Text color of the app name
          ),
        ),
        backgroundColor: Colors.black, // Background color of the app name
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
  int _starRating = 0;

  void _setRating(int rating) {
    setState(() {
      _starRating = rating;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black,
      padding: EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            'Feedback and Reviews',
            style: TextStyle(
              color: Colors.white,
              fontSize: 24.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 20.0),
          Text(
            'Rate this app:',
            style: TextStyle(
              color: Colors.white,
              fontSize: 18.0,
            ),
          ),
          SizedBox(height: 10.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              for (int i = 1; i <= 5; i++)
                IconButton(
                  onPressed: () {
                    _setRating(i);
                  },
                  icon: Icon(
                    i <= _starRating ? Icons.star : Icons.star_border,
                    color: Colors.yellow,
                  ),
                ),
            ],
          ),
          SizedBox(height: 20.0),
          Text(
            'Your Feedback:',
            style: TextStyle(
              color: Colors.white,
              fontSize: 18.0,
            ),
          ),
          SizedBox(height: 10.0),
          TextFormField(
            decoration: InputDecoration(
              labelText: 'Name',
              labelStyle: TextStyle(color: Colors.white),
              border: OutlineInputBorder(),
            ),
            style: TextStyle(color: Colors.white),
          ),
          SizedBox(height: 10.0),
          TextFormField(
            decoration: InputDecoration(
              labelText: 'Email',
              labelStyle: TextStyle(color: Colors.white),
              border: OutlineInputBorder(),
            ),
            style: TextStyle(color: Colors.white),
          ),
          SizedBox(height: 10.0),
          TextFormField(
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
              // Implement functionality to handle feedback submission
            },
            style: ElevatedButton.styleFrom(
              primary: Colors.red, // Change button color to red
            ),
            child: Text(
              'Submit',
              style:
                  TextStyle(color: Colors.white), // Change text color to white
            ),
          ),
        ],
      ),
    );
  }
}
