import 'package:flutter/material.dart';
import 'hep_profile.dart';
import 'hep_event_details.dart';
//import 'event_summary.dart';

//import '../../api_connection/api_connection.dart';
//import 'dart:convert';
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
              color: Colors.white, fontSize: 19.0), // Increased text size
        ),
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => EventListPage(),
        '/event-summary': (context) => EventDetailsPage(),
      },
    );
  }
}

class Event {
  final int index;
  final String eventName;
  final bool isChecked;
  final DateTime eventDate;

  Event({
    required this.index,
    required this.eventName,
    required this.isChecked,
    required this.eventDate,
  });
}

class EventListPage extends StatelessWidget {
  final List<Event> events = [
    Event(
        index: 1,
        eventName: 'MarathonMania',
        eventDate: DateTime.now(),
        isChecked: false),
    Event(
        index: 2,
        eventName: 'XtremeXperience',
        eventDate: DateTime.now().add(Duration(days: 1)),
        isChecked: false),
    Event(
        index: 3,
        eventName: 'TechTrek',
        eventDate: DateTime.now().add(Duration(days: 2)),
        isChecked: false),
    Event(
        index: 4,
        eventName: 'IdeaIgnite',
        eventDate: DateTime.now().add(Duration(days: 3)),
        isChecked: false),
    Event(
        index: 5,
        eventName: 'InnovateSphere',
        eventDate: DateTime.now().add(Duration(days: 4)),
        isChecked: false),
    Event(
        index: 6,
        eventName: 'MelodyFest',
        eventDate: DateTime.now().add(Duration(days: 5)),
        isChecked: false),
    Event(
        index: 7,
        eventName: 'HarmonyJam',
        eventDate: DateTime.now().add(Duration(days: 6)),
        isChecked: false),
    Event(
        index: 8,
        eventName: 'SonicSpectra',
        eventDate: DateTime.now().add(Duration(days: 7)),
        isChecked: false),
    Event(
        index: 9,
        eventName: 'RoboRenaissance',
        eventDate: DateTime.now().add(Duration(days: 8)),
        isChecked: false),
    Event(
        index: 10,
        eventName: 'Inventor\'sInsight',
        eventDate: DateTime.now().add(Duration(days: 9)),
        isChecked: true),
    Event(
        index: 11,
        eventName: 'DisruptDev',
        eventDate: DateTime.now().add(Duration(days: 10)),
        isChecked: true),
    Event(
        index: 12,
        eventName: 'ThinkTank',
        eventDate: DateTime.now().add(Duration(days: 11)),
        isChecked: true),
    Event(
        index: 13,
        eventName: 'ThriveRhythm',
        eventDate: DateTime.now().add(Duration(days: 12)),
        isChecked: true),
    Event(
        index: 14,
        eventName: 'Revolution',
        eventDate: DateTime.now().add(Duration(days: 13)),
        isChecked: true),
    Event(
        index: 15,
        eventName: 'BeatFusion',
        eventDate: DateTime.now().add(Duration(days: 14)),
        isChecked: true),
    Event(
        index: 16,
        eventName: 'AcousticAlchemy',
        eventDate: DateTime.now().add(Duration(days: 15)),
        isChecked: true),
    Event(
        index: 17,
        eventName: 'GrooveGala',
        eventDate: DateTime.now().add(Duration(days: 16)),
        isChecked: true),
    Event(
        index: 18,
        eventName: 'SymphonyShowdown',
        eventDate: DateTime.now().add(Duration(days: 17)),
        isChecked: true),
    Event(
        index: 19,
        eventName: 'PulsePalooza',
        eventDate: DateTime.now().add(Duration(days: 18)),
        isChecked: true),
    Event(
        index: 20,
        eventName: 'SoundSafari',
        eventDate: DateTime.now().add(Duration(days: 19)),
        isChecked: true),
  ];

