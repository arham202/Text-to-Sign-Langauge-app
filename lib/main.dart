import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'images.dart';
import 'video.dart';
import 'package:flutter_svg/flutter_svg.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Text To Sign Language',
      home: HomePage(),
      routes: {
        MyImageApp.routeName: (context) => const MyImageApp(),
        MyVideoApp.routeName: (context) => const MyVideoApp(),
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
                  child: Text('Text To Sign Language',style: GoogleFonts.ptSans(
                    fontWeight: FontWeight.bold,
                    fontSize: 36,
                    color: Colors.black,
                  ),),
                ),
                Padding(
                  padding: EdgeInsets.all(25.0),
                  child: Text('Empower communication for all with the power of sign language video translation.',style: GoogleFonts.ptSans(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                    color: Colors.grey,
                  ),),
                ),
                const SizedBox(
                  height: 35,
                ),
                SvgPicture.asset('assets/images/Page1.svg',width: 350.0)
              ],
            ),
            Center(
            child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                width: 325,
                height: 70,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.black,
                  side: const BorderSide(
                    color: Colors.black,
                    width: 4.0,
                  ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(100),
                    ),
                  elevation: 10,
                  shadowColor: Colors.black,
                  ),
                onPressed: () {
                    Navigator.pushNamed(context, MyImageApp.routeName);
                  },
                  child: Text('Finger Spell',style: GoogleFonts.ptSans(
                    fontWeight: FontWeight.bold,
                    fontSize: 28,
                  ),),
                ),
              ),
              const SizedBox(height: 30),
              SizedBox(
                width: 325,
                height: 70,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: Colors.white,
                    onPrimary: Colors.black,
                    side: const BorderSide(
                      color: Colors.black,
                      width: 4.0,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(100),
                    ),
                    elevation: 10,
                    shadowColor: Colors.black,
                  ),
                  onPressed: () {
                    Navigator.pushNamed(context, MyVideoApp.routeName);
                  },
                  child:Text('Video',style: GoogleFonts.ptSans(
                    fontWeight: FontWeight.bold,
                    fontSize: 30,
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
