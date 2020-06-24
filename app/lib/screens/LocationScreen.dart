import 'package:android_intent/android_intent.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:knowyourneighbourapp/screens/chat_screen.dart';

//import 'chat_screen.dart';

void main() {
  runApp(new LocationScreen());
}

class LocationScreen extends StatefulWidget {
  static const String id='location';
  @override
  _LocationScreenState createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {

  final Geolocator geolocator = Geolocator()..forceAndroidLocationManager;

  String _locationMessage = "";

  void openLocationSetting() async {
    final AndroidIntent intent = new AndroidIntent(
      action: 'android.settings.LOCATION_SOURCE_SETTINGS',
    );
    await intent.launch();
  }

  void _getCurrentLocation() async {

    final position = await geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);

    List<Placemark> newPlace = await geolocator.placemarkFromCoordinates(position.latitude, position.longitude);

    // this is all you need
    Placemark placeMark  = newPlace[0];
    String name = placeMark.name;
    String subLocality = placeMark.subLocality;
    String locality = placeMark.locality;
    String administrativeArea = placeMark.administrativeArea;
    String postalCode = placeMark.postalCode;
    String country = placeMark.country;
    String address = "$name, $subLocality, $locality, $administrativeArea $postalCode, $country";

    print(address);

    setState(() {
      address = address; // update _address
    });

  }
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Demo',
        home: Scaffold(
            appBar: AppBar(
                title: Text("Location Services")
            ),
            body: Align(
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(_locationMessage),
                    FlatButton(
                        onPressed: () {
                          openLocationSetting();
                          _getCurrentLocation();
                          Navigator.pushNamed(context,ChatScreen.id);
                        },
                        color: Colors.green,
                        child: Text("Find Location")
                    )
                  ]),
            )
        )
    );
  }
}