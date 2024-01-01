import 'package:flutter/material.dart';
import 'club_profile.dart';

class EventPostedPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Column(
        children: <Widget>[
          SizedBox(height: 70),
          Container(
            width: double.infinity,
            height: 350,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('images/img_done.png'),
                fit: BoxFit.contain,
              ),
            ),
          ),
          SizedBox(height: 30),
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(50),
                  topRight: Radius.circular(50),
                ),
              ),
              width: double.infinity,
              padding: EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    "You posted",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 40,
                      fontFamily: 'NotoSans',
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    "your event!",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 40,
                      fontFamily: 'NotoSans',
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Text(
                    " Now you can view your event",
                    style: TextStyle(
                      color: Color(0xFF4C4C4C),
                      fontSize: 17,
                      fontFamily: 'NotoSans-Regular',
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    " on homepage!",
                    style: TextStyle(
                      color: Color(0xFF4C4C4C),
                      fontSize: 17,
                      fontFamily: 'NotoSans-Regular',
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                  SizedBox(height: 30),
                  Center(
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ClubProfilePage(),
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
                        fixedSize: MaterialStateProperty.all(
                          Size(200, 50),
                        ),
                      ),
                      child: Text(
                        "OK",
                        style: TextStyle(
                          color: Colors.white,
                          fontFamily: 'NotoSans-Regular',
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
