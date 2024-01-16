import 'package:flutter/material.dart';
import 'rules_regulations.dart';
import 'club_profile.dart';
import 'package:http/http.dart' as http;
import '../../api_connection/api_connection.dart';
import 'dart:convert';
import 'post_events.dart';
import 'event_details.dart';

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
      imageUrl: json['imageUrl'], // Adjust the base URL
      caption: json['caption'],
    );
  }
}

class ClubHomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<ClubHomePage> {
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
            Navigator.pushReplacementNamed(context, '/cLogin');
          },
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.add_circle),
            color: Colors.white,
            onPressed: () {
              // Navigate to the page for creating a new post
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => NewPostPage()),
              );
            },
          ),
        ],
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
          unselectedItemColor: const Color.fromARGB(255, 40, 40, 40),
          selectedItemColor: Colors.black,
          backgroundColor: Colors.white,
          onTap: (index) {
            if (index == 1) {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => RulesReguPage()),
              );
            } else if (index == 0) {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ClubHomePage()),
              );
            } else if (index == 2) {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => EventPage()),
              );
            } else if (index == 3) {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ClubProfilePage()),
              );
            }
          },
          items: [
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.add),
              label: 'Create',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.today),
              label: 'Event',
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
              children: [
                CircleAvatar(
                  radius: 20.0,
                  backgroundImage: AssetImage(
                    'images/persaka.jpg',
                  ),
                ),
                SizedBox(width: 8.0),
                Text(post.username,
                    style: TextStyle(fontWeight: FontWeight.bold)),
              ],
            ),
          ),
          Image.network(
            post.imageUrl,
            fit: BoxFit.cover,
            width: double.infinity,
            height: 400.00,
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
