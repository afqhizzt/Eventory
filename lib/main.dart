import 'package:flutter/material.dart';
import 'pages/student/student_profile.dart';
import 'pages/club/club_profile.dart';
import 'pages/HEP/HEP_profile.dart';
import 'pages/hello_flutter.dart';
import 'pages/student/student_registration.dart';
import 'pages/club/club_registration.dart';
import 'pages/HEP/hep_registration.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        //colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.deepPurple),
        useMaterial3: true,
      ),
      initialRoute: '/',
      routes: <String, WidgetBuilder>{
        '/': (context) => HelloFlutter(),
        '/UserRegistration': (context) => UserRegistration(),
        '/ClubRegistration': (context) => ClubRegistration(),
        '/HEPRegistration': (context) => HEPRegistration(),
        '/sProfile': (_) => StudentProfilePage(),
        '/cProfile': (_) => ClubProfilePage(),
        '/hProfile': (_) => HEPProfilePage(),
      },
    );
  }
}
