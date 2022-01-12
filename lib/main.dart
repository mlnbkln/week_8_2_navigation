import 'package:flutter/material.dart';

void main() {
  runApp(PlacesApp());
}

const List<String> places = [
  "Chatsworth",
  "Castleton",
  "Curbar Edge"
];

const List<String> placesImages = [
  "assets/images/Chatsworth.jpeg",
  "assets/images/Cottage.jpeg",
  "assets/images/Curbar.jpeg"
];

const List<String> placesDescription = [
  "Chatsworth is indisputably the jewel in the crown of the Peak District. Home to the Cavendish family since the 16th Century, Chatsworth House is a magnificent English country house set in over 1,000 acres of parkland, with over 100 acres of stunning formal gardens, a Farmyard and children’s Adventure Playground, as well as cafés and gift shops.",
  "Castleton is located on the border of the gritstone Dark Peak and the limestone White Peak areas of the Peak District, and the typical features of both landscapes can be seen in the hills that surround the village on three sides.",
  "The Curbar Edge walk is of average difficulty, as it passes over rough and steep ground at times.  The total distance of the walk is just less than 7 miles, and it is advised to allow between 3-4 hours in order to complete the walk.  Curbar Ridge provides excellent views of the Derwent valley and the surrounding countryside.",
];


class PlacesApp extends StatefulWidget {
  const PlacesApp({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _PlacesApp();
}

class _PlacesApp extends State<PlacesApp> {
  int _selectedPlace = -1;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Attractions in the Peak District',
      home: Navigator(
        pages: [
          MaterialPage(
            key: ValueKey('PlacesPage'),
            child: PlacesScreen(
              onTapped: _handlePageTapped,
            ),
          ),
          if (_selectedPlace != -1)
            MaterialPage(
                key: ValueKey(_selectedPlace),
    child: PlaceScreen(index:_selectedPlace)
            )
        ],
        onPopPage: (route, result) {
          if (!route.didPop(result)) return false;
         setState(() {
           _selectedPlace = -1;
         });

          return true;
        },
      ),
    );
  }

  void _handlePageTapped(int index) {
    setState(() {
      _selectedPlace = index;
    });
  }
}

class PlacesScreen extends StatelessWidget {
 ValueChanged<int> onTapped;

  PlacesScreen({
    required this.onTapped});

  @override
    Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Attractions in the Peak District"),
        centerTitle: true,
      ),
      body: ListView.builder(
    itemCount: places.length,
    itemBuilder: (BuildContext context, int index) {
      return ListTile(
      leading: CircleAvatar(
      backgroundImage: AssetImage(placesImages[index]),),
    title: Text(places[index],
      style: const TextStyle(
          fontStyle: FontStyle.italic,
          fontSize: 18.0),),
    onTap: () => onTapped(index),
    );
      },
      )
    );
  }
}

class PlaceScreen extends StatelessWidget {
  int index;

  PlaceScreen({
    required this.index,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
      title: Text(places[index]),
      centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Image(image: AssetImage(placesImages[index]),),
              SizedBox(height: 15.0,),
              Text(placesDescription[index],
                  style: const TextStyle(fontStyle: FontStyle.italic),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

