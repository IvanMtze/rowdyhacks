import 'dart:io';
import 'dart:typed_data';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/scheduler.dart';
import 'package:geolocator/geolocator.dart';
import 'package:qrscan/qrscan.dart' as scanner;

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:image_picker/image_picker.dart';
import 'package:rowdy_hacks/services/restaurant_service.dart';

class RegisterRestaurant extends StatefulWidget {
  RegisterRestaurant({Key key}) : super(key: key);

  @override
  _RegisterRestaurantState createState() => _RegisterRestaurantState();
}

class _RegisterRestaurantState extends State<RegisterRestaurant> {
  TextEditingController _controllerTitle;

  TextEditingController _controllerDescription;
  Position _pos;
  @override
  void initState() {
    _controllerTitle = TextEditingController();
    _controllerDescription = TextEditingController();
    _loading = false;
  }

  ImagePicker picker = ImagePicker();

  bool _hasLocation = false;
  int _currentStep = 0;
  Color _location_color = Colors.blueGrey;
  Color _image_color = Colors.blueGrey;

  File _image;
  bool _loading = false;

  BuildContext _context;

  @override
  Widget build(BuildContext context) {
    _context = context;

    return Scaffold(
      appBar: AppBar(
        title: Text("Add a place information"),
      ),
      body: ListView(
        children: <Widget>[
          Column(
            children: [
              Stepper(
                type: StepperType.vertical,
                physics: ScrollPhysics(),
                currentStep: _currentStep,
                onStepTapped: (step) => tapped(step),
                onStepContinue: continued,
                onStepCancel: cancel,
                steps: <Step>[
                  new Step(
                    title: new Text('Title'),
                    content: Column(
                      children: [
                        TextField(
                          controller: _controllerTitle,
                          decoration:
                              InputDecoration(hintText: 'Enter the title'),
                        ),
                      ],
                    ),
                    isActive: _currentStep >= 0,
                    state: _currentStep >= 0 &&
                            _controllerTitle.value.text.isNotEmpty
                        ? StepState.complete
                        : StepState.disabled,
                  ),
                  new Step(
                    title: new Text('Quick Description'),
                    content: TextField(
                      controller: _controllerDescription,
                      decoration:
                          InputDecoration(hintText: 'Enter small description'),
                    ),
                    isActive: _currentStep >= 0,
                    state: _currentStep >= 1 &&
                            _controllerDescription.value.text.isNotEmpty
                        ? StepState.complete
                        : StepState.disabled,
                  ),
                  new Step(
                    title: new Text('Pick Location'),
                    content: InkWell(
                      child: Container(
                        child: Row(
                          children: <Widget>[
                            Icon(
                              Icons.place,
                              color: _location_color,
                            ),
                            Text("Click me to add a location")
                          ],
                        ),
                      ),
                      onTap: _determinePosition,
                    ),
                    isActive: _currentStep >= 0,
                    state: _currentStep >= 2 && _hasLocation
                        ? StepState.complete
                        : StepState.disabled,
                  ),
                  new Step(
                    title: new Text('Imagenes'),
                    content: InkWell(
                      child: Container(
                        child: Row(
                          children: <Widget>[
                            Icon(Icons.photo, color: _image_color),
                            Text("Click me to add a photo")
                          ],
                        ),
                      ),
                      onTap: getImage,
                    ),
                    isActive: _currentStep >= 0,
                    state: _currentStep >= 3
                        ? StepState.complete
                        : StepState.disabled,
                  ),
                  new Step(
                    title: new Text('Submit'),
                    content: Container(),
                    isActive: _currentStep >= 0,
                    state: _currentStep >= 3
                        ? StepState.complete
                        : StepState.disabled,
                  ),
                ],
              ),
            ],
          ),
          _loading == true ? CircularProgressIndicator() : Container(),
        ],
      ),
    );
  }

  bool isComplete() {
    return !_controllerDescription.value.text.isNotEmpty &&
        !_controllerTitle.value.text.isNotEmpty;
  }

  tapped(int step) {
    setState(() => _currentStep = step);
  }

  continued() async {
    if (_currentStep >= 4) {
      setState(() {
        _loading = true;
      });
      FirebaseStorage storage = FirebaseStorage.instance;
      RestaurantService service = RestaurantService();
      UploadTask task = storage
          .ref("/restaurants" + _controllerTitle.value.text)
          .putFile(_image);
      task.snapshotEvents.listen((TaskSnapshot snapshot) async {
        if (snapshot.state == TaskState.success) {
          String url = await storage
              .ref("/restaurants" + _controllerTitle.value.text)
              .getDownloadURL();
          Uint8List bytes = await scanner.generateBarCode(url);
          Image img = Image.memory(bytes);
          await storage
              .ref("/qr" + _controllerTitle.value.text + "qr")
              .putData(bytes);
          String url_qr = await storage
              .ref("/qr" + _controllerTitle.value.text + "qr")
              .getDownloadURL();
          service.addRestaurant(Restaurant(
              image_url: url,
              title: _controllerTitle.value.text,
              description: _controllerDescription.value.text,
              point: GeoPoint(_pos.latitude, _pos.longitude),
              url_qr: url_qr));
          setState(() {
            _loading = false;
          });
          Navigator.of(_context).pop();
        }
      });
      await task;
    } else
      _currentStep <= 4 ? setState(() => _currentStep += 1) : null;
  }

  cancel() {
    _currentStep > 0 ? setState(() => _currentStep -= 1) : null;
  }

  Future getImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.camera);

    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
        _image_color = Colors.green;
      } else {
        print('No image selected.');
      }
    });
  }

  @override
  void dispose() {
    _controllerDescription.dispose();
    _controllerTitle.dispose();
  }

  /// Determine the current position of the device.
  ///
  /// When the location services are not enabled or permissions
  /// are denied the `Future` will return an error.
  Future<Position> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Location services are not enabled don't continue
      // accessing the position and request users of the
      // App to enable the location services.
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.deniedForever) {
        // Permissions are denied forever, handle appropriately.
        return Future.error(
            'Location permissions are permanently denied, we cannot request permissions.');
      }

      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }

    // When we reach here, permissions are granted and we can
    // continue accessing the position of the device.
    _pos = await Geolocator.getCurrentPosition();
    setState(() {
      if (_pos != null) {
        _hasLocation = true;
        _location_color = Colors.green;
      }
    });
    print(_pos.altitude);
  }
}
