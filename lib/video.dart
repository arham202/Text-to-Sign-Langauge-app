import 'dart:async';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class MyVideoApp extends StatefulWidget {
  static const routeName = '/video';
  const MyVideoApp({Key? key}) : super(key: key);

  @override
  _MyVideoAppState createState() => _MyVideoAppState();
}

class _MyVideoAppState extends State<MyVideoApp> {
  late String _sentence;
  List<String> _words = [];

  int _currentIndex = 0;
  bool _isTimerActive = false;
  Timer? _timer;
  late VideoPlayerController _controller;

  @override
  void initState() {
    super.initState();
    _sentence = '';
    _controller = VideoPlayerController.asset('');
  }

  @override
  void dispose() {
    _controller.dispose();
    _timer?.cancel();
    super.dispose();
  }

  void _onTextChanged(String text) {
    setState(() {
      text = text.toLowerCase();
      _sentence = text.trim();
    });
  }

  void _onButtonPressed() {

    setState(() {
      _words = _sentence.split(' ');
      _currentIndex = 0;
      _isTimerActive = true;
      _controller = VideoPlayerController.asset(
          'assets/videos/${_words[_currentIndex]}.mp4')
        ..initialize().then((_) {
          _controller.play();
          _timer = Timer.periodic(Duration(milliseconds: 2000 ), (timer) {
            setState(() {
              if (_currentIndex < _words.length - 1) {
                _currentIndex++;
                _controller = VideoPlayerController.asset(
                    'assets/videos/${_words[_currentIndex]}.mp4')
                  ..initialize().then((_) {
                    _controller.play();
                  });
              } else {
                _isTimerActive = false;
                _timer?.cancel();
              }
            });
          });
        });
    });
  }

  void _onStopPressed() {
    setState(() {
      _isTimerActive = false;
      _currentIndex = 0;
      _timer?.cancel();
      _controller.pause();
    });
  }

  void _onNavigateToAnotherPage() {
    Navigator.pushNamed(context, '/image');
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text(
            'Text to Video',
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
      ),),
              SizedBox(
                height: 10,
              ),
              Row(
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
              SizedBox(
                height: 80,
              ),
              Center(
                child: _currentIndex < _words.length
                    ? AspectRatio(
                  aspectRatio: 16/9,
                  child: VideoPlayer(_controller),
                )
                    : const Text('No more videos'),
              ),
            ],
          ),
        ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          _onNavigateToAnotherPage();
        },
        backgroundColor: Colors.black,
        label: const Text('Switch To Image'),
        icon: const Icon(Icons.video_collection),
      ),
      );
  }
}
