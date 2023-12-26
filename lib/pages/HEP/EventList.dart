import 'package:flutter/material.dart';

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
          bodyText2: TextStyle(color: Colors.white, fontSize: 19.0), // Increased text size
        ),
      ),
      home: EventListPage(),
    );
  }
}

class Event {
  final int index;
  final String eventName;
  final DateTime eventDate;
  final bool isChecked;

  Event({
    required this.index,
    required this.eventName,
    required this.eventDate,
    required this.isChecked,
  });
}

class EventListPage extends StatelessWidget {
  final List<Event> events = [
    Event(index: 1, eventName: 'MarathonMania', eventDate: DateTime.now(), isChecked: false),
    Event(index: 2, eventName: 'XtremeXperience', eventDate: DateTime.now().add(Duration(days: 1)), isChecked: true),
    Event(index: 3, eventName: 'TechTrek', eventDate: DateTime.now().add(Duration(days: 2)), isChecked: false),
    Event(index: 4, eventName: 'IdeaIgnite', eventDate: DateTime.now().add(Duration(days: 3)), isChecked: true),
    Event(index: 5, eventName: 'InnovateSphere', eventDate: DateTime.now().add(Duration(days: 4)), isChecked: false),
    Event(index: 6, eventName: 'MelodyFest', eventDate: DateTime.now().add(Duration(days: 5)), isChecked: true),
    Event(index: 7, eventName: 'HarmonyJam', eventDate: DateTime.now().add(Duration(days: 6)), isChecked: false),
    Event(index: 8, eventName: 'SonicSpectra', eventDate: DateTime.now().add(Duration(days: 7)), isChecked: true),
    Event(index: 9, eventName: 'RoboRenaissance', eventDate: DateTime.now().add(Duration(days: 8)), isChecked: false),
    Event(index: 10, eventName: 'Inventor\'sInsight', eventDate: DateTime.now().add(Duration(days: 9)), isChecked: true),
    Event(index: 11, eventName: 'DisruptDev', eventDate: DateTime.now().add(Duration(days: 10)), isChecked: false),
    Event(index: 12, eventName: 'ThinkTank', eventDate: DateTime.now().add(Duration(days: 11)), isChecked: true),
    Event(index: 13, eventName: 'ThriveRhythm', eventDate: DateTime.now().add(Duration(days: 12)), isChecked: false),
    Event(index: 14, eventName: 'Revolution', eventDate: DateTime.now().add(Duration(days: 13)), isChecked: true),
    Event(index: 15, eventName: 'BeatFusion', eventDate: DateTime.now().add(Duration(days: 14)), isChecked: false),
    Event(index: 16, eventName: 'AcousticAlchemy', eventDate: DateTime.now().add(Duration(days: 15)), isChecked: true),
    Event(index: 17, eventName: 'GrooveGala', eventDate: DateTime.now().add(Duration(days: 16)), isChecked: false),
    Event(index: 18, eventName: 'SymphonyShowdown', eventDate: DateTime.now().add(Duration(days: 17)), isChecked: true),
    Event(index: 19, eventName: 'PulsePalooza', eventDate: DateTime.now().add(Duration(days: 18)), isChecked: false),
    Event(index: 20, eventName: 'SoundSafari', eventDate: DateTime.now().add(Duration(days: 19)), isChecked: true),
    // Add more events as needed
  ];

  @override
  Widget build(BuildContext context) {
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
              DataColumn(label: Text('Event Date')),
              DataColumn(label: Text('Status')),
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
                  DataCell(Text('${event.eventDate.day}/${event.eventDate.month}/${event.eventDate.year}')),
                  DataCell(Icon(event.isChecked ? Icons.check : Icons.clear)),
                ],
              );
            }).toList(),
          ),
        ),
      ),
    );
  }
}
