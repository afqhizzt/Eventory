import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../api_connection/api_connection.dart';
import 'hep_event_details.dart';
import 'hep_profile.dart';
import 'hep_search.dart';
import 'hep_homepage.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark().copyWith(
        primaryColor: Colors.black,
        textTheme: TextTheme(
          bodyText2: TextStyle(
              color: Colors.white, fontSize: 19.0), // Increased text size
        ),
      ),
      home: EventListPage(),
    );
  }
}

class Event {
  final int index;
  final String eventName;
  final bool isChecked;
  final DateTime eventDate;

  Event({
    required this.index,
    required this.eventName,
    required this.isChecked,
    required this.eventDate,
  });
}

class EventListPage extends StatelessWidget {
  final List<Event> events = [
    Event(
        index: 1,
        eventName: 'MarathonMania',
        eventDate: DateTime.now(),
        isChecked: false),
    Event(
        index: 2,
        eventName: 'XtremeXperience',
        eventDate: DateTime.now().add(Duration(days: 1)),
        isChecked: false),
    Event(
        index: 3,
        eventName: 'TechTrek',
        eventDate: DateTime.now().add(Duration(days: 2)),
        isChecked: false),
    Event(
        index: 4,
        eventName: 'IdeaIgnite',
        eventDate: DateTime.now().add(Duration(days: 3)),
        isChecked: false),
    Event(
        index: 5,
        eventName: 'InnovateSphere',
        eventDate: DateTime.now().add(Duration(days: 4)),
        isChecked: false),
    Event(
        index: 6,
        eventName: 'MelodyFest',
        eventDate: DateTime.now().add(Duration(days: 5)),
        isChecked: false),
    Event(
        index: 7,
        eventName: 'HarmonyJam',
        eventDate: DateTime.now().add(Duration(days: 6)),
        isChecked: false),
    Event(
        index: 8,
        eventName: 'SonicSpectra',
        eventDate: DateTime.now().add(Duration(days: 7)),
        isChecked: false),
    Event(
        index: 9,
        eventName: 'RoboRenaissance',
        eventDate: DateTime.now().add(Duration(days: 8)),
        isChecked: false),
    Event(
        index: 10,
        eventName: 'Inventor\'sInsight',
        eventDate: DateTime.now().add(Duration(days: 9)),
        isChecked: true),
    Event(
        index: 11,
        eventName: 'DisruptDev',
        eventDate: DateTime.now().add(Duration(days: 10)),
        isChecked: true),
    Event(
        index: 12,
        eventName: 'ThinkTank',
        eventDate: DateTime.now().add(Duration(days: 11)),
        isChecked: true),
    Event(
        index: 13,
        eventName: 'ThriveRhythm',
        eventDate: DateTime.now().add(Duration(days: 12)),
        isChecked: true),
    Event(
        index: 14,
        eventName: 'Revolution',
        eventDate: DateTime.now().add(Duration(days: 13)),
        isChecked: true),
    Event(
        index: 15,
        eventName: 'BeatFusion',
        eventDate: DateTime.now().add(Duration(days: 14)),
        isChecked: true),
    Event(
        index: 16,
        eventName: 'AcousticAlchemy',
        eventDate: DateTime.now().add(Duration(days: 15)),
        isChecked: true),
    Event(
        index: 17,
        eventName: 'GrooveGala',
        eventDate: DateTime.now().add(Duration(days: 16)),
        isChecked: true),
    Event(
        index: 18,
        eventName: 'SymphonyShowdown',
        eventDate: DateTime.now().add(Duration(days: 17)),
        isChecked: true),
    Event(
        index: 19,
        eventName: 'PulsePalooza',
        eventDate: DateTime.now().add(Duration(days: 18)),
        isChecked: true),
    Event(
        index: 20,
        eventName: 'SoundSafari',
        eventDate: DateTime.now().add(Duration(days: 19)),
        isChecked: true),
    // Add more events as needed
  ];

  @override
  Widget build(BuildContext context) {
    // Sort the events with 'not approved' status first and index in ascending order
    events.sort((a, b) {
      if (a.isChecked && !b.isChecked) {
        return 1;
      } else if (!a.isChecked && b.isChecked) {
        return -1;
      } else {
        return a.index.compareTo(b.index);
      }
    });

    return Scaffold(
      appBar: AppBar(
        title: Text('Event List'),
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: DataTable(
            columns: [
              DataColumn(label: Text('Index')),
              DataColumn(label: Text('Event Name')),
              DataColumn(label: Text('Status')),
              DataColumn(label: Text('Event Date')),
            ],
            rows: events.map((event) {
              return DataRow(
                cells: [
                  DataCell(Text('${event.index}')),
                  DataCell(Container(
                    width: 200, // Adjust the width as needed
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Text(event.eventName),
                    ),
                  )),
                  DataCell(Icon(event.isChecked ? Icons.check : Icons.clear)),
                  DataCell(Text(
                      '${event.eventDate.day}/${event.eventDate.month}/${event.eventDate.year}')),
                ],
              );
            }).toList(),
          ),
        ),
      ),
    );
  }
}
