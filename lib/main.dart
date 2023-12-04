import 'package:flutter/material.dart';
import 'package:shopdirectoryapp/about.dart';
import 'package:shopdirectoryapp/searchcategory.dart';
import 'testapi.dart';
import 'request.dart';
import 'search.dart';
import 'searchcategory.dart';
import 'drawer.dart';
import 'appbar.dart';
import 'requestbottom.dart';
import 'splashscreen.dart';
import 'dart:ui';


// void main() {
//   runApp(MaterialApp(
//     home: MainApp(),
//   ));
// }

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  
    // Add more pages as needed
  

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: '/',
      routes: {
        '/': (context) => SplashScreen(),
        '/main': (context) => MainApp(),// replace 'MainScreen' with your main application screen
      },
    );
  }
}



class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  var valueToPass;
  final List<Widget> _pages = [
    
    HomePage(),
    RequestBottom(),
    
  ];
  int _currentIndex = 0;

  // Add a PageController
  final PageController _pageController = PageController();

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: CommonAppBar(title: 'Shop Directory '),
       
      drawer: CommonDrawer(),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        backgroundColor: Colors.blueAccent,
        items: [
          BottomNavigationBarItem(
            label: "Home",
            icon: Icon(Icons.home, color: Colors.white,),
          ),
          BottomNavigationBarItem(
            label: "Add Your Shop",
            icon: Icon(Icons.account_circle, color: Colors.white,),
          ),
        ],
        selectedItemColor: Colors.white,
        onTap: (index) {
          // Use the PageController to navigate to the selected page
          _pageController.jumpToPage(index);
        },
      ),
      body: PageView(
        controller: _pageController,
        children: _pages,
        onPageChanged: (index) {
          // Update the current index when the page changes
          setState(() {
            _currentIndex = index;
          });
        },
      ),
    
     
    );
  }
}

