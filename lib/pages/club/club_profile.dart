import 'package:flutter/material.dart';
import 'rules_regulations.dart';
import 'club_edit_page.dart';
import 'club_homepage.dart';
import 'event_details.dart';

class ClubProfilePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Color.fromARGB(255, 33, 33, 33),
          title: Text(
            'Profile',
            style: TextStyle(color: Colors.white, fontFamily: 'NotoSans'),
          ),
          actions: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => EditProfilePage()),
                  );
                },
                child: Text(
                  'Edit',
                  style: TextStyle(color: Colors.white),
                ),
                style: ElevatedButton.styleFrom(
                  primary: const Color.fromARGB(255, 172, 54, 46),
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
                          backgroundImage: AssetImage('images/spon.webp'),
                        ),
                        SizedBox(height: 5),
                        Text(
                          'LEE MIN HO',
                          style: TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 4),
                        Text(
                          'Kolej Tun Dr Ismail , UTM',
                          style: TextStyle(
                            color: Colors.black,
                          ),
                        ),
                        Text(
                          '"Enthusiast for events"',
                          style: TextStyle(
                            color: Colors.grey,
                          ),
                        ),
                        SizedBox(height: 5),
                        ElevatedButton(
                          onPressed: () {
                            // Handle the "Follow" button press
                          },
                          child: Text('Follow'),
                        ),
                      ],
                    ),
                  ),
                  Divider(
                    color: Colors.grey,
                    thickness: 0.5,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Column(
                          children: [
                            IconButton(
                              icon: Icon(Icons.message, size: 24),
                              onPressed: () {
                                // Handle the "Message" button press
                              },
                            ),
                            Text(
                              'Message',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(height: 5),
                            Text('Following 70'),
                          ],
                        ),
                        Column(
                          children: [
                            Text(
                              'Posts',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text('100'),
                          ],
                        ),
                        Column(
                          children: [
                            IconButton(
                              icon: Icon(Icons.notifications, size: 24),
                              onPressed: () {
                                // Handle the "Invite" button press
                              },
                            ),
                            Text(
                              'Invite',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(height: 5),
                            Text('Posts 10'),
                          ],
                        ),
                        Column(
                          children: [
                            IconButton(
                              icon: Icon(Icons.people, size: 24),
                              onPressed: () {
                                // Handle the "Invite" button press
                              },
                            ),
                            Text(
                              'Followers',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text('100K'),
                          ],
                        ),
                        Column(
                          children: [
                            IconButton(
                              icon: Icon(Icons.person_add, size: 24),
                              onPressed: () {
                                // Handle the "Invite" button press
                              },
                            ),
                            Text(
                              'Following',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text('50'),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Container(
                    color: Colors.black,
                    height: 30, // Adjust the height of the black bar
                  ),
                  Text(
                    'Posts',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  // Remove unnecessary SizedBox
                  // SizedBox(height: 40),
                  // Row of pictures
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: List.generate(
                      3, // Number of pictures in the row
                      (index) => Container(
                        width: constraints.maxWidth * 0.28,
                        height: constraints.maxWidth * 0.28,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage('images/spon family.png'),
                            fit: BoxFit.cover,
                          ),
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                      ),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: List.generate(
                      3, // Number of pictures in the row
                      (index) => Container(
                        width: constraints.maxWidth * 0.28,
                        height: constraints.maxWidth * 0.28,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage('images/post_$index.jpg'),
                            fit: BoxFit.cover,
                          ),
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                      ),
                    ),
                  ),
                ],
              );
            },
          ),
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
      ),
    );
  }
}
