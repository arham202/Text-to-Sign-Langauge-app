import 'dart:async';

import 'package:flutter/material.dart';

class MyImageApp extends StatefulWidget {
  static const routeName = '/image';
  const MyImageApp({Key? key}) : super(key: key);

  @override
  _MyImageAppState createState() => _MyImageAppState();
}

class _MyImageAppState extends State<MyImageApp> {
  late String _sentence;
  List<String> _words = [];

  int _currentIndex = 0;
  bool _isTimerActive = false;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _sentence = '';
  }

  void _onTextChanged(String text) {
    setState(() {
      text = text.toLowerCase();
      _sentence = text.trim();
    });
  }

  void _onButtonPressed() {
    setState(() {
      _words = _sentence.split('');
      _currentIndex = 0;
      _isTimerActive = true;
      _timer = Timer.periodic(const Duration(milliseconds: 1500), (timer) {
        setState(() {
          if (_currentIndex < _words.length - 1) {
            _currentIndex++;
          } else {
            _isTimerActive = false;
            _timer?.cancel();
          }
        });
      });
    });
  }

  void _onStopPressed() {
    setState(() {
      _isTimerActive = false;
      _currentIndex = 0;
      _timer?.cancel();
    });
  }

  void _onNavigateToAnotherPage() {
    Navigator.pushNamed(context, '/video');
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return
      Scaffold(
        appBar: AppBar(
          title: const Text(
            'Text to Images',
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
            ),
          ),
          backgroundColor: Colors.white,
          iconTheme: IconThemeData(color: Colors.black),
          elevation: 0,
        ),
        body: WillPopScope(
          onWillPop: () async {
            Navigator.of(context).popUntil((route) => route.isFirst);
            return true;
          },
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  decoration: InputDecoration(
                    hintText: 'Enter a sentence',
                    border: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.black,
                        width: 4.0,
                      ),
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                    contentPadding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 20.0),
                  ),
                  onChanged: _onTextChanged,
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                margin: const EdgeInsets.symmetric(vertical: 10.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        FocusScopeNode currentFocus = FocusScope.of(context);
                        if (!currentFocus.hasPrimaryFocus) {
                          currentFocus.unfocus();
                        }
                        _onButtonPressed();
                      },
                      child: const Text('Show Images'),
                    ),
                    const SizedBox(width: 16.0),
                    ElevatedButton(
                      onPressed: _isTimerActive ? _onStopPressed : null,
                      child: const Text('Stop'),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 80,
              ),
              Center(
                child: _currentIndex < _words.length
                    ? _words[_currentIndex] == ' '
                    ? const Text(' ')
                    : Image.asset(
                  'assets/images/${_words[_currentIndex]}.jpg',
                  height: 300.0,
                  errorBuilder: (BuildContext context, Object exception,
                      StackTrace? stackTrace) {
                    return const Text('No images found');
                  },
                )
                    : const Text('No more images'),
              ),
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton.extended(
          onPressed: () {
            _onNavigateToAnotherPage();
          },
          backgroundColor: Colors.black,
          label: const Text('Switch To Video'),
          icon: const Icon(Icons.video_collection),
        ),
      );
  }
}
