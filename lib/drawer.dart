import 'package:flutter/material.dart';
import 'package:shopdirectoryapp/about.dart';
import 'package:shopdirectoryapp/main.dart';
import 'package:shopdirectoryapp/searchcategory.dart';
import 'testapi.dart';
import 'request.dart';
import 'search.dart';
import 'searchcategory.dart';

class CommonDrawer extends StatelessWidget {
  const CommonDrawer({super.key});

  @override
  Widget build(BuildContext context) {
   return Drawer(
      child: ListView(
        children: <Widget>[
          // Image.asset('assets/sloho1.jpg'),
          DrawerHeader(
  decoration: BoxDecoration(
    color: Colors.blue,),
   child: Container(
      width: 100,
      height: 100,
      child: Image.asset('assets/slogo1.jpg'),
    ),
    // image: DecorationImage(
    //   image: AssetImage('assets/slogo1.jpg'),
    //   fit: BoxFit.fitHeight,
    // ),
  
  
  
),

          ListTile(
            leading: Icon(Icons.home),
            title: Text('Home'),
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => MainApp()));
            },
          ),
          ListTile(
            leading: Icon(Icons.search),
            title: Text('Search'),
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => SearchCategory(category: '')));
            },
          ),
          ListTile(
            leading: Icon(Icons.info),
            title: Text('About'),
            onTap: () {
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => AboutPage()));
            },
          ),
          ListTile(
            leading: Icon(Icons.request_page),
            title: Text('Request Form'),
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => RequestForm()));
            },
          ),
        ],
      ),
    );
  }
}