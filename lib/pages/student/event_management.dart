import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: ProfilePage(),
    );
  }
}

class Event {
  final String title;
  final String date;
  final String time;
  final String location;
  final String imagePath;

  Event(this.title, this.date, this.time, this.location, this.imagePath);
}

class ProfilePage extends StatelessWidget {
  final List<Event> eventList = [
    Event('First Year Experience', '4 NOV 2023', '2pm - 9pm', 'BK 7',
        'image/pic1.jpeg'),
    Event('Second Year Experience', '5 NOV 2023', '3pm - 10pm', 'BK 8',
        'image/pic2.jpeg'),
    Event('Third Year Experience', '6 NOV 2023', '4pm - 11pm', 'BK 9',
        'image/pic3.jpeg'),
    Event('Fourth Year Experience', '7 NOV 2023', '5pm - 12am', 'BK 10',
        'image/pic4.jpeg'),
    Event('Fifth Year Experience', '8 NOV 2023', '6pm - 1am', 'BK 11',
        'image/pic1.jpeg'),
    // Add more events as needed
  ];

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
              onPressed: () {
                // Handle the "Edit" button press in the app bar
                // You can add code here to perform actions on edit
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
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(60.0),
          child: Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            child: TextField(
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
        itemCount: eventList.length * 2 -
            1, // Adjust the item count to include dividers
        itemBuilder: (context, index) {
          if (index.isOdd) {
            return Divider(
              color: Colors.black,
              height: 8, // Set the height of the divider
            );
          }
          final eventIndex = index ~/ 2;
          return buildEventWidget(
            eventList[eventIndex].title,
            eventList[eventIndex].date,
            eventList[eventIndex].time,
            eventList[eventIndex].location,
            eventList[eventIndex].imagePath,
          );
        },
      ),
      bottomNavigationBar: BottomNavigationBar(
        showSelectedLabels: true,
        showUnselectedLabels: true,
        backgroundColor: Colors.black,
        unselectedItemColor: Colors.black,
        selectedItemColor: Colors.black,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home, size: 24),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search, size: 24),
            label: 'Search',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.qr_code_scanner, size: 24),
            label: 'Scan',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.notifications, size: 24),
            label: 'Notification',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person, size: 24),
            label: 'Profile',
          ),
        ],
        onTap: (int index) {
          // Handle navigation based on the index
          switch (index) {
            case 0:
              // Handle the "Home" button press
              break;
            case 1:
              // Handle the "Search" button press
              break;
            case 2:
              // Handle the "Scan" button press
              break;
            case 3:
              // Handle the "Notification" button press
              break;
            case 4:
              // Handle the "Profile" button press
              break;
          }
        },
      ),
    );
  }

  Widget buildEventWidget(String title, String date, String time,
      String location, String imagePath) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          Container(
            width: 80,
            height: 80,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(imagePath),
                fit: BoxFit.cover,
              ),
              borderRadius: BorderRadius.circular(8.0),
            ),
          ),
          SizedBox(width: 8.0), // Add some space between the image and text
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.black),
                ),
                Text(
                  '----------------------------------------------------------------------------',
                  style: TextStyle(fontSize: 16, color: Colors.grey),
                ),
                Text(
                  date,
                  style: TextStyle(fontSize: 22, color: Colors.grey),
                ),
                Text(
                  time,
                  style: TextStyle(fontSize: 18, color: Colors.grey),
                ),
                Text(
                  location,
                  style: TextStyle(fontSize: 18, color: Colors.grey),
                ),
              ],
            ),
          ),
          TextButton(
            onPressed: () {
              // Handle "View More" button press
            },
            child: Text(
              'View More',
              style: TextStyle(fontSize: 16, color: Colors.blue),
            ),
          ),
        ],
      ),
    );
  }
}
