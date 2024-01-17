import 'package:flutter/material.dart';
import 'rules_regulations.dart';
import 'club_profile.dart';
import 'package:http/http.dart' as http;
import '../../api_connection/api_connection.dart';
import 'dart:convert';
import 'post_events.dart';
import 'event_details.dart';

class Post {
  final String id;
  final String username;
  final String imageUrl;
  String caption; // Make caption mutable for editing

  Post({
    required this.id,
    required this.username,
    required this.imageUrl,
    required this.caption,
  });

  factory Post.fromJson(Map<String, dynamic> json) {
    return Post(
      id: json['id'],
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
          ),
          onPressed: () {
            Navigator.pushReplacementNamed(context, '/cLogin');
          },
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.add_circle),
            color: Colors.white,
            onPressed: () {
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
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    CircleAvatar(
                      radius: 20.0,
                      backgroundImage: AssetImage('images/persaka.jpg'),
                    ),
                    SizedBox(width: 8.0),
                    Text(post.username,
                        style: TextStyle(fontWeight: FontWeight.bold)),
                  ],
                ),
                Row(
                  children: [
                    IconButton(
                      icon: Icon(Icons.edit),
                      onPressed: () {
                        showEditCaptionDialog(context, post);
                      },
                    ),
                    IconButton(
                      icon: Icon(Icons.delete),
                      onPressed: () {
                        showDeleteConfirmationDialog(context, post);
                      },
                    ),
                  ],
                ),
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

  void showDeleteConfirmationDialog(BuildContext context, Post post) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Delete Post"),
          content: Text("Are you sure you want to delete this post?"),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
              child: Text("Cancel"),
            ),
            TextButton(
              onPressed: () {
                deletePost(post);
                Navigator.of(context).pop(); // Close the dialog
              },
              child: Text("Delete"),
            ),
          ],
        );
      },
    );
  }

  void deletePost(Post post) async {
    try {
      final response = await http.post(
        Uri.parse(API.deletePost),
        body: {'id': post.id?.toString() ?? ''},
      );

      print('Server Response: ${response.body}');

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = json.decode(response.body);

        if (data['success']) {
          setState(() {
            posts.remove(post);
          });

          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(data['message']),
              duration: Duration(seconds: 2),
            ),
          );
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(data['message']),
              duration: Duration(seconds: 2),
            ),
          );
        }
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error deleting post. Please try again.'),
            duration: Duration(seconds: 2),
          ),
        );
      }
    } catch (error) {
      print('Error deleting post: $error');

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content:
              Text('An unexpected error occurred. Please try again later.'),
          duration: Duration(seconds: 2),
        ),
      );
    }
  }

  void showEditCaptionDialog(BuildContext context, Post post) {
    String newCaption = post.caption;

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Edit Caption"),
          content: TextField(
            onChanged: (value) {
              newCaption = value;
            },
            controller: TextEditingController(text: post.caption),
            decoration: InputDecoration(labelText: 'New Caption'),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
              child: Text("Cancel"),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
                editCaption(post, newCaption);
              },
              child: Text("Save"),
            ),
          ],
        );
      },
    );
  }

  void editCaption(Post post, String newCaption) {
    setState(() {
      post.caption = newCaption;
    });

    // Implement your logic to update the caption, e.g., make an API call
    // You can use a similar approach to the delete logic
  }
}
