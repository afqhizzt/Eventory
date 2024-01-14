import 'package:flutter/material.dart';
import 'dart:math';
import 'package:http/http.dart' as http;
import 'student_edit_page.dart';
import 'student_homepage.dart';
import 'search.dart';
import 'reminder.dart';
import 'add_post_screen.dart';
import '../../api_connection/api_connection.dart' as apiConnection;

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: StudentProfilePage(),
    );
  }
}

class StudentProfilePage extends StatefulWidget {
  @override
  _StudentProfilePageState createState() => _StudentProfilePageState();
}

class _StudentProfilePageState extends State<StudentProfilePage> {
  // Placeholder values, replace them with actual data from your server
  String userName = 'LEE MIN HO';
  String collegeInfo = 'Kolej Tun Dr Ismail , UTM';
  String bio = '"Enthusiast for events"';
  String profileImage = 'images/spon.webp';

  int followersCount = 0;
  int followingCount = 0;
  int postCount = 0;

  Map<String, int> activities = {
    'Leadership': 15,
    'Career': 4,
    'Award': 2,
    'Cultural': 6,
    'Academic': 6,
    'Volunteer': 2,
  };

  @override
  void initState() {
    super.initState();
    // Fetch counts when the widget is initialized
    _fetchCounts();
  }

  Future<void> _fetchCounts() async {
    int userId = 1; // Replace with the actual user ID

    try {
      // Fetch Followers Count
      final followersResponse = await http.post(
        Uri.parse(apiConnection.API.getFollowersCount),
        body: {'user_id': userId.toString()},
      );
      setState(() {
        followersCount = int.parse(followersResponse.body);
      });

      // Fetch Following Count
      final followingResponse = await http.post(
        Uri.parse(apiConnection.API.getFollowingCount),
        body: {'user_id': userId.toString()},
      );
      setState(() {
        followingCount = int.parse(followingResponse.body);
      });

      // Fetch Post Count
      final postResponse = await http.post(
        Uri.parse(apiConnection.API.getPostCount),
        body: {'user_id': userId.toString()},
      );
      setState(() {
        postCount = int.parse(postResponse.body);
      });
    } catch (e) {
      // Handle errors
      print('Error fetching counts: $e');
    }
  }

  void _updateFollowerCount(int newFollowerCount) {
    setState(() {
      followersCount = newFollowerCount;
    });
  }

  Future<void> _handleFollow() async {
    // Simulate a follow action (replace with actual logic)
    // For example, you might make an API request to follow the user
    // and update the follower count accordingly.

    // Simulate a follow action
    // Replace this with your actual follow logic (e.g., API request)
    await Future.delayed(Duration(seconds: 2));

    // Update the follower count
    _updateFollowerCount(followersCount + 1);
  }

  Future<void> _handleUnfollow() async {
    // Simulate an unfollow action (replace with actual logic)
    // For example, you might make an API request to unfollow the user
    // and update the follower count accordingly.

    // Simulate an unfollow action
    // Replace this with your actual unfollow logic (e.g., API request)
    await Future.delayed(Duration(seconds: 2));

    // Update the follower count
    _updateFollowerCount(followersCount - 1);
  }

