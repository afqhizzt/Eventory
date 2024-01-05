import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../api_connection/api_connection.dart';
import 'hep_event_details.dart';
import 'hep_profile.dart';
import 'hep_homepage.dart';
import 'event_summary.dart';
import 'event_details.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark().copyWith(
        primaryColor: Colors.black,
        textTheme: TextTheme(
          bodyText2: TextStyle(
            color: Colors.white,
            fontSize: 19.0,
          ), // Increased text size
        ),
      ),
      home: EventListPage(),
    );
  }
}

class Event {
  final int id;
  //final String? isChecked;
  final String activityName;
  final String? status;
  final String director;
  final String venue;
  final DateTime startDate;
  final DateTime endDate;
  final int maxParticipants;
  final String category;
  final String type;
  final String level;
  final String organizerCategory;
  final String organizerLevel;

  Event({
    required this.id,
    //required this.isChecked,
    required this.activityName,
    required this.status,
    required this.director,
    required this.venue,
    required this.startDate,
    required this.endDate,
    required this.maxParticipants,
    required this.category,
    required this.type,
    required this.level,
    required this.organizerCategory,
    required this.organizerLevel,
  });

  bool get isChecked => status != null ? status == 'approved' : false;
}

class EventListPage extends StatefulWidget {
  @override
  _EventListPageState createState() => _EventListPageState();
}

class _EventListPageState extends State<EventListPage> {
  List<Event> events = [];

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    final response = await http.get(Uri.parse(API.eventList));

    if (response.statusCode == 200) {
      // If the server returns a 200 OK response, parse the JSON
      List<dynamic> data = json.decode(response.body);

      setState(() {
        events = data.map((item) {
          return Event(
            id: int.parse(item['id']),
            status: item['status'],
            activityName: item['activityName'],
            startDate: DateTime.parse(item['startDate']),
            endDate: DateTime.parse(item['endDate']),
            director: item['director'],
            venue: item['venue'],
            maxParticipants: int.parse(item['maxParticipants']),
            category: item['category'],
            type: item['type'],
            level: item['level'],
            organizerCategory: item['organizerCategory'],
            organizerLevel: item['organizerLevel'],
          );
        }).toList();
      });
    } else {
      // If the server did not return a 200 OK response,
      // throw an exception.
      throw Exception('Failed to load data');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false, // Removes the back button
        title: Align(
          alignment: Alignment.centerLeft,
          child: Text(
            'Event List',
            style: TextStyle(fontSize: 20.0), // Adjust the font size if needed
          ),
        ),
      ),
      backgroundColor: Color.fromARGB(255, 33, 33, 33),
      body: Column(
        children: [
          YourWidgetToDisplayEvents(events: events),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => EventSummaryPage(events: events),
                ),
              );
            },
            style: ElevatedButton.styleFrom(
              primary: Colors.white,
              onPrimary: Colors.black,
            ),
            child: Text('View Event Summary'),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        showSelectedLabels: true,
        showUnselectedLabels: true,
        unselectedItemColor: Colors.black,
        selectedItemColor: Colors.black,
        onTap: (index) {
          if (index == 1) {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => EventDetailsPage()),
            );
          } else if (index == 0) {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => EventListPage()),
            );
          } else if (index == 2) {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => HEPProfilePage()),
            );
          }
        },
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Status',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.center_focus_strong),
            label: 'Summary',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
} // Import your ViewEventPage

class YourWidgetToDisplayEvents extends StatelessWidget {
  final List<Event> events;

  YourWidgetToDisplayEvents({required this.events});

  @override
  Widget build(BuildContext context) {
    // Sort the events with 'not approved' status first and then approved events
    events.sort((a, b) {
      if (a.status == null && b.status == null) {
        return 0;
      } else if (a.status == null) {
        return -1;
      } else if (b.status == null) {
        return 1;
      } else {
        return a.status!.compareTo(b.status!);
      }
    });

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: DataTable(
        columns: [
          DataColumn(
            label: Text(
              'Index',
              style: TextStyle(color: Colors.white), // Set text color
            ),
          ),
          DataColumn(
            label: Text(
              'Event Name',
              style: TextStyle(color: Colors.white), // Set text color
            ),
          ),
          DataColumn(
            label: Text(
              'Status',
              style: TextStyle(color: Colors.white), // Set text color
            ),
          ),
          DataColumn(
            label: Text(
              'Event Date',
              style: TextStyle(color: Colors.white), // Set text color
            ),
          ),
        ],
        rows: events.map((event) {
          return DataRow(
            cells: [
              DataCell(
                Text(
                  '${events.indexOf(event) + 1}',
                  style: TextStyle(color: Colors.white), // Set text color
                ),
              ),
              DataCell(
                GestureDetector(
                  onTap: () async {
                    // Fetch the full event details from the database using eventId
                    var response = await http
                        .get(Uri.parse('${API.eventList}?id=${event.id}'));
                    if (response.statusCode == 200) {
                      var eventDetails = json.decode(response.body);

                      // Navigate to the new page with the fetched event details
                      if (event.status == 'approved') {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                ApprovedEventDetailPage(event: event),
                          ),
                        );
                      } else {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => EventDetailPage(event: event),
                          ),
                        );
                      }
                    } else {
                      // Handle error
                      print('Failed to fetch event details');
                    }
                  },
                  child: Text(
                    event.activityName,
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
              DataCell(
                event.status != null
                    ? Icon(Icons.check, color: Colors.green) // Checked
                    : Icon(Icons.clear, color: Colors.red), // Unchecked
              ),
              DataCell(
                Text(
                  '${event.startDate.day}/${event.startDate.month}/${event.startDate.year}',
                  style: TextStyle(color: Colors.white), // Set text color
                ),
              ),
            ],
          );
        }).toList(),
      ),
    );
  }
}

