import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:qrscan/qrscan.dart' as scanner;

class RegisterRestaurant extends StatefulWidget {
  RegisterRestaurant({Key key}) : super(key: key);

  @override
  _RegisterRestaurantState createState() => _RegisterRestaurantState();
}

class _RegisterRestaurantState extends State<RegisterRestaurant> {
  @override
  Widget build(BuildContext context) {
    int _currentStep = 0;
    return Scaffold(
      appBar: AppBar(
        title: Text("Add a place information"),
      ),
      body: ListView(
        children: <Widget>[
          Container(
            child: Text(
              "We just need to know you",
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontFamily: 'Montserrat',
                  fontSize: 16,
                  fontStyle: FontStyle.italic),
            ),
          ),
          Stepper(
            type: StepperType.vertical,
            currentStep: _currentStep,
            onStepTapped: (int step) => setState(() => _currentStep = step),
            onStepContinue:
                _currentStep < 4 ? () => setState(() => _currentStep += 1) : null,
            onStepCancel:
                _currentStep > 0 ? () => setState(() => _currentStep -= 1) : null,
            steps: <Step>[
              new Step(
                title: new Text('Title'),
                content: TextField(
                  decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: 'Enter a search term'
                  ),
                ),
                isActive: _currentStep >= 0,
                state:
                    _currentStep >= 0 ? StepState.complete : StepState.disabled,
              ),
              new Step(
                title: new Text('Quick Description'),
                content:TextField(
                  decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: 'Enter a search term'
                  ),
                ),
                isActive: _currentStep >= 0,
                state:
                    _currentStep >= 1 ? StepState.complete : StepState.disabled,
              ),
              new Step(
                title: new Text('Pick Location'),
                content: new Text('This is the third step.'),
                isActive: _currentStep >= 0,
                state:
                    _currentStep >= 2 ? StepState.complete : StepState.disabled,
              ),
              new Step(
                title: new Text('Imagenes'),
                content: new Text('This is the third step.'),
                isActive: _currentStep >= 0,
                state:
                    _currentStep >= 3 ? StepState.complete : StepState.disabled,
              ),
            ],
          ),
        ],
      ),
    );
  }

  bool_generateinfo() async {
    Uint8List result = await scanner
        .generateBarCode('https://github.com/leyan95/qrcode_scanner');
    Image.file(File.fromRawPath(result));
    return true;
  }
}
