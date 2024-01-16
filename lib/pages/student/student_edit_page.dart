import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'StudentEditInfoPage.dart';
import '../../api_connection/api_connection.dart';

class EditProfilePage extends StatefulWidget {
  @override
  _EditProfilePageState createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  TextEditingController _usernameController = TextEditingController();
  TextEditingController _matricNoController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _phNumberController = TextEditingController();

  @override
  void initState() {
    super.initState();
    // Initialize the controllers with the user's information
    _usernameController.text = 'afqhizzt'; // Replace with the actual username
    _matricNoController.text = 'A21EC0004'; // Replace with the actual matricNo
    _emailController.text =
        'afiqah.izzati@graduate.utm.my'; // Replace with the actual email
    _passwordController.text = '**********'; // Replace with the actual password
    _phNumberController.text =
        '012-3456789'; // Replace with the actual phNumber
  }

  void _editProfile(BuildContext context) async {
    var result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => StudentEditInfoPage(
          initialUsername: _usernameController.text,
          initialMatricNo: _matricNoController.text,
          initialEmail: _emailController.text,
          initialPassword: _passwordController.text,
          initialPhone: _phNumberController.text,
        ),
      ),
    );

    if (result != null && result is Map<String, dynamic>) {
      // Update the state with the new information
      setState(() {
        _usernameController.text = result['newUsername'];
        _matricNoController.text = result['newMatricNo'];
        _emailController.text = result['newEmail'];
        _passwordController.text = result['newPassword'];
        _phNumberController.text = result['newPhone'];
      });
    }
  }

  void _updateProfileInfo(
    String newUsername,
    String newMatricNo,
    String newEmail,
    String newPassword,
    String newPhNumber,
  ) async {
    try {
      var url = Uri.parse(API.StudentEditInfoPage);
      var response = await http.post(url, body: {
        'newUsername': newUsername,
        'newMatricNo': newMatricNo,
        'newEmail': newEmail,
        'newPassword': newPassword,
        'newPhNumber': newPhNumber,
      });

      var responseData = response.body;
      // Handle the response as needed
      print(responseData);
      // Update the controllers and UI with the edited values
      setState(() {
        _usernameController.text = newUsername;
        _matricNoController.text = newMatricNo;
        _emailController.text = newEmail;
        _passwordController.text = newPassword;
        _phNumberController.text = newPhNumber;
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
                          backgroundImage: AssetImage('images/afiqah.jpg'),
                        ),
                        SizedBox(height: 10),
                        Text(
                          'AFIQAH IZZATI',
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
                          _buildRowWithIcon(Icons.school, 'Matric No :',
                              subTitle: _matricNoController.text),
                          _buildRowWithIcon(Icons.calendar_today, 'Email :',
                              subTitle: _emailController.text),
                          _buildRowWithIcon(Icons.work, 'Password :',
                              subTitle: _passwordController.text),
                          _buildRowWithIcon(Icons.phone, 'Phone Number :',
                              subTitle: _phNumberController.text,
                              isEditable: true),
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
