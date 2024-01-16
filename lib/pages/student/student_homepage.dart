import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'scan.dart';
import 'search.dart';
import 'student_profile.dart';
import 'reminder.dart';
import '../../api_connection/api_connection.dart';
import 'joint_event.dart';

class Post {
  final String username;
  final String imageUrl;
  final String caption;

  Post({
    required this.username,
    required this.imageUrl,
    required this.caption,
  });

  factory Post.fromJson(Map<String, dynamic> json) {
    return Post(
      username: json['username'],
      imageUrl: json['imageUrl'],
      caption: json['caption'],
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Post> posts = [];

  @override
  void initState() {
    super.initState();
    fetchPosts();
  }

  Future<void> fetchPosts() async {
    final response = await http.get(Uri.parse(API.post));

    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      setState(() {
        posts = data.map((item) => Post.fromJson(item)).toList();
      });
    } else {
      throw Exception('Failed to load posts');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Eventory For You',
          style: TextStyle(
            color: Colors.white,
            fontFamily: 'NotoSans',
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.black,
        leading: IconButton(
          icon: Icon(
            Icons.logout,
            color: Colors.white,
          ), // Use the appropriate logout icon
          onPressed: () {
            // Implement your logout logic here
            // For example, you can navigate to the login screen
            Navigator.pushReplacementNamed(context, '/sLogin');
          },
        ),
      ),
      backgroundColor: Colors.black,
      body: ListView.builder(
        itemCount: posts.length,
        itemBuilder: (context, index) {
          return buildPostCard(context, posts[index]);
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

  Widget buildPostCard(BuildContext context, Post post) {
    return Card(
      margin: EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    CircleAvatar(
                      radius: 20.0,
                      backgroundImage: AssetImage(
                        'images/persaka.jpg',
                      ),
                    ),
                    SizedBox(width: 8.0),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(post.username,
                            style: TextStyle(fontWeight: FontWeight.bold)),
                        SizedBox(height: 4.0),
                      ],
                    ),
                  ],
                ),
                TextButton(
                  onPressed: () {
                    showRegistrationForm(context);
                  },
                  style: ButtonStyle(
                    side: MaterialStateProperty.all<BorderSide>(
                        BorderSide(color: Colors.blue)),
                  ),
                  child: Text('Register', style: TextStyle(color: Colors.blue)),
                ),
              ],
            ),
          ),
          Image.network(
            post.imageUrl,
            fit: BoxFit.cover,
            width: double.infinity,
            height: 400.0,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(post.caption),
          ),
        ],
      ),
    );
  }
}

void showRegistrationForm(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        content: Container(
          width: double.infinity,
          child: JoinEventPage(), // Use your registration form widget here
        ),
      );
    },
  );
}
