import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../../api_connection/api_connection.dart';


class StudentEditInfoPage extends StatefulWidget {
  final String initialUsername;
  final String initialMatricNo;
  final String initialEmail;
  final String initialPassword;
  final String initialPhone;

  StudentEditInfoPage({
    required this.initialUsername,
    required this.initialMatricNo,
    required this.initialEmail,
    required this.initialPassword,
    required this.initialPhone,
  });

  @override
  _StudentEditInfoPageState createState() => _StudentEditInfoPageState();
}

class _StudentEditInfoPageState extends State<StudentEditInfoPage> {
  late TextEditingController _usernameController;
  late TextEditingController _matricNoController;
  late TextEditingController _emailController;
  late TextEditingController _passwordController;
  late TextEditingController _phNumberController;

  @override
  void initState() {
    super.initState();
    _usernameController = TextEditingController(text: widget.initialUsername);
    _matricNoController = TextEditingController(text: widget.initialMatricNo);
    _emailController = TextEditingController(text: widget.initialEmail);
    _passwordController = TextEditingController(text: widget.initialPassword);
    _phNumberController = TextEditingController(text: widget.initialPhone);
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
            _buildTextField(_matricNoController, 'Matric No'),
            _buildTextField(_emailController, 'Email'),
            _buildTextField(_passwordController, 'Password'),
            _buildTextField(_phNumberController, 'Phone Number'),
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
    final newMatricNo = _matricNoController.text;
    final newEmail = _emailController.text;
    final newPassword = _passwordController.text;
    final newPhone = _phNumberController.text;

    // Create a result map to return to the previous screen
    final result = {
      'newUsername': newUsername,
      'newMatricNo': newMatricNo,
      'newEmail': newEmail,
      'newPassword': newPassword,
      'newPhone': newPhone,
    };

    // Return the result to the previous screen
    Navigator.pop(context, result);
  }

  @override
  void dispose() {
    // Dispose of controllers when the widget is disposed
    _usernameController.dispose();
    _matricNoController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _phNumberController.dispose();
    super.dispose();
  }
}
