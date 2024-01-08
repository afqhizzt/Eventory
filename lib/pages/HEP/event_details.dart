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
      appBar: null,
      body: Container(
        color: Colors.black,
        child: Column(
          children: [
            Container(
              width: containerWidth,
              height: containerHeight * 0.6,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(30.0),
                  bottomRight: Radius.circular(30.0),
                ),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(30.0),
                  bottomRight: Radius.circular(30.0),
                ),
                child: Image.network(
                  eventDetails['eventDetails']?['imageUrl'] ?? '',
                  width: containerWidth,
                  height: containerHeight * 0.6,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            SizedBox(height: 20),
            Container(
              width: containerWidth,
              height: containerHeight,
              padding: EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30.0),
                  topRight: Radius.circular(30.0),
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Align(
                    alignment: Alignment.topCenter,
                    child: Text(
                      'Event Details',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 24.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  buildText('Activity Name', 'activityName'),
                  SizedBox(height: 10),
                  buildText('Venue', 'venue'),
                  SizedBox(height: 10),
                  buildText('Date', 'startDate',
                      suffix:
                          ' - ${eventDetails['eventDetails']?['endDate'] ?? ''}'),
                  SizedBox(height: 10),
                  buildText('Director', 'director'),
                  SizedBox(height: 10),
                  buildText('Category', 'category'),
                  SizedBox(height: 25),
                  Container(
                    alignment: Alignment.center,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ElevatedButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          style: ElevatedButton.styleFrom(
                            primary: Color.fromARGB(255, 2, 81, 19),
                          ),
                          child: Text(
                            'Approved',
                            style: TextStyle(
                              color: const Color.fromARGB(255, 255, 255, 255),
                            ),
                          ),
                        ),
                        SizedBox(
                            width:
                                20), // Adjust the spacing between buttons as needed
                        ElevatedButton(
                          onPressed: () {
                            Navigator.pop(context);
                            // Handle 'Not Approved' action
                            // You can add logic here to update the status in the database
                          },
                          style: ElevatedButton.styleFrom(
                            primary: Colors
                                .red, // Use a color indicating 'Not Approved'
                          ),
                          child: Text(
                            'Not Approved',
                            style: TextStyle(
                              color: const Color.fromARGB(255, 255, 255, 255),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildText(String label, String key, {String? suffix}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '$label: ',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          '${eventDetails['eventDetails']?[key] ?? ''}$suffix',
        ),
      ],
    );
  }
}
