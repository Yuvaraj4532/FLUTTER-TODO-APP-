//!  https://jsonplaceholder.typicode.com/users (API url)

import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

void main() => runApp(MaterialApp(home: MyApp()));

class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  List data = [];
  bool isLoading = true;

  Future<void> fetchdata() async {
    final res = await http.get(
      Uri.parse("https://jsonplaceholder.typicode.com/users"),
    );

    print("API Called");
    print(res.body);

    if (res.statusCode == 200) {
      setState(() {
        data = jsonDecode(res.body);
        isLoading = false;
      });
    } else {
      print("Error loading data");
      setState(() => isLoading = false);
    }
  }

  @override
  void initState() {
    super.initState();
    fetchdata();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Working API + ListView'),
        centerTitle: true,
        backgroundColor: Colors.teal,
        actions: [
          IconButton(
            onPressed: () {
              // print('Add button');
              setState(() {
                data += [
                  {
                    "id": data.length + 1,
                    "name": "Yuvaraj",
                    "email": "yuva123@gmail.com",
                    "phone": 6382307747,
                    "avatar": "Y",
                  },
                ];
              });
            },
            icon: Icon(Icons.add_outlined),
          ),
        ],
      ),

      body:
          // isLoading
          //     ? Center(child: CircularProgressIndicator())  // for loading circel symbol
          //     :
          ListView.builder(
            itemCount: data.length,
            itemBuilder: (context, index) {
              return ListTile(
                leading: CircleAvatar(child: Text(data[index]['name'][0])),
                title: Text(
                  data[index]['name'],
                  style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
                ),
                subtitle: Text(
                  data[index]['email'],
                  style: TextStyle(fontSize: 16, color: Colors.grey),
                ),
                trailing: IconButton(
                  onPressed: () {
                    // print('Delete Button');
                    setState(() {
                      data.removeWhere(
                        (item) => item["id"] == data[index]["id"],
                      );
                    });
                  },
                  icon: Icon(Icons.delete),
                ),
                // Text(
                //   data[index]['phone'].toString(),
                //   style: TextStyle(
                //     fontSize: 14,
                //     fontWeight: FontWeight.w600,
                //     color: Colors.blue,
                //   ),
                // ),
              );
            },
          ),
    );
  }
}
