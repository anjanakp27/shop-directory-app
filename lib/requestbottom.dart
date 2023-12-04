import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'drawer.dart';
import 'appbar.dart';


class RequestBottom extends StatefulWidget {
  const RequestBottom({Key? key}) : super(key: key);

  @override
  State<RequestBottom> createState() => RequestBottomState();
}

class RequestBottomState extends State<RequestBottom> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController shopnameController = TextEditingController();
  String? selectedCategory;
  List<String> categoryList = [];
  final TextEditingController phonenumberController = TextEditingController();
  String? shopNameError;
  String? categoryError;
  String? phoneNumberError;
  
   
  Future<void> _fetchCategories() async {
    final response =
        await http.get(Uri.parse('http://localhost:8000/api/fetchcategory'));

    if (response.statusCode == 200) {
      final dynamic responseData = jsonDecode(response.body);
      if (responseData['status'] == 'success') {
        final List<dynamic> categoryData = responseData['data'];
        categoryList =
            categoryData.map((data) => data['categoryname'].toString()).toList();
        setState(() {});
      } else {
        if (kDebugMode) {
          print('API response status is not success');
        }
      }
    } else {
      if (kDebugMode) {
        print('Failed to fetch categories');
      }
    }
  }

  @override
  void initState() {
    super.initState();
    _fetchCategories();
  }

  Future<void> _createUser() async {
    setState(() {
      shopNameError = null;
      categoryError = null;
      phoneNumberError = null;
    });

    if (_formKey.currentState!.validate()) {
      final response = await http.post(
        Uri.parse('http://localhost:8000/api/addrequest'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'shopname': shopnameController.text,
          'category': selectedCategory,
          'phonenumber': phonenumberController.text,
        }),
      );

      if (response.statusCode == 201) {
        if (kDebugMode) {
          print('Request created successfully');
        }
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('Success'),
              content: Text('Request created successfully'),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop(); // Close the alert box
                    // Navigator.pop(context); 
                    // Navigate back to the previous screen
                    shopnameController.clear();
                    setState(() {
                    selectedCategory = null; // Clear the selected category
                  });
                    phonenumberController.clear();
                  },
                  child: Text('OK'),
                ),
              ],
            );
          },
        );
      } else {
        if (kDebugMode) {
          print(response.body);
        }

        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('Error'),
              content: Text('Failed to create request. Please try again.'),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop(); // Close the alert box
                  },
                  child: Text('OK'),
                ),
              ],
            );
          },
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    // return BackgroundImage(child:
  return  Scaffold(
        appBar: null, // Dynamic title
      drawer: null,
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/backgroundimage.jpg'), // Replace with your image path
            fit: BoxFit.cover,
          ),
        ),
     child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: shopnameController,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter shop name';
                  }
                  return null;
                },
                decoration: const InputDecoration(
                  labelText: 'Shop Name',
                ),
              ),
              if (shopNameError != null)
                Text(
                  shopNameError!,
                  style: TextStyle(color: Colors.red),
                ),
              const SizedBox(height: 16.0),
              DropdownButtonFormField<String>(
                value: selectedCategory,
                onChanged: (value) {
                  setState(() {
                    selectedCategory = value;
                  });
                },
                items: categoryList.map((category) {
                  return DropdownMenuItem<String>(
                    value: category,
                    child: Text(category),
                  );
                }).toList(),
                decoration: const InputDecoration(
                  labelText: 'Category',

                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please select a category';
                  }
                  return null;
                },
              ),
              if (categoryError != null)
                Text(
                  categoryError!,
                  style: TextStyle(color: Colors.red),
                ),
              const SizedBox(height: 16.0),
              TextFormField(
                controller: phonenumberController,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter phone number';
                  }
                  return null;
                },
                decoration: const InputDecoration(
                  labelText: 'Phone Number',
                ),
              ),
              if (phoneNumberError != null)
                Text(
                  phoneNumberError!,
                  style: TextStyle(color: Colors.red),
                ),
              const SizedBox(height: 16.0),
              ElevatedButton(
                onPressed: () {
                  _createUser();
                },
                child: const Text('Submit'),
              ),
            ],
          ),
        ),
      ),
      ),
    
    );
  }
}
