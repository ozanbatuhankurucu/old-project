import 'package:flutter/material.dart';
import 'package:wordandmemory/screen/home_yedek.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();

    /// Initialize data, then navigator to Home screen.
    initData().then((value) {
      navigateToHomeScreen();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Center(
          child: Image.asset(
        "images/splash.png",
        width: 400,
        height: 400,
      )),
    );
  }

  Future initData() async {
    await Future.delayed(Duration(seconds: 3));
  }

  void navigateToHomeScreen() {
    /// Push home screen and replace (close/exit) splash screen.
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => HomePage()));
  }
}
