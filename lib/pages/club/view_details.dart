// view_details.dart

import 'package:flutter/material.dart';

class ViewEventPage extends StatelessWidget {
  final Map<String, dynamic> eventDetails;

  ViewEventPage({required this.eventDetails});

  @override
  Widget build(BuildContext context) {
    double containerWidth =
        MediaQuery.of(context).size.width * 0.8; // 80% of screen width
    double containerHeight =
        MediaQuery.of(context).size.height * 0.5; // 50% of screen height

    return Scaffold(
      appBar: null, // Remove the app bar
      body: Container(
        color: Colors.black, // Set Scaffold background color to black
        child: Column(
          children: [
            // Event Details text outside of the container
            // Event Details text outside of the container
            Container(
              padding: EdgeInsets.only(top: 20.0),
              child: Align(
                alignment: Alignment.topCenter,
                child: Text(
                  'Event Details',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),

            SizedBox(height: 20),

            // Image from URL
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(50.0),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(50.0),
                child: Image.network(
                  eventDetails['eventDetails']['imageUrl'],
                  width: containerWidth,
                  height: containerHeight * 0.6, // Adjust the height as needed
                  fit: BoxFit
                      .contain, // Use BoxFit.contain to show the full image
                ),
              ),
            ),
            SizedBox(height: 40),

            // White container
            Center(
              child: Container(
                width: containerWidth,
                height: containerHeight,
                padding: EdgeInsets.all(16.0),
                decoration: BoxDecoration(
                  color: Colors.white, // Set white background for the container
                  borderRadius: BorderRadius.circular(
                      30.0), // Add border-radius for rounded corners
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Activity Name: ',
                      style: TextStyle(
                        fontWeight: FontWeight.bold, // Make it bold
                      ),
                    ),
                    Text(
                      '${eventDetails['eventDetails']['activityName']}',
                    ),
                    SizedBox(height: 10),
                    Text(
                      'Venue: ',
                      style: TextStyle(
                        fontWeight: FontWeight.bold, // Make it bold
                      ),
                    ),
                    Text(
                      '${eventDetails['eventDetails']['venue']}',
                    ),
                    // Add more Text widgets to display other details
                    SizedBox(height: 10),
                    Text(
                      'Date: ',
                      style: TextStyle(
                        fontWeight: FontWeight.bold, // Make it bold
                      ),
                    ),
                    Text(
                      '${eventDetails['eventDetails']['startDate']} - ${eventDetails['eventDetails']['endDate']}',
                    ),
                    SizedBox(height: 10),
                    Text(
                      'Director: ',
                      style: TextStyle(
                        fontWeight: FontWeight.bold, // Make it bold
                      ),
                    ),
                    Text(
                      '${eventDetails['eventDetails']['director']}',
                    ),
                    SizedBox(height: 10),
                    Text(
                      'Category: ',
                      style: TextStyle(
                        fontWeight: FontWeight.bold, // Make it bold
                      ),
                    ),
                    Text(
                      '${eventDetails['eventDetails']['category']}',
                    ),
                    SizedBox(height: 10),
                    Text(
                      'Approval Status: ',
                      style: TextStyle(
                        fontWeight: FontWeight.bold, // Make it bold
                      ),
                    ),
                    Text(
                      '${eventDetails['eventDetails']['status']}',
                    ),
                    SizedBox(height: 25),
                    Container(
                      alignment: Alignment.center,
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.pop(
                              context); // Navigate back to the previous page
                        },
                        style: ElevatedButton.styleFrom(
                          primary: Colors.black, // Button background color
                        ),
                        child:
                            Text('OK', style: TextStyle(color: Colors.white)),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
