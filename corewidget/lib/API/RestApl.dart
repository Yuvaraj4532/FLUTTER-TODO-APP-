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
      ),

      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: data.length,
              itemBuilder: (context, index) {
                return ListTile(
                  leading: CircleAvatar(child: Text(data[index]['name'][0])),
                  title: Text(
                    data[index]['name'],
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  subtitle: Text(
                    data[index]['email'],
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey,
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                  trailing: Text(
                    data[index]['phone'],
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: Colors.blue,
                    ),
                  ),
                );
              },
            ),
    );
  }
}

// https://reqres.in/api/users?page=2

// import 'package:flutter/material.dart';
// import 'dart:convert';
// import 'package:http/http.dart' as http;

// void main() => runApp(MaterialApp(home: MyApp()));

// class MyApp extends StatefulWidget {
//   @override
//   State<MyApp> createState() => _MyAppState();
// }

// class _MyAppState extends State<MyApp> {
//   List data = [];
//   bool isLoading = true;

//   Future<void> fetchdata() async {
//     final res = await http.get(
//       Uri.parse("https://jsonplaceholder.typicode.com/users"),
//     );

//     print("API Method");
//     print(res.body.toString());

//     if (res.statusCode == 200) {
//       setState(() {
//         data = jsonDecode(res.body)['data'];
//         isLoading = false;
//       });
//     } else {
//       print("Error loading data");
//       setState(() => isLoading = false);
//     }
//   }

//   @override
//   void initState() {
//     super.initState();
//     fetchdata();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Rest API + ListView'),
//         centerTitle: true,
//         backgroundColor: Colors.teal,
//       ),

//       body: isLoading
//           ? Center(child: CircularProgressIndicator())
//           : ListView.builder(
//               itemCount: data.length,
//               itemBuilder: (context, index) {
//                 return ListTile(
//                   leading: CircleAvatar(
//                     backgroundImage: NetworkImage(data[index]['avatar']),
//                   ),
//                   title: Text(
//                     "${data[index]['first_name']} ${data[index]['last_name']}",
//                   ),
//                   subtitle: Text(data[index]['email']),
//                 );
//               },
//             ),
//     );
//   }
// }
