import 'package:flutter/material.dart';
import 'package:tryyy/pages/student/student_profile.dart';
import 'student_homepage.dart';
import 'scan.dart';
import 'reminder.dart';

class SearchScreen extends StatelessWidget {
  final TextEditingController _searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Eventory',
          style: TextStyle(
            color: Colors.white,
            fontFamily: 'NotoSans',
          ),
        ),
        backgroundColor: Colors.black,
        centerTitle: true,
      ),
      backgroundColor: Colors.black,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  children: [
                    IconButton(
                      icon: Icon(Icons.search),
                      onPressed: () {
                        // Perform search or any action
                      },
                    ),
                    Expanded(
                      child: TextField(
                        controller: _searchController,
                        decoration: InputDecoration(
                          hintText: 'Search...',
                          border: InputBorder.none,
                          hintStyle: TextStyle(color: Colors.grey),
                        ),
                      ),
                    ),
                    IconButton(
                      icon: Icon(Icons.cancel),
                      onPressed: () {
                        // Clear search field
                        _searchController.clear();
                      },
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.only(left: 20),
              child: Text(
                'History',
                style: TextStyle(color: Colors.white, fontSize: 18),
              ),
            ),
            SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {
                // Action on 'Listing' click
              },
              style: ElevatedButton.styleFrom(
                primary: Colors.grey[800],
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              ),
              child: Text(
                'Losting',
                style: TextStyle(color: Colors.white),
              ),
            ),
            SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.only(left: 20),
              child: Text(
                'Trends for You',
                style: TextStyle(color: Colors.white, fontSize: 18),
              ),
            ),
            SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {
                // Action on 'First Year Experience Perkasa' click
              },
              style: ElevatedButton.styleFrom(
                primary: Colors.pink,
                padding: EdgeInsets.all(10),
              ),
              child: Text(
                'First Year Experience Perkasa',
                style: TextStyle(color: Colors.white),
              ),
            ),
            SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {
                // Action on 'First Gathering FDC' click
              },
              style: ElevatedButton.styleFrom(
                primary: Colors.pink,
                padding: EdgeInsets.all(10),
              ),
              child: Text(
                'First Gathering FDC',
                style: TextStyle(color: Colors.white),
              ),
            ),
            SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {
                // Action on 'First Gathering Wushu' click
              },
              style: ElevatedButton.styleFrom(
                primary: Colors.pink,
                padding: EdgeInsets.all(10),
              ),
              child: Text(
                'First Gathering Wushu',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: bottomNavigationBar(context),
    );
  }

  Widget bottomNavigationBar(BuildContext context) {
    return Theme(
      data: Theme.of(context).copyWith(
        canvasColor: Colors.black,
      ),
      child: BottomNavigationBar(
        showSelectedLabels: true,
        showUnselectedLabels: true,
        unselectedItemColor: Colors.white,
        selectedItemColor: Colors.white,
        backgroundColor: Colors.black,
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
    );
  }
}
