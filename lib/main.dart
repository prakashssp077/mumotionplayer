import 'package:flutter/material.dart';
import 'package:mumotionplayer/screens/login_screen.dart';
import 'package:mumotionplayer/screens/test_song.dart';
import 'package:mumotionplayer/testingFiles/splashNextScreen.dart';
import 'package:mumotionplayer/screens/splash_screen.dart';
void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: SplashScreen(),
      routes: <String,WidgetBuilder>{
        '/splashScreenNextScreen':(BuildContext context) => new SplashNextScreen(),
        '/loginScreen':(BuildContext context) =>new LoginScreen(),
        '/testSong':(BuildContext context) =>TestSong(),
      },
    );
  }
}
