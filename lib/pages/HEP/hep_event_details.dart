import 'package:flutter/material.dart';
import 'EventList.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../api_connection/api_connection.dart';

class EventDetailsPage extends StatefulWidget {
  @override
  _EventDetailsPageState createState() => _EventDetailsPageState();
}

class _EventDetailsPageState extends State<EventDetailsPage> {
  late List<Event> approvedEvents = [];
  late List<Event> notApprovedEvents = [];

  @override
  void initState() {
    super.initState();
    // Fetch the events from the database
    fetchData();
  }

  Future<void> fetchData() async {
    try {
      final response = await http.get(Uri.parse(API.eventList));

      if (response.statusCode == 200) {
        // Check if the response body is not null
        if (response.body != null) {
          List<dynamic> data = json.decode(response.body);

          List<Event> allEvents = data.map((item) {
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
              imageUrl: item['imageUrl'],
              approval: item['approval'],
            );
          }).toList();

          // Filter events based on approval status
          approvedEvents =
              allEvents.where((event) => event.approval == 'approved').toList();
          notApprovedEvents = allEvents
              .where((event) => event.approval == 'not approved')
              .toList();
          setState(() {});
        } else {
          print('Error: Response body is null');
        }
      } else {
        throw Exception('Failed to load data');
      }
    } catch (error) {
      print('Error fetching data: $error');
    }
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: Text('Event Status'),
          automaticallyImplyLeading: false,
          bottom: TabBar(
            tabs: [
              Tab(text: 'Approved Events'),
              Tab(text: 'Not Approved Events'),
            ],
            indicatorColor: Colors.black,
          ),
        ),
        body: TabBarView(
          children: <Widget>[
            YourWidgetToDisplayEvents(events: approvedEvents),
            YourWidgetToDisplayEvents(events: notApprovedEvents),
          ],
        ),
        bottomNavigationBar: BottomNavigationBar(
          showSelectedLabels: true,
          showUnselectedLabels: true,
          unselectedItemColor: Colors.black,
          selectedItemColor: Colors.black,
          onTap: (index) {
            if (index == 1) {
              // Navigate to EventDetailsPage
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => EventDetailsPage()),
              );
            } else if (index == 0) {
              // Navigate to EventListPage
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => EventListPage()),
              );
            }
          },
          items: [
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Approval',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.center_focus_strong),
              label: 'Status',
            ),
          ],
        ),
      ),
    );
  }
}

class YourWidgetToDisplayEvents extends StatelessWidget {
  final List<Event> events;

  YourWidgetToDisplayEvents({required this.events});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Display events based on approval status
          for (Event event in events)
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  decoration: BoxDecoration(
                    borderRadius:
                        BorderRadius.circular(30), // Apply border radius
                    border: Border.all(
                      color: Colors.white, // Border color
                      width: 5.0, // Border width
                    ),
                  ),
                  margin: EdgeInsets.symmetric(
                      horizontal: 20), // Space on left and right
                  height: 500, // Set the height
                  width: 500, // Set the width
                  child: ClipRRect(
                    borderRadius:
                        BorderRadius.circular(25), // Inner border radius
                    child: Image.network(
                      '${event.imageUrl}',
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.only(left: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Event Name: ${event.activityName}',
                        style: TextStyle(fontSize: 16),
                      ),
                      Text('Event Director: ${event.director}',
                          style: TextStyle(fontSize: 16)),
                      Text('Venue: ${event.venue}',
                          style: TextStyle(fontSize: 16)),
                      Text('Start Date: ${event.startDate}',
                          style: TextStyle(fontSize: 16)),
                      Text('End Date: ${event.endDate}',
                          style: TextStyle(fontSize: 16)),
                      Text('Number of Participants:${event.maxParticipants}',
                          style: TextStyle(fontSize: 16)),
                      Text('Event Category: ${event.category}',
                          style: TextStyle(fontSize: 16)),
                      Text('Event Type: ${event.type}',
                          style: TextStyle(fontSize: 16)),
                      Text('Event Level: ${event.level}',
                          style: TextStyle(fontSize: 16)),
                      Text('Organizer Category: ${event.organizerCategory}',
                          style: TextStyle(fontSize: 16)),
                      Text('Organizer Level: ${event.organizerLevel}',
                          style: TextStyle(fontSize: 16)),
                    ],
                  ),
                ),
                SizedBox(height: 20),
                Divider(),
              ],
            ),
        ],
      ),
    );
  }
}