class EventDetailPage extends StatelessWidget {
  final Event event;

  EventDetailPage({required this.event});

  Future<void> updateStatus(BuildContext context, String status) async {
    try {
      // Update the status in the database
      var updateResponse = await http
          .get(Uri.parse('${API.getId}?id=${event.id}&status=$status'));

      if (updateResponse.statusCode == 200) {
        // Show the approval or not approval dialog based on the status
        showDialog(
          context: context,
          builder: (BuildContext context) {
            if (status == 'approved') {
              return AlertDialog(
                title: Text('Event Approved'),
                content: Text('This event has been approved!'),
                actions: [
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context); // Close the dialog
                      Navigator.pop(context); // Close the EventDetailPage
                    },
                    child: Text('OK'),
                  ),
                ],
              );
            } else {
              String notApproveReason = '';

              return AlertDialog(
                title: Text('Event Not Approved'),
                content: Column(
                  children: [
                    Text('This event has not been approved.'),
                    TextField(
                      decoration: InputDecoration(labelText: 'Reason'),
                      onChanged: (value) {
                        notApproveReason = value;
                      },
                    ),
                  ],
                ),
                actions: [
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context); // Close the dialog
                    },
                    child: Text('Cancel'),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context); // Close the dialog
                      Navigator.pop(context, 'Not Approved: $notApproveReason');
                    },
                    child: Text('Confirm Not Approve'),
                  ),
                ],
              );
            }
          },
        );
      } else {
        // Handle error
        print('Failed to update status');
      }
    } catch (error) {
      // Handle error
      print('Error updating status: $error');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Event Detail'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Activity Name: ${event.activityName}',
                style: TextStyle(fontSize: 20)),
            Text('Event Director: ${event.director}',
                style: TextStyle(fontSize: 16)),
            Text('Venue: ${event.venue}', style: TextStyle(fontSize: 16)),
            Text('Start Date: ${event.startDate}',
                style: TextStyle(fontSize: 16)),
            Text('End Date: ${event.endDate}', style: TextStyle(fontSize: 16)),
            Text('Number of Participants:${event.maxParticipants}',
                style: TextStyle(fontSize: 16)),
            Text('Event Category: ${event.category}',
                style: TextStyle(fontSize: 16)),
            Text('Event Type: ${event.type}', style: TextStyle(fontSize: 16)),
            Text('Event Level: ${event.level}', style: TextStyle(fontSize: 16)),
            Text('Organizer Category: ${event.organizerCategory}',
                style: TextStyle(fontSize: 16)),
            Text('Organizer Level: ${event.organizerLevel}',
                style: TextStyle(fontSize: 16)),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: () async {
                    await updateStatus(context, 'approved');
                  },
                  style: ElevatedButton.styleFrom(
                    primary: Colors.green, // Background color
                    onPrimary: Colors.white, // Text color
                  ),
                  child: Text('Approve'),
                ),
                ElevatedButton(
                  onPressed: () async {
                    await updateStatus(context, 'not approved');
                  },
                  style: ElevatedButton.styleFrom(
                    primary: Colors.red, // Background color
                    onPrimary: Colors.white, // Text color
                  ),
                  child: Text('Not Approve'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class ApprovedEventDetailPage extends StatelessWidget {
  final Event event;

  ApprovedEventDetailPage({required this.event});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Event Detail - Approved'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Activity Name: ${event.activityName}',
                style: TextStyle(fontSize: 20)),
            Text('Event Director: ${event.director}',
                style: TextStyle(fontSize: 16)),
            Text('Venue: ${event.venue}', style: TextStyle(fontSize: 16)),
            Text('Start Date: ${event.startDate}',
                style: TextStyle(fontSize: 16)),
            Text('End Date: ${event.startDate}',
                style: TextStyle(fontSize: 16)),
            Text('Number of Participants:${event.maxParticipants}',
                style: TextStyle(fontSize: 16)),
            Text('Event Category: ${event.category}',
                style: TextStyle(fontSize: 16)),
            Text('Event Type: ${event.type}', style: TextStyle(fontSize: 16)),
            Text('Event Level: ${event.level}', style: TextStyle(fontSize: 16)),
            Text('Organizer Category: ${event.organizerCategory}',
                style: TextStyle(fontSize: 16)),
            Text('Organizer Level: ${event.organizerLevel}',
                style: TextStyle(fontSize: 16)),
            SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
