import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:rowdy_hacks/landing/place_card.dart';
import 'package:qrscan/qrscan.dart' as scanner;

class Places extends StatefulWidget {
  Places({Key key}) : super(key: key);

  @override
  _PlacesState createState() => _PlacesState();
}

class _PlacesState extends State<Places> {
  String _url="";
  @override
  Widget build(BuildContext context) {
    return Stack(children: <Widget>[
      ListView(
        children:<Widget>[
            PlaceCard("Sample card 1", "Description"),
            PlaceCard("Sample card 2", "Description"),
            PlaceCard("Sample card 2", "Description"),
            PlaceCard("Sample card 2", "Description"),
            PlaceCard("Sample card 2", "Description"),
            PlaceCard("Sample card 2", "Description"),
            PlaceCard("Sample card 2", "Description"),
            PlaceCard("Sample card 2", "Description"),
            PlaceCard("Sample card 2", "Description"),
            PlaceCard("Sample card 2", "Description"),
            PlaceCard("Sample card 2", "Description"),
          ],
        ),
      Positioned(
        child: FloatingActionButton(
          onPressed: () async{
            await Permission.camera.request();
            String cameraScanResult = await scanner.scan();
            setState(() {
              _url=cameraScanResult;
            });
          },
          mini: true,
          tooltip: 'Take a Photo',
          child: const Icon(Icons.qr_code_scanner),
        ),
        right: 10.0,
        bottom: 4,
      )
    ]);
  }
}
