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



class AboutPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    
      return Scaffold(
      appBar: CommonAppBar(
        title:'About Us'),
          drawer: CommonDrawer(),
        body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/backgroundimage.jpg'), // Replace with your image path
            fit: BoxFit.cover,
          ),
        ),
      
    child:SingleChildScrollView(
   child:    Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'About our Shop Directory App',
              style: TextStyle(
                fontSize: 24.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 16.0),
            Text(
              'Welcome to our shop directory app! This app is designed to help you discover and explore various shops and other sections in your area.',
              style: TextStyle(fontSize: 16.0),
            ),
            SizedBox(height: 16.0),
            Text(
              'Features:',
              style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8.0),
            Text('- Search for shops based on categories.'),
            Text('- View detailed information about each shop.'),
            Text('- Easily navigate to your selected shops.'),
            SizedBox(height: 16.0),
            Text(
              'Connect with Us:',
              style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text('Have suggestions,feedback, or want to add your shop and various institutions to our directory?  We would love to hear from you! Reach out to us at'),
            
            SizedBox(height: 8.0),
            Text('Email: contact@example.com'),
            Text('Phone: 0456789090'),
          ],
        
        ),
       ),
        ),
        ), 
    );
  }
}
