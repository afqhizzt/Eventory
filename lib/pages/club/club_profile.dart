import 'package:flutter/material.dart';
import 'rules_regulations.dart';
import 'club_edit_page.dart';
import 'club_homepage.dart';
import 'event_details.dart';
import '../../api_connection/api_connection.dart' as apiConnection;

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: ClubProfilePage(), // Change to ClubProfilePage
    );
  }
}

class ClubProfilePage extends StatefulWidget {
  @override
  _ClubProfilePageState createState() => _ClubProfilePageState();
}

class _ClubProfilePageState extends State<ClubProfilePage> {
  // Club-specific profile details
  String clubName = 'Persaka';
  String clubInfo = 'Faculty of Computing';
  String bio = 'Enthusiast for events';
  String profileImage = 'images/persaka.jpg'; // Update with your image path

  String aboutClub = '';
  List<String> interests = [];

  String contactInfo = 'Email: yourclub@example.com';

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
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ClubEditProfilePage(),
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
                        clubName,
                        style: TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 4),
                      Text(
                        clubInfo,
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
                      Divider(
                        color: Colors.grey,
                        thickness: 0.5,
                      ),
                      Container(
                        color: Colors.black,
                        height: 15,
                      ),
                      SizedBox(height: 16),
                      _buildProfileSectionWithAddButton(
                        'About Club',
                        aboutClub,
                        'Add About Club',
                        (text) {
                          setState(() {
                            aboutClub = text;
                          });
                        },
                      ),
                      SizedBox(height: 20),
                      _buildProfileSectionWithAddButton(
                        'Interests',
                        interests.join(', '),
                        'Add Interests',
                        (text) {
                          setState(() {
                            interests = text.split(', ');
                          });
                        },
                      ),
                      SizedBox(height: 20),
                      _buildProfileSectionWithAddButton(
                        'Contact Info',
                        contactInfo,
                        'Update Contact Info',
                        (text) {
                          setState(() {
                            contactInfo = text;
                          });
                        },
                      ),
                    ],
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
    );
  }

  Widget _buildProfileSectionWithAddButton(
    String title,
    String content,
    String addButtonLabel,
    Function(String) onSave,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            ElevatedButton(
              onPressed: () async {
                String newText = await showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AddTextDialog(title, content);
                  },
                );

                if (newText != null && newText.isNotEmpty) {
                  onSave(newText);
                }
              },
              child: Text(
                addButtonLabel,
                style: TextStyle(color: Colors.green),
              ),
              style: ElevatedButton.styleFrom(
                primary: Colors.transparent,
                elevation: 0,
              ),
            ),
          ],
        ),
        SizedBox(height: 5),
        Text(
          content,
          style: TextStyle(
            fontSize: 16,
            color: Colors.grey,
          ),
        ),
      ],
    );
  }
}

class AddTextDialog extends StatefulWidget {
  final String title;
  final String initialText;

  AddTextDialog(this.title, this.initialText);

  @override
  _AddTextDialogState createState() => _AddTextDialogState();
}

class _AddTextDialogState extends State<AddTextDialog> {
  late TextEditingController textController;

  @override
  void initState() {
    super.initState();
    textController = TextEditingController(text: widget.initialText ?? '');
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(widget.title),
      content: TextField(
        controller: textController,
        decoration: InputDecoration(
          hintText: 'Enter your text',
        ),
      ),
      actions: <Widget>[
        ElevatedButton(
          onPressed: () {
            Navigator.of(context).pop(textController.text);
          },
          child: Text('Save'),
        ),
        ElevatedButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: Text('Cancel'),
        ),
      ],
    );
  }

  @override
  void dispose() {
    textController.dispose();
    super.dispose();
  }
}
