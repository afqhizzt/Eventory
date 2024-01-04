import 'package:flutter/material.dart';
import 'EventList.dart';

class EventSummaryPage extends StatelessWidget {
  final List<Event> events;

  EventSummaryPage({required this.events});

  @override
  Widget build(BuildContext context) {
    // Count approved and not approved events
    int approvedCount = events.where((event) => event.isChecked).length;
    int notApprovedCount = events.length - approvedCount;

    return Scaffold(
      appBar: AppBar(
        title: Text('Event Summary'),
      ),
      body: Center(
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(height: 10),
              Container(
                decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 255, 255, 255),
                  border: Border.all(color: Color.fromARGB(255, 255, 255, 255)),
                ),
                child: DataTable(
                  columns: [
                    DataColumn(label: Text('Status')),
                    DataColumn(label: Text('Count')),
                  ],
                  rows: [
                    DataRow(cells: [
                      DataCell(Text('Approved')),
                      DataCell(Text('$approvedCount')),
                    ]),
                    DataRow(cells: [
                      DataCell(Text('Not Approved')),
                      DataCell(Text('$notApprovedCount')),
                    ]),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      backgroundColor: Color.fromARGB(255, 33, 33, 33),
    );
  }
}
