
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'drawer.dart';
import 'package:shopdirectoryapp/main.dart';
import 'package:url_launcher/url_launcher.dart';
import 'appbar.dart';

class GetCategory extends StatefulWidget {
  final String category;

  GetCategory({required this.category});

  @override
  _GetCategoryState createState() => _GetCategoryState();
}

class _GetCategoryState extends State<GetCategory> {
  final TextEditingController categoryController = TextEditingController();
  List<Map<String, dynamic>> shopDetails = [];
   

  Future<void> _fetchShopDetails(String category) async {
    try {
  
      final response = await http.get(
          Uri.parse('http://localhost:8000/api/shops/category/$category'));

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = json.decode(response.body);
        List<Map<String, dynamic>> sortedShopDetails =
          List<Map<String, dynamic>>.from(data['data'] ?? []);

      // Sort shop details alphabetically based on shop name
      sortedShopDetails.sort((a, b) =>
          a['shopname'].toString().compareTo(b['shopname'].toString()));

      setState(() {
        shopDetails = sortedShopDetails;
      });

        
      } else {
        // Handle API request errors here, e.g., show an error message
        setState(() {
          shopDetails = [];
        });
      }
    } catch (error) {
      // Handle other errors like network issues
      print("Error: $error");
    }
  }
  
 _launchDialer(dynamic phoneNumber) async {
  final url = 'tel:${phoneNumber.toString()}';
  if (await canLaunch(url)) {
    await launch(url);
  } else {
    // Handle error
    print('Could not launch $url');
  }
}

  @override
  void initState() {
    super.initState();
    _fetchShopDetails(widget.category);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
     appBar: CommonAppBar(
        title:'Get Shop Details'),
      
      drawer: CommonDrawer(),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/backgroundimage.jpg'), // Replace with your image path
            fit: BoxFit.cover,
          ),
        ),
      child: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: ListTile(
                  title: Text(
                    'Category : ${widget.category}',
                    style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              SizedBox(height: 16.0),
              if (shopDetails.isNotEmpty)
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: shopDetails.map((shopData) {
                    return Card(
                      elevation: 5.0,
                      color: Colors.cyan[50],
                      margin: EdgeInsets.all(10.0),
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                             Padding(
                               padding: const EdgeInsets.all(9.0),
                               child: Row(
                                  children: [
                                    Icon(Icons.shop), // Add shop icon
                                    SizedBox(width: 8.0),
                                    Text('Shop Name : ${shopData['shopname']}'),
                                  ],
                                ),
                             ),
                               InkWell(
                                onTap: () {
                                  _launchDialer(shopData['phonenumber']);
                                },
                                child: Padding(
                                  padding: const EdgeInsets.all(9.0),
                                  child: Row(
                                    children: [
                                      Icon(Icons.phone),
                                      SizedBox(width: 8.0),
                                      Text('Phone Number : ${shopData['phonenumber']}'),
                                                           
                                                          ],
                                                        ),
                                ),
                      ),
                          ],
                        ),
                      ),
                    );
                  }).toList(),
                ),
              if (shopDetails.isEmpty)
                Text('No data found'),
                 
            ],
          ),
        ),
      ),
      ),
    );
  }
}

