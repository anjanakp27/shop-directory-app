import 'package:flutter/material.dart';

class CommonAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;

  CommonAppBar({required this.title});

  @override
  Widget build(BuildContext context) {
    return AppBar(
  centerTitle: true,
  // title: Text(title),
  // leading: IconButton( 
  //       icon: Image.asset(
  //         'assets/slogo2.jpg', // Replace with your image path
  //         width: 30, // Set the width as needed
  //         height: 30, // Set the height as needed
  //       ),
  //       onPressed: () {
  //         // Add your onPressed logic here
  //       },
  // ),
  title: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          IconButton(
            icon: Image.asset( 'assets/slogo2.jpg'), // Replace with the desired icon
            onPressed: () {
              // Add your onPressed logic here
            },
          ),
          SizedBox(width: 8.0), // Adjust the width as needed
          Text(
            title,
            style: TextStyle(fontSize: 18.0),
          ),
          SizedBox(width: 8.0), // Adjust the width as needed
         
          
          ],
  ),
    );


  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}
