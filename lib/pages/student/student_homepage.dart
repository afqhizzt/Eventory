import 'package:flutter/material.dart';
import 'scan.dart';
import 'search.dart';
import 'student_profile.dart';
import 'reminder.dart';

class Post {
  final String username;
  final String imageUrl;
  final String caption;

  Post({
    required this.username,
    required this.imageUrl,
    required this.caption,
  });
}

class HomePage extends StatelessWidget {
  final List<Post> posts = [
    Post(
      username: 'PERSAKA',
      imageUrl: 'images/post1.jpg',
      caption: 'Caption for post 1',
    ),
    Post(
      username: 'PERSAKA',
      imageUrl: 'images/post2.jpg',
      caption: 'Caption for post 2',
    ),
    Post(
      username: 'PERSAKA',
      imageUrl: 'images/post3.jpg',
      caption: 'Caption for post 3',
    ),
    // Add more posts as needed
  ];

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
          canvasColor: Colors.white, // Set the background color here
        ),
        child: BottomNavigationBar(
          showSelectedLabels: true,
          showUnselectedLabels: true,
          unselectedItemColor: Colors.black,
          selectedItemColor: Colors.black,
          backgroundColor: Colors.white,
          onTap: (index) {
            if (index == 2) {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ScanPage()),
              );
            } else if (index == 0) {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => HomePage()),
              );
            } else if (index == 1) {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => SearchScreen()),
              );
            } else if (index == 4) {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => StudentProfilePage()),
              );
            } else if (index == 3) {
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
              icon: Icon(Icons.center_focus_strong),
              label: 'Scan',
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
          Image(
            image: AssetImage(post.imageUrl),
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
