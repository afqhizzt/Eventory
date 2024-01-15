import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:tryyy/api_connection/api_connection.dart';
import 'package:tryyy/pages/student/reminder.dart';
import 'package:tryyy/pages/student/search.dart';
import 'package:tryyy/pages/student/student_homepage.dart';
import 'package:tryyy/pages/student/student_profile.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: EventManagement(),
    );
  }
}

class Event {
  final String id;
  final String username;
  final String imageUrl;
  final String caption;
  final String events;

  Event({
    required this.id,
    required this.username,
    required this.imageUrl,
    required this.caption,
    required this.events,
  });

  factory Event.fromJson(Map<String, dynamic> json) {
    return Event(
      id: json['id'] ?? '',
      username: json['username'] ?? '',
      imageUrl: json['imageUrl'] ?? '',
      caption: json['caption'] ?? '',
      events: json['events'] ?? '',
    );
  }
}

class EventManagement extends StatefulWidget {
  @override
  _EventManagementState createState() => _EventManagementState();
}

class _EventManagementState extends State<EventManagement> {
  List<Event> posts = [];
  List<Event> filteredPosts = [];

  @override
  void initState() {
    super.initState();
    fetchEvents();
  }

  Future<void> fetchEvents() async {
  final response = await http.get(Uri.parse(API.post));

  if (response.statusCode == 200) {
    final List<dynamic> data = json.decode(response.body);
    setState(() {
      posts = data.map((item) => Event.fromJson(item)).toList();
      filteredPosts = List.from(posts);
    });
  } else {
    throw Exception('Failed to load posts');
  }
}

  void filterPosts(String query) {
    setState(() {
      filteredPosts = posts
          .where((post) =>
              post.username.toLowerCase().contains(query.toLowerCase()))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Eventory'),
        backgroundColor: Colors.black,
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ElevatedButton(
              onPressed: () {},
              child: Text(
                'Edit',
                style: TextStyle(color: Colors.red),
              ),
              style: ElevatedButton.styleFrom(
                primary: Colors.transparent,
                elevation: 0,
              ),
            ),
          ),
        ],
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(60.0),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            child: TextField(
              onChanged: (query) {
                filterPosts(query);
              },
              decoration: InputDecoration(
                hintText: 'Search...',
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12.0),
                  borderSide: BorderSide.none,
                ),
                contentPadding: EdgeInsets.symmetric(horizontal: 16.0),
                suffixIcon: Icon(Icons.search),
              ),
            ),
          ),
        ),
      ),
      body: ListView.builder(
        scrollDirection: Axis.vertical,
        itemCount: filteredPosts.length,
        itemBuilder: (context, index) {
          if (index.isOdd) {
            return Divider(
              color: Colors.black,
              height: 8,
            );
          }
          final eventIndex = index ~/ 2;
          return buildEventWidget(
            filteredPosts[eventIndex].username,
            filteredPosts[eventIndex].imageUrl,
            filteredPosts[eventIndex].caption,
            filteredPosts[eventIndex].events,
          );
        },
      ),
      bottomNavigationBar: Theme(
        data: Theme.of(context).copyWith(
          canvasColor: Colors.white,
        ),
        child: BottomNavigationBar(
          showSelectedLabels: true,
          showUnselectedLabels: true,
          unselectedItemColor: Colors.black,
          selectedItemColor: Colors.black,
          backgroundColor: Colors.white,
          onTap: (index) {
            if (index == 0) {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => HomePage()),
              );
            } else if (index == 1) {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => SearchScreen()),
              );
            } else if (index == 3) {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => StudentProfilePage()),
              );
            } else if (index == 2) {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => Reminder()),
              );
            }
          },
          items: [
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.search),
              label: 'Search',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.notifications),
              label: 'Notification',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person),
              label: 'Profile',
            ),
          ],
        ),
      ),
    );
  }

  Widget buildEventWidget(
    String title,
    String imageUrl,
    String caption,
    String events,
  ) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Title: $title',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
          Text(
            'Caption: $caption',
            style: TextStyle(
              fontSize: 16,
              color: Colors.grey,
            ),
          ),
          ElevatedButton(
          onPressed: () {
            // Handle "View More" button press
            // You can navigate to another screen or show more details
            // about the event when the button is pressed
          },
          child: Text('View More'),
        ),
        ],
      ),
    );
  }
}