  @override
  Widget build(BuildContext context) {
    events.sort((a, b) {
      if (a.isChecked && !b.isChecked) {
        return 1;
      } else if (!a.isChecked && b.isChecked) {
        return -1;
      } else {
        return a.index.compareTo(b.index);
      }
    });

    return DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            title: Text('Event List'),
            automaticallyImplyLeading: false,
            centerTitle: false,
          ),
          body: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(
              children: [
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: DataTable(
                    columns: [
                      DataColumn(label: Text('Index')),
                      DataColumn(label: Text('Event Name')),
                      DataColumn(label: Text('Status')),
                      DataColumn(label: Text('Event Date')),
                    ],
                    rows: events.map((event) {
                      return DataRow(
                        cells: [
                          DataCell(Text('${event.index}')),
                          DataCell(
                            GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context) {
                                    if (event.isChecked) {
                                      return ApprovedEventDetailPage(
                                          event: event);
                                    } else {
                                      return EventDetailPage(event: event);
                                    }
                                  }),
                                );
                              },
                              child: Container(
                                width: 200,
                                child: SingleChildScrollView(
                                  scrollDirection: Axis.horizontal,
                                  child: Text(
                                    event.eventName,
                                    style: TextStyle(
                                      color: Colors
                                          .black, // Set text color to black
                                      decoration: event.isChecked
                                          ? TextDecoration.none
                                          : TextDecoration.underline,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          DataCell(Icon(
                              event.isChecked ? Icons.check : Icons.clear)),
                          DataCell(Text(
                              '${event.eventDate.day}/${event.eventDate.month}/${event.eventDate.year}')),
                        ],
                      );
                    }).toList(),
                  ),
                ),
                SizedBox(height: 20),
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
        ));
  }
}

class EventSummaryPage extends StatelessWidget {
  final List<Event> events;

  EventSummaryPage({required this.events});

  @override
  Widget build(BuildContext context) {
    // Count approved and not approved events
    int approvedCount = events.where((event) => event.isChecked).length;
    int notApprovedCount = events.length - approvedCount;

    return Scaffold(
      appBar: AppBar(
        title: Text('Event Summary'),
      ),
      body: Center(
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(height: 10),
              Container(
                decoration: BoxDecoration(
                  border:
                      Border.all(color: Colors.white), // White outline border
                ),
                child: DataTable(
                  columns: [
                    DataColumn(label: Text('Status')),
                    DataColumn(label: Text('Count')),
                  ],
                  rows: [
                    DataRow(cells: [
                      DataCell(Text('Approved')),
                      DataCell(Text('$approvedCount'))
                    ]),
                    DataRow(cells: [
                      DataCell(Text('Not Approved')),
                      DataCell(Text('$notApprovedCount'))
                    ]),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class EventDetailPage extends StatelessWidget {
  final Event event;

  EventDetailPage({required this.event});

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
            Text('Event Name: ${event.eventName}',
                style: TextStyle(fontSize: 20)),
            Text('Event Director: Your Event Director Name',
                style: TextStyle(fontSize: 16)),
            Text('Venue: Your Event Venue', style: TextStyle(fontSize: 16)),
            Text('Event Category: Your Event Category',
                style: TextStyle(fontSize: 16)),
            Text('Number of Participants: Your Number of Participants',
                style: TextStyle(fontSize: 16)),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
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
                  },
                );
              },
              style: ElevatedButton.styleFrom(
                primary: Colors.green, // Background color
              ),
              child: Text('Approve'),
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
            Text('Event Name: ${event.eventName}',
                style: TextStyle(fontSize: 20)),
            Text('Event Director: Your Event Director Name',
                style: TextStyle(fontSize: 16)),
            Text('Venue: Your Event Venue', style: TextStyle(fontSize: 16)),
            Text('Event Category: Your Event Category',
                style: TextStyle(fontSize: 16)),
            Text('Number of Participants: Your Number of Participants',
                style: TextStyle(fontSize: 16)),
            Text('Event Approval Name: Your Approval Name',
                style: TextStyle(fontSize: 16)),
          ],
        ),
      ),
    );
  }
}
