// view_details.dart

import 'package:flutter/material.dart';

class ViewEventPage extends StatelessWidget {
  final Map<String, dynamic> eventDetails;

  ViewEventPage({required this.eventDetails});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Event Details'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
                'Activity Name: ${eventDetails['eventDetails']['activityName']}'),
            Text('Venue: ${eventDetails['eventDetails']['venue']}'),
            // Add more Text widgets to display other details
          ],
        ),
      ),
    );
  }
}
