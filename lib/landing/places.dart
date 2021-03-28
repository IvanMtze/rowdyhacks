import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:rowdy_hacks/landing/image_page.dart';
import 'package:rowdy_hacks/landing/place_card.dart';
import 'package:qrscan/qrscan.dart' as scanner;
import 'package:rowdy_hacks/services/restaurant_service.dart';

class Places extends StatefulWidget {
  Places({Key key}) : super(key: key);

  @override
  _PlacesState createState() => _PlacesState();
}

class _PlacesState extends State<Places> {
  String _url = "";
  List<Restaurant> _list;
  List<Widget> _widget_list = <Widget>[];
  RestaurantService restaurantService = RestaurantService();
  @override
  Widget build(BuildContext context) {
    getData();
    return Stack(children: <Widget>[
      ListView(children: _widget_list),
      Positioned(
        child: FloatingActionButton(
          onPressed: () async {
            await Permission.camera.request();
            String cameraScanResult = await scanner.scan();
            setState(() {
              _url = cameraScanResult;
              if (_url.isNotEmpty) {
                Navigator.pushNamed(
                  context,
                  "/imageview",
                  arguments: ScreenArguments(
                    _url,
                  ),
                );
              }
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

  Future<void> getData() async {
    _list = await restaurantService.getAllRestaurants();
    _widget_list = <Widget>[];
    setState(() {
      _list.forEach((element) {
        _widget_list
            .add(PlaceCard(element.title, element.description, element.url_qr));
      });
    });
  }
}
