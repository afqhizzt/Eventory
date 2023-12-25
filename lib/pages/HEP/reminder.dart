import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Event Status',
      theme: ThemeData(
        primarySwatch: Colors.brown,
        scaffoldBackgroundColor: Colors.black,
        textTheme: TextTheme(
          bodyText2: TextStyle(color: Colors.white),
        ),
      ),
      home: HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: Text('Notifications'),
          bottom: TabBar(
            tabs: [
              Tab(text: 'Event Reminder'),
            ],
            indicatorColor: Colors.black,
          ),
        ),
        body: TabBarView(
          children: <Widget>[
            ...[
              CategoryPage(
                images: [
                  'https://d1csarkz8obe9u.cloudfront.net/posterpreviews/auditions-design-template-381abbb854d0e3ab94376d94471d9e6a_screen.jpg?ts=1636999425',
                  'http://www.flyinginkpot.com/wp-content/uploads/1418979779-TPO-NYE-Concert-poster.jpg',
                  'https://inspirasimediaonline.files.wordpress.com/2023/07/hausboom-music-2023_poster.png?w=768',
                  'https://www.dyeworks.net/images/npca_birdpark_full.png'
                ],
                descriptions: [
                  Description(
                    director: 'Hanis Hidayu',
                    eventApprover: 'Encik Saiful',
                    date: 'December 24, 2023',
                  ),
                  Description(
                    director: 'Hanbin',
                    eventApprover: 'Encik Rey',
                    date: 'January 12, 2024',
                  ),
                  Description(
                    director: 'Lee Chong Wei',
                    eventApprover: 'Encik Nizam',
                    date: 'January 14, 2024',
                  ),
                  Description(
                    director: 'Mimi Khalisya',
                    eventApprover: 'Puan Aimi',
                    date: 'January 31, 2024',
                  )
                ],
              ),
            ].map(
              (widget) => Padding(
                padding: const EdgeInsets.all(8.0),
                child: widget,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class CategoryPage extends StatelessWidget {
  final List<String> images;
  final List<Description> descriptions;

  CategoryPage({
    required this.images,
    required this.descriptions,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: List.generate(
          images.length,
          (index) => Column(
            children: [
              ImageSection(imageURL: images[index]),
              DescriptionSection(description: descriptions[index]),
            ],
          ),
        ),
      ),
    );
  }
}

class ImageSection extends StatelessWidget {
  final String imageURL;

  ImageSection({required this.imageURL});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 500,
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.white,
          width: 5.0,
        ),
        borderRadius: BorderRadius.circular(15.0),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10.0),
        child: Image.network(
          imageURL,
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}

class DescriptionSection extends StatelessWidget {
  final Description description;

  DescriptionSection({required this.description});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(36.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Director of the Event: ${description.director}',
            style: TextStyle(fontSize: 20.0),
          ),
          Text(
            'Event Approved By: ${description.eventApprover}',
            style: TextStyle(fontSize: 20.0),
          ),
          Text(
            'Date of Event: ${description.date}',
            style: TextStyle(fontSize: 20.0),
          ),
          SizedBox(height: 10),
          Row(
            children: [
              ElevatedButton(
                onPressed: () {
                  // Handle 'Remind Me' button click
                  _showRemindMeConfirmation(context);
                },
                child: Text('Remind Me This'),
              ),
              SizedBox(width: 10),
            ],
          ),
        ],
      ),
    );
  }

  void _showRemindMeConfirmation(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Theme(
          data: ThemeData.dark(),
          child: AlertDialog(
            title: Text(
              'Remind Me Confirmation',
              style: TextStyle(color: Colors.white),
              textAlign: TextAlign.center, // Center the title text
            ),
            content: Column(
              mainAxisSize: MainAxisSize.min, // Adjust the content size
              children: [
                Image.asset(
                  'image/alert.png', // Replace with your image path
                  height: 400, // Adjust the height as needed
                ),
                SizedBox(height: 16),
                Text(
                  'You will be reminded 1 day before the event!',
                  style: TextStyle(color: Colors.white, fontSize: 16),
                  textAlign: TextAlign.center, // Center the content text
                ),
              ],
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text(
                  'OK',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class Description {
  final String director;
  final String eventApprover;
  final String date;

  Description({
    required this.director,
    required this.eventApprover,
    required this.date,
  });
}
