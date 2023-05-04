import 'package:flutter/material.dart';
import 'images.dart';
import 'video.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Text To Sign Language',
      theme: ThemeData(
        primaryColor: Colors.white,
        accentColor: Colors.black,
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            primary: Colors.white,
            onPrimary: Colors.black,
            side: BorderSide(
              color: Colors.black,
              width: 2.0,
            ),
            elevation: 5,
            shadowColor: Colors.black,
          ),
        ),
      ),
      home: HomePage(),
      routes: {
        MyImageApp.routeName: (context) => MyImageApp(),
        MyVideoApp.routeName: (context) => MyVideoApp(),
      },
    );
  }
}

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: WillPopScope(
        onWillPop: () async {
          Navigator.of(context).popUntil((route) => route.isFirst);
          return true;
        },
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Column(
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 13),
                  child: Text('Text To Sign Language',style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 36,
                  ),),
                ),
                Padding(
                  padding: EdgeInsets.all(15.0),
                  child: Text('Empower communication for all with the power of sign language video translation.',style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                    color: Colors.grey,
                  ),),
                ),
                SizedBox(
                  height: 20,
                ),
                Image.asset('assets/images/Hand.png',width: 250,)
              ],
            ),
            Center(
            child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                width: 200,
                height: 80,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                  primary: Colors.white,
                  onPrimary: Colors.black,
                  side: BorderSide(
                    color: Colors.black,
                    width: 4.0,
                  ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  elevation: 10,
                  shadowColor: Colors.black,
                  ),
                onPressed: () {
                    Navigator.pushNamed(context, MyImageApp.routeName);
                  },
                  child: Text('Finger Spell',style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 28,
                  ),),
                ),
              ),
              SizedBox(height: 40),
              SizedBox(
                width: 200,
                height: 80,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: Colors.white,
                    onPrimary: Colors.black,
                    side: BorderSide(
                      color: Colors.black,
                      width: 4.0,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    elevation: 10,
                    shadowColor: Colors.black,
                  ),
                  onPressed: () {
                    Navigator.pushNamed(context, MyVideoApp.routeName);
                  },
                  child: const Text('Video',style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 28,
                  ),),
                ),
              ),
            ],
      ),
      ),
          ],
        ),
    ),
    );
  }
}
