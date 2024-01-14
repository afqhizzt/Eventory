import 'package:flutter/material.dart';

class AddPostScreen extends StatefulWidget {
  @override
  _AddPostScreenState createState() => _AddPostScreenState();
}

class _AddPostScreenState extends State<AddPostScreen> {
  TextEditingController diaryController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Diary Entry'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: diaryController,
              maxLines: 8,
              decoration: InputDecoration(
                hintText: 'Write your diary entry...',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                // Handle the "Submit" button press
                String diaryEntry = diaryController.text;
                // You can now send 'diaryEntry' to your backend or process it as needed
                // Navigator.pop(context, true); // Return true if the diary entry is added successfully
              },
              child: Text('Submit'),
            ),
          ],
        ),
      ),
    );
  }
}
