import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:loading/indicator/ball_pulse_indicator.dart';
import 'package:loading/loading.dart';
import 'package:rowdy_hacks/landing/register_restaurant.dart';
import 'package:rowdy_hacks/login/AuthService.dart';
import 'package:rowdy_hacks/login/login.dart';
import 'package:rowdy_hacks/landing/home.dart';
import 'package:rowdy_hacks/login/signup.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {

  final navigatorKey = GlobalKey<NavigatorState>();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey:navigatorKey,
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => MyHomePage(),
        '/home': (context) => Home(),
        '/login': (context) => Login(),
        '/signup': (context)=>Signup(),
        '/addRestaurant':(context)=>RegisterRestaurant()
      },
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  bool _initialized = false;
  bool _error = false;

  // Define an async function to initialize FlutterFire
  void initializeFlutterFire() async {
    try {
      // Wait for Firebase to initialize and set `_initialized` state to true
      await Firebase.initializeApp();
      setState(() {
        print("ok");
        _initialized = true;
      });
    } catch (e) {
      // Set `_error` state to true if Firebase initialization fails
      setState(() {
        print("error");
        _error = true;
      });
    }
  }

  @override
  void initState() {
    initializeFlutterFire();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Widget loading = Scaffold(
      body: Container(
        color: Colors.lightBlue,
        child: Center(
          child: Loading(
              indicator: BallPulseIndicator(), size: 100.0, color: Colors.blue),
        ),
      ),
    );



    if (!_initialized) {
      return loading;
    }
    return Scaffold(
        body:AuthService().handleAuth()
    );
  }
}