import 'package:flutter/material.dart';

class HelloFlutter extends StatefulWidget {
  const HelloFlutter({super.key});

  @override
  _HelloFlutterState createState() => _HelloFlutterState();
}

class _HelloFlutterState extends State<HelloFlutter> {
  Color studentButtonColor = Colors.black;
  Color studentTextColor = Colors.white;

  Color clubButtonColor = Colors.white;
  Color clubTextColor = Colors.black;

  Color hepButtonColor = Colors.white;
  Color hepTextColor = Colors.black;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Column(
        children: <Widget>[
          Container(
            width: double.infinity,
            height: 450,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('images/img_saly_12.png'),
                fit: BoxFit.contain,
              ),
            ),
          ),
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
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Welcome to",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 40,
                      fontFamily: 'NotoSans',
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    "Eventory",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 40,
                      fontFamily: 'NotoSans',
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Text(
                    "Where Finding and Organizing Events\nHas Never Been Easier!",
                    style: TextStyle(
                      color: Color(0xFF4C4C4C),
                      fontSize: 17,
                      fontFamily: 'NotoSans-Regular',
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                  SizedBox(
                    height: 50,
                  ),
                  Text(
                    "Choose your role:",
                    style: TextStyle(
                      color: Color.fromARGB(225, 0, 0, 0),
                      fontSize: 17,
                      fontFamily: 'NotoSans-Regular',
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      AnimatedContainer(
                        duration: Duration(milliseconds: 300),
                        height: 45,
                        width: MediaQuery.of(context).size.width * 0.28,
                        child: TextButton(
                          child: Text(
                            "Student",
                            style: TextStyle(
                              color: studentTextColor,
                            ),
                          ),
                          style: ButtonStyle(
                            backgroundColor:
                                MaterialStateProperty.all(studentButtonColor),
                            shape: MaterialStateProperty.all(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30),
                                side: BorderSide(color: Colors.grey),
                              ),
                            ),
                          ),
                          onPressed: () {
                            setState(() {
                              studentButtonColor = Colors.black;
                              studentTextColor = Colors.white;
                              clubButtonColor = Colors.white;
                              clubTextColor = Colors.black;
                              hepButtonColor = Colors.white;
                              hepTextColor = Colors.black;
                            });
                            Navigator.pushNamed(context, '/UserRegistration');
                          },
                        ),
                      ),
                      SizedBox(width: 12),
                      AnimatedContainer(
                        duration: Duration(milliseconds: 300),
                        height: 45,
                        width: MediaQuery.of(context).size.width * 0.28,
                        child: TextButton(
                          child: Text(
                            "Club",
                            style: TextStyle(
                              color: clubTextColor,
                            ),
                          ),
                          style: ButtonStyle(
                            backgroundColor:
                                MaterialStateProperty.all(clubButtonColor),
                            shape: MaterialStateProperty.all(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30),
                                side: BorderSide(color: Colors.grey),
                              ),
                            ),
                          ),
                          onPressed: () {
                            setState(() {
                              studentButtonColor = Colors.white;
                              studentTextColor = Colors.black;
                              clubButtonColor = Colors.black;
                              clubTextColor = Colors.white;
                              hepButtonColor = Colors.white;
                              hepTextColor = Colors.black;
                            });
                            Navigator.pushNamed(context, '/UserRegistration');
                          },
                        ),
                      ),
                      SizedBox(width: 12),
                      AnimatedContainer(
                        duration: Duration(milliseconds: 300),
                        height: 45,
                        width: MediaQuery.of(context).size.width * 0.28,
                        child: TextButton(
                          child: Text(
                            "HEP",
                            style: TextStyle(
                              color: hepTextColor,
                            ),
                          ),
                          style: ButtonStyle(
                            backgroundColor:
                                MaterialStateProperty.all(hepButtonColor),
                            shape: MaterialStateProperty.all(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30),
                                side: BorderSide(color: Colors.grey),
                              ),
                            ),
                          ),
                          onPressed: () {
                            setState(() {
                              studentButtonColor = Colors.white;
                              studentTextColor = Colors.black;
                              clubButtonColor = Colors.white;
                              clubTextColor = Colors.black;
                              hepButtonColor = Colors.black;
                              hepTextColor = Colors.black;
                            });
                            Navigator.pushNamed(context, '/UserRegistration');
                          },
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
    );
  }
}
