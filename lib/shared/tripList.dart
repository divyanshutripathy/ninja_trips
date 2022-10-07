import 'package:flutter/material.dart';
import 'package:ninja_trips/models/Trip.dart';
import 'package:ninja_trips/screens/Details.dart';

class TripList extends StatefulWidget {
  @override
  _TripListState createState() => _TripListState();
}

class _TripListState extends State<TripList> {
  int changeTile = -1;
  List<Widget> _tripTiles = [];
  final GlobalKey _listKey = GlobalKey();

  @override
  void initState() {
    super.initState();
    _addTrips();
  }

  void _addTrips() {
    // get data from db
    List<Trip> _trips = [
      Trip(title: 'Beach Paradise', price: '350', nights: '3', img: 'beach.png'),
      Trip(title: 'City Break', price: '400', nights: '5', img: 'city.png'),
      Trip(title: 'Ski Adventure', price: '750', nights: '2', img: 'ski.png'),
      Trip(title: 'Space Blast', price: '600', nights: '4', img: 'space.png'),
    ];

    _trips.asMap().forEach((int index, Trip trip) {
      _tripTiles.add(_buildTile(index, trip));
    });
  }

  nextPage(trip, index) async {
    setState(() {
      changeTile = index;
    });
    await Future.delayed(const Duration(seconds: 1));
    Navigator.push(context, MaterialPageRoute(builder: (context) => Details(trip: trip)));
    setState(() {
      changeTile = -1;
    });
  }

  Widget _buildTile(int index, Trip trip) {
    return Material(
      //duration: const Duration(seconds: 1),
      child: ListTile(
        onTap: () {
          nextPage(trip, index);
        },
        contentPadding: EdgeInsets.all(25),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text('${trip.nights} nights',
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.blue[300])),
            Text(trip.title, style: TextStyle(fontSize: 20, color: Colors.grey[600])),
          ],
        ),
        leading: ClipRRect(
          borderRadius: BorderRadius.circular(8.0),
          child: Image.asset(
            'images/${trip.img}',
            height: 50.0,
          ),
        ),
        trailing: Text('\$${trip.price}'),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        key: _listKey,
        itemCount: _tripTiles.length,
        itemBuilder: (context, index) {
          return AnimatedContainer(
            duration: const Duration(seconds: 1),
            width: 0,
            //margin: EdgeInsets.symmetric(horizontal: changeTile ? 200 : 0, vertical: 0.0),
            margin: EdgeInsets.only(left: changeTile == index ? 600.0 : 0.0, right: 0),
            child: Container(
              child: _tripTiles[index],
            ),
          );
        });
  }
}
