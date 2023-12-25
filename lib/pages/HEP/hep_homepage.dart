import 'package:flutter/material.dart';
import 'package:tryyy/pages/HEP/hep_event_details.dart';
import 'hep_search.dart';
import 'HEP_profile.dart';

class Post {
  final String username;
  final String imageUrl;
  final String caption;

  Post({
    required this.username,
    required this.imageUrl,
    required this.caption,
  });
}

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3, // Number of tabs
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            'Event Status',
            style: TextStyle(
              fontFamily: 'NotoSans',
            ),
          ),
          automaticallyImplyLeading: false, // Remove back button
          backgroundColor: Colors.white, // Set background color to white
          bottom: TabBar(
            tabs: [
              Tab(text: 'To Be Approved Events'),
            ],
            indicatorColor: Colors.black,
          ),
        ),
        body: TabBarView(
          children: <Widget>[
            SingleChildScrollView(
              child: Column(
                children: [
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
                        date: 'September 9&10, 2023',
                      ),
                      Description(
                        director: 'Hanbin',
                        eventApprover: 'Encik Rey',
                        date: 'September 19, 2023',
                      ),
                      Description(
                        director: 'Lee Chong Wei',
                        eventApprover: 'Encik Nizam',
                        date: 'December 25, 2022',
                      ),
                      Description(
                        director: 'Mimi Khalisya',
                        eventApprover: 'Puan Aimi',
                        date: 'May 5, 2022',
                      )
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
        bottomNavigationBar: Theme(
          data: Theme.of(context).copyWith(
            canvasColor: Colors.white,
          ),
          child: BottomNavigationBar(
            showSelectedLabels: true,
            showUnselectedLabels: true,
            unselectedItemColor: Colors.black,
            selectedItemColor: Colors.black,
            backgroundColor:
                Colors.white, // Set navigation background color to white
            onTap: (index) {
              if (index == 0) {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => HomePage()),
                );
              } else if (index == 1) {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => SearchScreen()),
                );
              } else if (index == 2) {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => EventDetailsPage()),
                );
              } else if (index == 3) {
                // Handle 'Notification' action
                // You can implement the logic here
                print('Tapped on Notification');
              } else if (index == 4) {
                // Handle 'Profile' action
                // You can implement the logic here
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => HEPProfilePage()),
                );
              }
            },
            items: [
              BottomNavigationBarItem(
                icon: Icon(Icons.home),
                label: 'Home',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.search),
                label: 'Search',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.center_focus_strong),
                label: 'Status',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.notifications),
                label: 'Notification',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.person),
                label: 'Profile',
              ),
            ],
          ),
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
                  print('Event Approved');
                },
                child: Text('Approve Event'),
              ),
              SizedBox(width: 10),
              ElevatedButton(
                onPressed: () {
                  print('Event Not Approved');
                },
                child: Text('Not Approve'),
              ),
            ],
          ),
        ],
      ),
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
