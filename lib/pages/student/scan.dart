import 'package:flutter/material.dart';
import 'student_profile.dart';

class ScanPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(height: 50),
            Text(
              "Scan your",
              style: TextStyle(
                color: Colors.white,
                fontSize: 30,
                fontFamily: 'NotoSans',
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              "attendance",
              style: TextStyle(
                color: Colors.white,
                fontSize: 30,
                fontFamily: 'NotoSans',
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 20),
            Expanded(
              child: Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(30),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // Add your image here
                    Image.asset(
                      'images/img_image_3.png',
                      height: 400, // Adjust the height as needed
                    ),
                    SizedBox(height: 40),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            primary: Colors.black, // Button background color
                          ),
                          onPressed: () {
                            // Implement the action for "Scan from Gallery" button
                          },
                          child: Text(
                            "Scan from Gallery",
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            primary: Colors.black, // Button background color
                          ),
                          onPressed: () {
                            // Navigate back when "Cancel" button is pressed
                            Navigator.pop(context);
                          },
                          child: Text(
                            "Cancel",
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
