import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'dart:async';
import 'student_homepage.dart';

class ProfilePage extends StatelessWidget {
  final GoogleSignInAccount? user;

  ProfilePage({Key? key, required this.user}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Function to navigate to HomePage after a delay
    void navigateToHomePage() {
      Future.delayed(Duration(seconds: 5), () {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => HomePage(),
          ),
        );
      });
    }

    // Call the function to start the delay when the page is built
    navigateToHomePage();

    return Scaffold(
      appBar: AppBar(
        title: Text(''),
        automaticallyImplyLeading: false,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Text(
                'Successfully Logged In with Google',
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            SizedBox(height: 30),
            if (user != null)
              CircleAvatar(
                backgroundImage: NetworkImage(user!.photoUrl ?? ''),
                radius: 100,
              ),
            SizedBox(height: 60),
            if (user != null)
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding:
                        const EdgeInsets.only(left: 20.0), // Add left padding
                    child: Text(
                      'Name: ${user!.displayName ?? 'N/A'}',
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                  ),
                  SizedBox(height: 10),
                  Padding(
                    padding:
                        const EdgeInsets.only(left: 20.0), // Add left padding
                    child: Text(
                      'Email: ${user!.email ?? 'N/A'}',
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                  ),
                ],
              ),
          ],
        ),
      ),
    );
  }
}
