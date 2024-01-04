import 'package:flutter/material.dart';
import 'hep_profile.dart';
import 'hep_event_details.dart';
import 'package:http/http.dart' as http;
import '../../api_connection/api_connection.dart';
import 'dart:convert';

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
          ),
        ),
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => EventListPage(),
      },
    );
  }
}

class Event {
  final int index;
  final String? isChecked;
  final String activityName;
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
    required this.index,
    required this.isChecked,
    required this.activityName,
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
    fetchEvents();
  }

  Future<void> fetchEvents() async {
    try {
      final response = await http.post(Uri.parse(API.eventStatus));

      print('Response status: ${response.statusCode}');
      print('Response body: ${response.body}');

      if (response.statusCode == 200) {
        final dynamic jsonResponse = json.decode(response.body);

        if (jsonResponse != null && jsonResponse is List) {
          setState(() {
            events = jsonResponse
                .map((data) => Event(
                      index: data['index'],
                      activityName: data['activityName'],
                      isChecked: data['status'],
                      startDate: DateTime.parse(data['startDate']),
                      endDate: DateTime.parse(data['endDate']),
                      director: data['director'],
                      venue: data['venue'],
                      maxParticipants: data['maxParticipants'],
                      category: data['category'],
                      type: data['type'],
                      level: data['level'],
                      organizerCategory: data['organizerCategory'],
                      organizerLevel: data['organizerLevel'],
                    ))
                .toList();
          });
        } else {
          print('Invalid JSON structure');
        }
      } else {
        print('Failed to load events. Status Code: ${response.statusCode}');
      }
    } catch (e) {
      print('Error fetching events: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    events.sort((a, b) {
      if (a.isChecked == true && b.isChecked == false) {
        return 1;
      } else if (a.isChecked == false && b.isChecked == true) {
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
                      DataColumn(label: Text('Check')),
                      DataColumn(label: Text('Event Start Date')),
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
                                    if (event.isChecked == 'approved') {
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
                                    event.activityName,
                                    style: TextStyle(
                                      color: Colors.black,
                                      decoration:
                                          (event.isChecked ?? '') == 'approved'
                                              ? TextDecoration.none
                                              : TextDecoration.underline,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          DataCell(Icon((event.isChecked ?? '') == 'approved'
                              ? Icons.check
                              : Icons.clear)),
                          DataCell(Text(
                              '${event.startDate.day}/${event.startDate.month}/${event.startDate.year}')),
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
    int approvedCount = events.where((event) => event.isChecked != null).length;
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
                  border: Border.all(color: Colors.white),
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
            Text('Activity Name: ${event.activityName}',
                style: TextStyle(fontSize: 20)),
            Text('Event Director: ${event.director}',
                style: TextStyle(fontSize: 16)),
            Text('Venue: ${event.venue}', style: TextStyle(fontSize: 16)),
            Text('Start Date: ${event.startDate}',
                style: TextStyle(fontSize: 16)),
            Text('End Date:', style: TextStyle(fontSize: 16)),
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
            Text('Activity Name: ${event.activityName}',
                style: TextStyle(fontSize: 20)),
            Text('Event Director: ${event.director}',
                style: TextStyle(fontSize: 16)),
            Text('Venue: ${event.venue}', style: TextStyle(fontSize: 16)),
            Text('Start Date: ${event.startDate}',
                style: TextStyle(fontSize: 16)),
            Text('End Date:', style: TextStyle(fontSize: 16)),
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
