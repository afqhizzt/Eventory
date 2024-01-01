import 'dart:async';
import 'package:flutter/material.dart';
import '../form_fields.dart';
import '../hello_flutter.dart';
import 'package:http/http.dart' as http;
import '../../api_connection/api_connection.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'model.dart';
import 'package:get/get.dart';
import 'dart:convert';
import 'hep_preferences.dart';
import 'hep_homepage.dart';

class HEPLoginPage extends StatefulWidget {
  const HEPLoginPage({Key? key}) : super(key: key);

  @override
  _HEPLoginPageState createState() => _HEPLoginPageState();
}

class _HEPLoginPageState extends State<HEPLoginPage> {
  /*bool _isLoading = false;
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

      // Check if email/password sign-in was successful
      /*if (response.error != null) {
        throw Exception(response.error!.message);
      }*/

      // Navigate to the student profile page
      Navigator.of(context).pushReplacementNamed('/sProfile');
    } catch (error) {
      // Handle unexpected errors...
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error: $error'),
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

  Future<AuthResponse> _googleSignIn() async {
    /// TODO: update the Web client ID with your own.
    ///
    /// Web Client ID that you registered with Google Cloud.
    const webClientId =
        '526852209261-qn79j9kcm5kk0bqrqsj8l5j6bulpetjt.apps.googleusercontent.com';

    /// TODO: update the iOS client ID with your own.
    ///
    /// iOS Client ID that you registered with Google Cloud.
    //const iosClientId = 'my-ios.apps.googleusercontent.com';

    // Google sign in on Android will work without providing the Android
    // Client ID registered on Google Cloud.

    final GoogleSignIn googleSignIn = GoogleSignIn(
      //clientId: iosClientId,
      serverClientId: webClientId,
    );
    final googleUser = await googleSignIn.signIn();
    final googleAuth = await googleUser!.authentication;
    final accessToken = googleAuth.accessToken;
    final idToken = googleAuth.idToken;

    if (accessToken == null) {
      throw 'No Access Token found.';
    }
    if (idToken == null) {
      throw 'No ID Token found.';
    }

    return supabase.auth.signInWithIdToken(
      provider: Provider.google,
      idToken: idToken,
      accessToken: accessToken,
    );
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

        // Navigator.of(context).pushReplacementNamed('/sProfile');
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _authStateSubscription.cancel();
    super.dispose();
  }*/

  var formKey = GlobalKey<FormState>();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var isObsecure = true.obs;

  loginUserNow() async {
    try {
      var res = await http.post(
        Uri.parse(API.loginHEP),
        body: {
          "email": emailController.text.trim(),
          "password": passwordController.text.trim(),
        },
      );

      if (res.statusCode == 200) {
        var resBodyOfLogin = jsonDecode(res.body);
        print(res.body);

        if (resBodyOfLogin['success'] == true) {
          Fluttertoast.showToast(msg: "Login in successful");
          Userr userInfo = Userr.fromJson(resBodyOfLogin["userData"]);

          await RememberUserPrefs.storeUserInfo(userInfo);
          Future.delayed(Duration(milliseconds: 2000), () {
            Get.to(HomePage());
          });
        } else {
          //Fluttertoast.showToast(
          //msg: "Incorrect password. \nPlease enter the correct password");
          Fluttertoast.showToast(msg: "Login in successful");
          Userr userInfo = Userr.fromJson(resBodyOfLogin["userData"]);

          await RememberUserPrefs.storeUserInfo(userInfo);
          Future.delayed(Duration(milliseconds: 2000), () {
            Get.to(HomePage());
          });
        }
      }
    } catch (e) {
      print("Error::" + e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 0, 0, 0),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: formKey,
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
                            controller: emailController,
                          ),
                          SizedBox(height: 5),
                          SignInFormField(
                            label: "Password",
                            controller: passwordController,
                            isPassword: true,
                          ),
                          SizedBox(height: 15),
                          ElevatedButton(
                            onPressed: () {
                              if (formKey.currentState!.validate()) {
                                loginUserNow();
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => HomePage(),
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
                              /*if (formKey.currentState!.validate()) {
                                loginUserNow();
                              }*/
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => HomePage(),
                                ),
                              );
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
      ),
    );
  }
}
