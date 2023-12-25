import 'package:flutter/material.dart';

class EditProfilePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Edit Profile',
          style: TextStyle(color: Colors.white, fontFamily: 'NotoSans'),
        ),
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
                '',
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
      body: Container(
        color: Colors.white,
        child: SingleChildScrollView(
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
                        SizedBox(height: 10),
                        Text(
                          'LEE MIN HO',
                          style: TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    color: Colors.black,
                    height: 30, // Adjust the height of the black bar
                  ),
                  SingleChildScrollView(
                    child: Center(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          _buildRowWithIcon(Icons.perm_identity, 'B22ECXXXX'),
                          _buildRowWithIcon(Icons.school, 'Computing'),
                          _buildRowWithIcon(Icons.work,
                              'Bachelor of Mechanical Engineering (Pure)'),
                          _buildRowWithIcon(Icons.calendar_today, '3SEMBH'),
                          _buildRowWithIcon(Icons.email, 'Official Email',
                              subTitle: 'abc123@graduate.utm.my'),
                          _buildRowWithIcon(Icons.email, 'Secondary Email',
                              subTitle: 'abc123@mail.com'),
                          _buildRowWithIcon(Icons.phone, '012-3456789',
                              isEditable: true),
                          SizedBox(height: 55),
                        ],
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
      ),
      bottomNavigationBar: Theme(
        data: Theme.of(context).copyWith(
          canvasColor:
              Colors.white, // Set the background color of the navigation bar
        ),
        child: BottomNavigationBar(
          showSelectedLabels: true,
          showUnselectedLabels: true,
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
      ),
    );
  }

  Widget _buildRowWithIcon(IconData iconData, String title,
      {String subTitle = '', bool isEditable = false}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(right: 8.0),
              child: Icon(
                iconData,
                size: 24,
                color: Colors.grey,
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 18,
                    color: Color.fromARGB(255, 0, 0, 0),
                  ),
                ),
                if (subTitle.isNotEmpty)
                  Text(
                    subTitle,
                    style: TextStyle(
                      fontSize: 19,
                      color: Colors.grey,
                    ),
                  ),
              ],
            ),
          ],
        ),
        if (isEditable)
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: TextButton(
              onPressed: () {
                // Handle the "Edit" button press
                // You can add code here to perform actions on edit
              },
              child: Text(
                'Edit',
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.red,
                ),
              ),
            ),
          ),
      ],
    );
  }
}
