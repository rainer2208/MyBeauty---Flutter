import 'dart:async';
import 'package:flutter/material.dart';
import 'package:my_beauty/registerform.dart';
import 'package:flutter/cupertino.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'My Beauty',
      theme: ThemeData(
        primaryColor: Colors.black,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(),
    );
  }
}

// Transition builder
Route _createRoute() {
  return PageRouteBuilder(
    transitionDuration: Duration(seconds: 1),
    pageBuilder: (context, animation, secondaryAnimation) => RegisterForm(),
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      var begin = Offset(0.0, 1.0);
      var end = Offset.zero;
      var curve = Curves.bounceInOut;

      var tween = Tween(begin: begin, end: end);
      var curvedAnimation = CurvedAnimation(
        parent: animation,
        curve: curve,
      );

      return SlideTransition(
        position: tween.animate(curvedAnimation),
        child: child,
      );
    },
  );
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

// Initializer
class _MyHomePageState extends State<MyHomePage> {
  TextButton _textButtonEntrar;
  _MyHomePageState() {
    _textButtonEntrar = TextButton(
        child: Text('ENTRAR', style: TextStyle(color: Colors.white)),
        onPressed: () {
          Navigator.of(context).push(_createRoute());
        });
  }
  // Widgets
  final _imageDove = Image.asset(
    'images/dove.png',
    width: 200,
    height: 180,
    fit: BoxFit.cover,
  );

  final _textMyBeauty = Text(' My Beauty',
      style: TextStyle(
          fontFamily: 'LovelyCoffee', fontSize: 65, color: Colors.white));

  @override
  Widget build(BuildContext context) {
    //Firebase.initializeApp();
    Timer(Duration(seconds: 5), () {
      // Go to next route
      Navigator.of(context).push(_createRoute());
    });
    // Layout
    return Scaffold(
      appBar: AppBar(),
      backgroundColor: Colors.black,
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              _imageDove,
              Container(
                child: _textMyBeauty,
              ),
              Container(
                decoration: BoxDecoration(
                  color: Color.fromARGB(60, 0, 141, 193),
                ),
                child: _textButtonEntrar,
                margin: EdgeInsets.all(15),
                padding: EdgeInsets.fromLTRB(
                    12, 0, 12, 1), //left, top, right, bottom
              ),
            ],
          ),
        ),
      ),
      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
