import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'ClubEditInfoPage.dart';
import '../../api_connection/api_connection.dart';

class ClubEditProfilePage extends StatefulWidget {
  @override
  _ClubEditProfilePageState createState() => _ClubEditProfilePageState();
}

class _ClubEditProfilePageState extends State<ClubEditProfilePage> {
  TextEditingController _usernameController = TextEditingController();
  TextEditingController _clubNoController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  @override
  void initState() {
    super.initState();
    // Initialize the controllers with the user's information
    _usernameController.text = 'persaka'; // Replace with the actual username
    _clubNoController.text = 'SC1122356'; // Replace with the actual matricNo
    _emailController.text =
        'persaka@gmail.com'; // Replace with the actual email
    _passwordController.text = '*******'; // Replace with the actual password
  }

  void _editProfile(BuildContext context) async {
    var result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ClubEditInfoPage(
          initialUsername: _usernameController.text,
          initialClubNo: _clubNoController.text,
          initialEmail: _emailController.text,
          initialPassword: _passwordController.text,
        ),
      ),
    );

    if (result != null && result is Map<String, dynamic>) {
      // Update the state with the new information
      setState(() {
        _usernameController.text = result['newUsername'];
        _clubNoController.text = result['newMatricNo'];
        _emailController.text = result['newEmail'];
        _passwordController.text = result['newPassword'];
      });
    }
  }

  void _updateProfileInfo(
    String newUsername,
    String newclubNo,
    String newEmail,
    String newPassword,
  ) async {
    try {
      var url = Uri.parse(API.StudentEditInfoPage);
      var response = await http.post(url, body: {
        'newUsername': newUsername,
        'newClubNo': newclubNo,
        'newEmail': newEmail,
        'newPassword': newPassword,
      });

      var responseData = response.body;
      // Handle the response as needed
      print(responseData);
      // Update the controllers and UI with the edited values
      setState(() {
        _usernameController.text = newUsername;
        _clubNoController.text = newclubNo;
        _emailController.text = newEmail;
        _passwordController.text = newPassword;
      });
    } catch (error) {
      // Handle errors
      print('Error updating profile information: $error');
    }
  }

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
                _editProfile(context);
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
                          // Update with your image source
                          backgroundImage: AssetImage('images/persaka.jpg'),
                        ),
                        SizedBox(height: 10),
                        Text(
                          'PERSAKA',
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
                          _buildRowWithIcon(Icons.perm_identity, 'Username :',
                              subTitle: _usernameController.text),
                          _buildRowWithIcon(Icons.school, 'Club No :',
                              subTitle: _clubNoController.text),
                          _buildRowWithIcon(Icons.calendar_today, 'Email :',
                              subTitle: _emailController.text),
                          _buildRowWithIcon(Icons.work, 'Password :',
                              subTitle: _passwordController.text),
                          SizedBox(height: 55),
                        ],
                      ),
                    ),
                  ),
                ],
              );
            },
          ),
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
                      fontSize: 18,
                      color: Colors.grey,
                    ),
                  ),
              ],
            ),
          ],
        ),
      ],
    );
  }
}
