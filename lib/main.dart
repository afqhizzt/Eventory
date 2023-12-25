import 'package:flutter/material.dart';
import 'pages/student/student_profile.dart';
import 'pages/club/club_profile.dart';
import 'pages/HEP/HEP_profile.dart';
import 'pages/hello_flutter.dart';
import 'pages/student/student_registration.dart';
import 'pages/club/club_registration.dart';
import 'pages/HEP/hep_registration.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Supabase.initialize(
    url: 'https://vcovqppyuefuhgxoquqx.supabase.co',
    anonKey:
        'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InZjb3ZxcHB5dWVmdWhneG9xdXF4Iiwicm9sZSI6ImFub24iLCJpYXQiOjE3MDE3NTU4NTQsImV4cCI6MjAxNzMzMTg1NH0._0U-SIXxjNtHHlEoTlFTgfwsOWmXPxVBbT1Wm15oJz0',
    authFlowType: AuthFlowType.pkce,
  );
  runApp(MyApp());
}

final supabase = Supabase.instance.client;

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.deepPurple),
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
