//! mockApi---> https://6931047e11a8738467ccebfa.mockapi.io/api/Data/data1

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:io';

void main() => runApp(MaterialApp(home: MyApp()));

class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  List data = [];
  bool isLoading = true;

  //GetData
  Future<void> fetchdata() async {
    try {
      final res = await http.get(
        Uri.parse("https://6931047e11a8738467ccebfa.mockapi.io/api/Data/data1"),
      );
      //print(res.body.toString());

      if (res.statusCode == 200) {
        setState(() {
          data = jsonDecode(res.body);
          print(data.toString());
          isLoading = false;
        });
      } else {
        print("Error loading data:${res.statusCode}");
      }
    } catch (e) {
      print("Exception: $e");
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchdata();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Rest API with Http'),
        centerTitle: true,
        actions: [
          IconButton(onPressed: () {}, icon: Icon(Icons.add_circle_outline)),
        ],

        backgroundColor: Colors.teal,
      ),
      body:
          //  isLoading
          //     ? Center(child: CircularProgressIndicator())
          //     :
          ListView.builder(
            itemCount: data.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.all(10.0),
                child: Container(
                  height: 150,
                  width: double.infinity,
                  color: Colors.grey,
                  child: Row(
                    children: [
                      Column(
                        children: [
                          Container(
                            height: 150,
                            width: 150,

                            decoration: BoxDecoration(
                              color: Colors.black,
                              image: DecorationImage(
                                image: NetworkImage(data[index]['logo']),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        ],
                      ),
                      Container(
                        child: Expanded(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                data[index]['name'],
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                data[index]['email'],
                                style: TextStyle(fontSize: 16),
                              ),
                              Text(
                                data[index]['phone'],
                                style: TextStyle(fontSize: 15),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
    );
  }
}