  Future<void> _handleAddPost() async {
    // Navigate to the AddPostScreen and wait for the result
    bool postAdded = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => AddPostScreen()),
    );

    // Handle the result if needed
    if (postAdded != null && postAdded) {
      // Perform any actions you want after the post is added
      print('Diary entry added successfully!');
    }
  }

  Future<void> addActivities(int leadership, int career, int award,
      int cultural, int academic, int volunteer) async {
    final response = await http.post(
      Uri.parse('http://10.205.101.192/api_eventory/add_activities.php'),
      body: {
        'leadership': leadership.toString(),
        'career': career.toString(),
        'award': award.toString(),
        'cultural': cultural.toString(),
        'academic': academic.toString(),
        'volunteer': volunteer.toString(),
      },
    );

    if (response.statusCode == 200) {
      print('Activities added successfully!');
    } else {
      print('Error adding activities: ${response.body}');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Eventory',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        backgroundColor: Colors.black,
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ElevatedButton(
              onPressed: () {
                // Handle the "Edit" button press in the app bar
                // You can add code here to perform actions on edit
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => EditProfilePage(),
                  ),
                );
              },
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
      ),
      body: SingleChildScrollView(
        child: LayoutBuilder(
          builder: (context, constraints) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      CircleAvatar(
                        radius: constraints.maxWidth * 0.15,
                        backgroundImage: AssetImage(profileImage),
                      ),
                      SizedBox(height: 5),
                      Text(
                        userName,
                        style: TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 4),
                      Text(
                        collegeInfo,
                        style: TextStyle(
                          color: Colors.black,
                        ),
                      ),
                      Text(
                        bio,
                        style: TextStyle(
                          color: Colors.grey,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Column(
                              children: [
                                Text(
                                  'Posts',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text('$postCount'),
                              ],
                            ),
                            Column(
                              children: [
                                Text(
                                  'Followers',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text('$followersCount'),
                              ],
                            ),
                            Column(
                              children: [
                                Text(
                                  'Following',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text('$followingCount'),
                              ],
                            ),
                          ],
                        ),
                      ),
                      Divider(
                        color: Colors.grey,
                        thickness: 0.5,
                      ),
                      Container(
                        color: Colors.black,
                        height: 15, // Adjust the height of the black bar
                      ),
                      SizedBox(height: 16),
                    ],
                  ),
                ),
                _buildActivitiesList(activities),
                SizedBox(height: 20),
                _buildPieChart(activities),
                SizedBox(height: 20),
                Center(
                  child: Text(
                    'Total Activities: ${activities.values.reduce((a, b) => a + b)}',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ),
                // Add other widgets here as needed
                Divider(
                  color: Colors.grey,
                  thickness: 0.5,
                ),
                Container(
                  color: Colors.black,
                  height: 15, // Adjust the height of the black bar
                ),
                SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () {
                    // Handle the "Add" button press for uploading posts
                    _handleAddPost();
                  },
                  child: Text('Add My Mood ~'),
                ),
              ],
            );
          },
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        showSelectedLabels: true,
        showUnselectedLabels: true,
        unselectedItemColor: Colors.black,
        selectedItemColor: Colors.black,
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
    );
  }

  Widget _buildActivitiesList(Map<String, int> activities) {
    List<Widget> activityWidgets = [];

    activities.forEach((activity, count) {
      activityWidgets.add(_buildRowWithCounts(activity, count));
    });

    return Center(
      child: Column(
        children: activityWidgets,
      ),
    );
  }

  Widget _buildRowWithCounts(String title, int count) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: TextStyle(fontSize: 18, color: Colors.grey),
          ),
          Text(
            count.toString(),
            style: TextStyle(fontSize: 18, color: Colors.grey),
          ),
        ],
      ),
    );
  }

  Widget _buildPieChart(Map<String, int> activities) {
    return SizedBox(
      height: 300,
      child: CustomPaint(
        size: Size(300, 300),
        painter: PieChartPainter(activities),
      ),
    );
  }
}

class PieChartPainter extends CustomPainter {
  final Map<String, int> data;

  PieChartPainter(this.data);

  @override
  void paint(Canvas canvas, Size size) {
    double total = 0.0;
    data.forEach((_, value) {
      total += value;
    });

    Paint paint = Paint()..style = PaintingStyle.fill;

    double startAngle = 0.0;
    data.forEach((category, value) {
      final double sweepAngle = (value / total) * 360;
      paint.color = Color((category.hashCode & 0xFFFFFF) | 0xFF000000);
      canvas.drawArc(
        Rect.fromLTWH(0, 0, size.width, size.height),
        radians(startAngle),
        radians(sweepAngle),
        true,
        paint,
      );

      // Calculate the angle for the text label
      final angle = radians(startAngle + (sweepAngle / 2));

      // Calculate text position inside the pie chart segment
      final textX = (size.width / 2) + (size.width / 3 * cos(angle));
      final textY = (size.height / 2) + (size.height / 3 * sin(angle));

      // Draw text label
      TextPainter textPainter = TextPainter(
        text: TextSpan(
          text: category,
          style: TextStyle(
            color: Colors.white,
            fontSize: 14,
          ),
        ),
        textDirection: TextDirection.ltr,
      );

      textPainter.layout();
      textPainter.paint(
          canvas,
          Offset(
              textX - textPainter.width / 2, textY - textPainter.height / 2));

      startAngle += sweepAngle;
    });
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }

  double radians(double degrees) {
    return degrees * (pi / 180);
  }
}

class DashboardWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Customize your dashboard widget here
    return Container(
      padding: EdgeInsets.all(16),
      color: Colors.grey[200],
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            'Dashboard',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 10),
          // Add your dashboard content here
        ],
      ),
    );
  }
}
