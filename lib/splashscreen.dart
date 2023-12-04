import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(
      Duration(seconds: 2),  // adjust the duration as needed
      () => Navigator.pushReplacementNamed(context, '/main'),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        
        child: Image.asset('assets/slogo1.jpg'),  // replace with the actual image path
      ),
      
    );
  }
}
