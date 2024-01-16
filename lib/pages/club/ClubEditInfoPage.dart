import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../../api_connection/api_connection.dart';


class ClubEditInfoPage extends StatefulWidget {
  final String initialUsername;
  final String initialClubNo;
  final String initialEmail;
  final String initialPassword;
 

  ClubEditInfoPage({
    required this.initialUsername,
    required this.initialClubNo,
    required this.initialEmail,
    required this.initialPassword,
  
  });

  @override
  _ClubEditInfoPageState createState() => _ClubEditInfoPageState();
}

class _ClubEditInfoPageState extends State<ClubEditInfoPage> {
  late TextEditingController _usernameController;
  late TextEditingController _clubNoController;
  late TextEditingController _emailController;
  late TextEditingController _passwordController;
  

  @override
  void initState() {
    super.initState();
    _usernameController = TextEditingController(text: widget.initialUsername);
    _clubNoController = TextEditingController(text: widget.initialClubNo);
    _emailController = TextEditingController(text: widget.initialEmail);
    _passwordController = TextEditingController(text: widget.initialPassword);
   
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Edit Information',
          style: TextStyle(color: Colors.white, fontFamily: 'NotoSans'),
        ),
        backgroundColor: Colors.black,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _buildTextField(_usernameController, 'Username'),
            _buildTextField(_clubNoController, 'Club No'),
            _buildTextField(_emailController, 'Email'),
            _buildTextField(_passwordController, 'Password'),
          
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                _saveChanges(context);
              },
              child: Text('Save'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTextField(TextEditingController controller, String labelText) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          labelText: labelText,
          border: OutlineInputBorder(),
        ),
      ),
    );
  }

  void _saveChanges(BuildContext context) {
    // Collect the updated information
    final newUsername = _usernameController.text;
    final newclubNo = _clubNoController.text;
    final newEmail = _emailController.text;
    final newPassword = _passwordController.text;
    

    // Create a result map to return to the previous screen
    final result = {
      'newUsername': newUsername,
      'newClubNo': newclubNo,
      'newEmail': newEmail,
      'newPassword': newPassword,
      
    };

    // Return the result to the previous screen
    Navigator.pop(context, result);
  }

  @override
  void dispose() {
    // Dispose of controllers when the widget is disposed
    _usernameController.dispose();
    _clubNoController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
  
    super.dispose();
  }
}
