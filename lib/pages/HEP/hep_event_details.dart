import 'package:flutter/material.dart';
import 'hep_homepage.dart';
import 'hep_search.dart';
import 'hep_profile.dart';

class EventDetailsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3, // Number of tabs
      child: Scaffold(
        appBar: AppBar(
          title: Text('Event Status'),
          automaticallyImplyLeading: false,
          bottom: TabBar(
            tabs: [
              Tab(text: 'Approved Events'),
              Tab(text: 'Non Approved Events'),
              Tab(text: 'Past Events'),
            ],
            indicatorColor: Colors.black, // Set the indicator color
          ),
        ),
        body: TabBarView(
          children: <Widget>[
            // Add your other TabBarView content here
            ...[
              CategoryPage(
                images: [
                  'https://d1csarkz8obe9u.cloudfront.net/posterpreviews/auditions-design-template-381abbb854d0e3ab94376d94471d9e6a_screen.jpg?ts=1636999425',
                  'http://www.flyinginkpot.com/wp-content/uploads/1418979779-TPO-NYE-Concert-poster.jpg'
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
                    date: 'September 9&10, 2023',
                  ),
                ],
              ),
              CategoryPage(
                images: [
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
                    director: 'Lee Chong Wei',
                    eventApprover: 'Encik Nizam',
                    date: 'December 25, 2022',
                  ),
                ],
              ),
              CategoryPage(
                images: [
                  'http://2.bp.blogspot.com/-QgccMy-hGBA/Tm9kfTj0L7I/AAAAAAAAAE0/RS7G3OaW6Xs/s640/innovation+master+for+utm.jpg',
                  'http://greyareanews.com/wp-content/uploads/2016/09/Audition-Poster-Sting-Gangsters.jpg'
                ],
                descriptions: [
                  Description(
                    director: 'Lee Chong Wei',
                    eventApprover: 'Encik Nizam',
                    date: 'December 25, 2022',
                  ),
                  Description(
                    director: 'Lee Chong Wei',
                    eventApprover: 'Encik Nizam',
                    date: 'December 25, 2022',
                  ),
                ],
              ),
            ].map((widget) => Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: widget,
                )),
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
      height: 500, // Adjust the height as needed
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.white,
          width: 5.0,
        ),
        borderRadius: BorderRadius.circular(15.0), // Make borders round
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10.0), // Adjust the clip radius
        child: Image.network(
          imageURL,
          fit: BoxFit.cover, // Adjust the fit to cover the entire box
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
            style: TextStyle(fontSize: 20.0), // Adjust the font size here
          ),
          Text(
            'Event Approved By: ${description.eventApprover}',
            style: TextStyle(fontSize: 20.0), // Adjust the font size here
          ),
          Text(
            'Date of Event: ${description.date}',
            style: TextStyle(fontSize: 20.0), // Adjust the font size here
          ),
          // Add more description content as needed
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
