import 'dart:convert';
import 'package:flutter/material.dart';
import '../form_fields.dart';
import 'student_login.dart';
import 'package:http/http.dart' as http;
import '../../api_connection/api_connection.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'model.dart';

class UserRegistration extends StatelessWidget {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  // Declare controllers for each form field
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _matricNoController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  validateUserEmail() async {
    try {
      var res = await http.post(
        Uri.parse(API.validateEmail),
        body: {
          'email': _emailController.text.trim(),
        },
      );
      print('Response Body: ${res.body}');
      if (res.statusCode == 200) {
        var resBodyOfValidateEmail = jsonDecode(res.body);

        if (resBodyOfValidateEmail['emailFound']) {
          Fluttertoast.showToast(msg: "Email is already someone else use");
        } else {
          //save new user records to database
          registerAndSaveUserRecord();
        }
      }
      ;
      print('Response Body: ${res.body}');
    } catch (e) {
      print(e.toString());
      Fluttertoast.showToast(msg: e.toString());
    }
  }

  registerAndSaveUserRecord() async {
    Userr userModel = Userr(
      1,
      _nameController.text.trim(),
      _usernameController.text.trim(),
      _emailController.text.trim(),
      _matricNoController.text.trim(),
      _passwordController.text.trim(),
    );
    print("Name: ${_nameController.text}");
    print("Username: ${_usernameController.text}");
    print("Email: ${_emailController.text}");
    print("Matric No: ${_matricNoController.text}");
    print("Password: ${_passwordController.text}");

    try {
      var res = await http.post(
        Uri.parse(API.signUp),
        body: userModel.toJson(),
      );

      if (res.statusCode == 200) {
        var resBodyOfSignUp = jsonDecode(res.body);

        if (resBodyOfSignUp['success'] == true) {
          Fluttertoast.showToast(msg: "Sign up successfully");
        } else {
          Fluttertoast.showToast(msg: "Error occured. Try again");
        }
      }
    } catch (e) {
      print(e.toString());
      Fluttertoast.showToast(msg: e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "All events on",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 30,
                    fontFamily: 'NotoSans',
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  "your fingertips!",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 30,
                    fontFamily: 'NotoSans',
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 20),
                Container(
                  width: MediaQuery.of(context).size.width * 0.8,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Text(
                          "Sign Up",
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 27,
                            fontFamily: 'NotoSans',
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 15),
                        SignUpFormField(
                          label: "Name",
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your name';
                            }
                            return null;
                          },
                          controller: _nameController,
                        ),
                        SizedBox(height: 10),
                        SignUpFormField(
                          label: "Username",
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter a username';
                            }
                            return null;
                          },
                          controller: _usernameController,
                        ),
                        SizedBox(height: 10),
                        SignUpFormField(
                          label: "Matric No.",
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your matric number';
                            }
                            return null;
                          },
                          controller: _matricNoController,
                        ),
                        SizedBox(height: 10),
                        SignUpFormField(
                          label: "Email",
                          isEmail: true,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your email';
                            } else if (!value.contains('@')) {
                              return 'Invalid email address';
                            }
                            return null;
                          },
                          controller: _emailController,
                        ),
                        SizedBox(height: 10),
                        SignUpFormField(
                          label: "Password",
                          isPassword: true,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter a password';
                            } else if (value.length < 6) {
                              return 'Password must be at least 6 characters';
                            }
                            return null;
                          },
                          controller: _passwordController,
                        ),
                        SizedBox(height: 20),
                        ElevatedButton(
                          onPressed: () async {
                            if (_formKey.currentState!.validate()) {
                              await validateUserEmail();
                              // If the form is valid, perform submission.
                              // Handle submit logic here

                              // Example of accessing form field values
                              /*String name = _nameController.text;
                              String username = _usernameController.text;
                              String matricNo = _matricNoController.text;
                              String email = _emailController.text;
                              String password = _passwordController.text;

                              // Save data to Supabase
                              final response = await supabase
                                  .from('student_registration')
                                  .upsert([
                                {
                                  'name': name,
                                  'username': username,
                                  'matricNo': matricNo,
                                  'email': email,
                                  'password': password,
                                }
                              ]).execute();

                              // Create a new user using Supabase authentication
                              final authResponse = await supabase.auth.signUp(
                                email: email,
                                password: password,
                              );

                              if (response.status == 201 ||
                                  response.status == 200) {
                                // Data inserted or updated successfully
                                print('Data inserted successfully');
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => StudentLoginPage(),
                                  ),
                                );
                              } else {
                                // Handle error, e.g., display an error message
                                print('Error inserting data: ${response.data}');
                              }
                            }*/
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => StudentLoginPage(),
                                ),
                              );
                            }
                          },
                          style: ButtonStyle(
                            backgroundColor:
                                MaterialStateProperty.all(Colors.black),
                            overlayColor: MaterialStateProperty.all(
                              Color.fromARGB(119, 53, 53, 53),
                            ),
                            elevation: MaterialStateProperty.all(10),
                          ),
                          child: Text(
                            "Create account",
                            style: TextStyle(
                              color: Colors.white,
                              fontFamily: 'NotoSans-Regular',
                              fontSize: 16,
                            ),
                          ),
                        ),
                        SizedBox(height: 10),
                        Row(
                          children: [
                            Expanded(
                              child: Divider(
                                color: Colors.grey,
                                thickness: 1,
                              ),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 8.0),
                              child: Text(
                                "or",
                                style: TextStyle(
                                  color: Colors.grey,
                                  fontSize: 16,
                                ),
                              ),
                            ),
                            Expanded(
                              child: Divider(
                                color: Colors.grey,
                                thickness: 1,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 10),
                        ElevatedButton(
                          onPressed: () {
                            // Handle Google sign up logic here
                          },
                          style: ButtonStyle(
                            backgroundColor:
                                MaterialStateProperty.all(Colors.black),
                            overlayColor: MaterialStateProperty.all(
                              Color.fromARGB(119, 53, 53, 53),
                            ),
                            elevation: MaterialStateProperty.all(10),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.asset(
                                'images/img_google.png',
                                width: 24,
                                height: 24,
                              ),
                              Text(
                                "  Sign Up with Google",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontFamily: 'NotoSans-Regular',
                                  fontSize: 16,
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 10),
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => StudentLoginPage(),
                              ),
                            );
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "Already have an account?",
                                style: TextStyle(
                                  color: Colors.grey,
                                  fontFamily: 'NotoSans-Regular',
                                ),
                                textAlign: TextAlign.center,
                              ),
                              Text(
                                " Sign in",
                                style: TextStyle(
                                  color: Colors.black,
                                  fontFamily: 'NotoSans-Regular',
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
