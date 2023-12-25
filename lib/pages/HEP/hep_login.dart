import 'dart:async';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../form_fields.dart';
import '../hello_flutter.dart';
import 'HEP_profile.dart';
import '../../main.dart';

class HEPLoginPage extends StatefulWidget {
  const HEPLoginPage({Key? key}) : super(key: key);

  @override
  _HEPLoginPageState createState() => _HEPLoginPageState();
}

class _HEPLoginPageState extends State<HEPLoginPage> {
  bool _isLoading = false;
  bool _redirecting = false;
  late final TextEditingController _emailController = TextEditingController();
  late final TextEditingController _passwordController =
      TextEditingController();
  late final StreamSubscription<AuthState> _authStateSubscription;

  Future<void> _signIn() async {
    try {
      setState(() {
        _isLoading = true;
      });

      // Perform email and password sign-in
      final response = await supabase.auth.signInWithPassword(
        email: _emailController.text.trim(),
        password: _passwordController.text.trim(),
      );

      Navigator.of(context).pushReplacementNamed('/hProfile');
    } catch (error) {
      // Handle unexpected errors...
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text('Unexpected error occurred'),
          backgroundColor: Theme.of(context).colorScheme.error,
        ),
      );
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  @override
  void initState() {
    _authStateSubscription =
        supabase.auth.onAuthStateChange.listen((data) async {
      if (_redirecting) return;
      final session = data.session;
      if (session != null) {
        _redirecting = true;

        // You might want to perform additional actions upon successful authentication
        // For example, fetching user data, updating UI, etc.

        //Navigator.of(context).pushReplacementNamed('/hProfile');
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose(); // Dispose the password controller
    _authStateSubscription.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 0, 0, 0),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "\nWelcome back!",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 30,
                  fontFamily: 'NotoSans',
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 0),
              Center(
                child: Image.asset(
                  'images/img_saly_42.png',
                  width: 400,
                  height: 350,
                ),
              ),
              SizedBox(height: 5),
              Center(
                child: Container(
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
                          "Login",
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 30,
                            fontFamily: 'NotoSans',
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 10),
                        SignInFormField(
                          label: "Email",
                          controller: _emailController,
                        ),
                        SizedBox(height: 5),
                        SignInFormField(
                          label: "Password",
                          controller: _passwordController,
                          isPassword: true,
                        ),
                        SizedBox(height: 15),
                        ElevatedButton(
                          onPressed: _signIn,
                          style: ButtonStyle(
                            backgroundColor:
                                MaterialStateProperty.all(Colors.black),
                            overlayColor: MaterialStateProperty.all(
                              Color.fromARGB(119, 53, 53, 53),
                            ),
                            elevation: MaterialStateProperty.all(10),
                          ),
                          child: Text(
                            "Sign In",
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
                              SizedBox(width: 10),
                              Text(
                                "Sign In with Google",
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
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Don't have an account?",
                              style: TextStyle(
                                color: Colors.grey,
                                fontFamily: 'NotoSans-Regular',
                              ),
                              textAlign: TextAlign.center,
                            ),
                            GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => HelloFlutter(),
                                  ),
                                );
                              },
                              child: Text(
                                " Register",
                                style: TextStyle(
                                  color: Colors.black,
                                  fontFamily: 'NotoSans-Regular',
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
