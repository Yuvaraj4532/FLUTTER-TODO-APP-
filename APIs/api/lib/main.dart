//!   RestApi.dev
//!   mockapi.com ===> https://6931047e11a8738467ccebfa.mockapi.io/api/Data/data1

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  List allData = [];
  bool isLoading = false;
  String? lastInsertedId;

  // Controllers for Edit Dialog
  final TextEditingController nameController = TextEditingController();
  final TextEditingController rollnoController = TextEditingController();
  final TextEditingController classController = TextEditingController();
  final TextEditingController yearController = TextEditingController();

  //! 1. GET DATA

  Future<void> getData() async {
    setState(() {
      isLoading = true;
    });

    final res = await http.get(
      Uri.parse("https://6931047e11a8738467ccebfa.mockapi.io/api/Data/data1"),
    );

    if (res.statusCode == 200) {
      setState(() {
        allData = jsonDecode(res.body);
      });
    }

    setState(() {
      isLoading = false;
    });
  }

  //! 2. POST DATA

  Future<void> insertData() async {
    final body = {
      "name": "Yuva",
      "rollno": "12345",
      "class": "IT",
      "year": "3rd",
    };

    final res = await http.post(
      Uri.parse("https://6931047e11a8738467ccebfa.mockapi.io/api/Data/data1"),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode(body),
    );

    if (res.statusCode == 200 || res.statusCode == 201) {
      final newItem = jsonDecode(res.body);
      lastInsertedId = newItem["id"];
      print("POST SUCCESS: $newItem");
      await getData();
    }
  }

  //! 3. PUT DATA (Update)

  Future<void> updateData(String id, {Map<String, dynamic>? body}) async {
    final res = await http.put(
      Uri.parse(
        "https://6931047e11a8738467ccebfa.mockapi.io/api/Data/data1/$id",
      ),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode(body),
    );

    if (res.statusCode == 200 || res.statusCode == 201) {
      print("UPDATE SUCCESS: ${jsonDecode(res.body)}");
      await getData();
    }
  }

  //! 4. DELETE DATA

  Future<void> deleteData(String id) async {
    final res = await http.delete(
      Uri.parse(
        "https://6931047e11a8738467ccebfa.mockapi.io/api/Data/data1/$id",
      ),
    );

    if (res.statusCode == 200) {
      setState(() {
        allData.removeWhere((item) => item["id"] == id);
      });
      await getData();
      print("DELETE SUCCESS: ID $id deleted");
    }
  }

  //! EDIT POPUP

  Future<void> showEditDialog(Map item) async {
    nameController.text = item["name"] ?? "";
    rollnoController.text = item["rollno"] ?? "";
    classController.text = item["class"] ?? "";
    yearController.text = item["year"] ?? "";

    await showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("Edit Item (ID: ${item["id"]})"),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: nameController,
                  decoration: InputDecoration(labelText: "Name"),
                ),
                TextField(
                  controller: rollnoController,
                  decoration: InputDecoration(labelText: "Roll No"),
                ),
                TextField(
                  controller: classController,
                  decoration: InputDecoration(labelText: "Class"),
                ),
                TextField(
                  controller: yearController,
                  decoration: InputDecoration(labelText: "Year"),
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              child: Text("Cancel"),
              onPressed: () => Navigator.pop(context),
            ),
            ElevatedButton(
              child: Text("Update"),
              onPressed: () async {
                Map<String, dynamic> updatedBody = {
                  "name": nameController.text,
                  "rollno": rollnoController.text,
                  "class": classController.text,
                  "year": yearController.text,
                };

                await updateData(item["id"], body: updatedBody);
                Navigator.pop(context);
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text("REST API (GET - POST - PUT - DELETE)"),
          backgroundColor: Colors.teal,
          centerTitle: true,
        ),
        body: Column(
          children: [
            // BUTTON
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.brown,
                    foregroundColor: Colors.white,
                  ),
                  onPressed: getData,
                  child: Text('GET DATA'),
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.brown,
                    foregroundColor: Colors.white,
                  ),
                  onPressed: insertData,
                  child: Text('POST DATA'),
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.brown,
                    foregroundColor: Colors.white,
                  ),
                  onPressed: () {
                    if (lastInsertedId != null) {
                      Map<String, dynamic> defaultBody = {
                        "name": "Updated ==name==",
                        "rollno": "99999",
                        "class": "IT",
                        "year": "Final",
                      };
                      updateData(lastInsertedId!, body: defaultBody);
                    } else {
                      print("No item to update. Insert first.");
                    }
                  },
                  child: Text('PUT DATA'),
                ),
              ],
            ),

            SizedBox(height: 20),

            if (isLoading) CircularProgressIndicator(),

            // LIST VIEW
            Expanded(
              child: ListView.builder(
                itemCount: allData.length,
                itemBuilder: (context, index) {
                  final item = allData[index];

                  return Card(
                    color: Color.fromARGB(255, 250, 239, 136),
                    child: ListTile(
                      title: Text(item["name"]),
                      subtitle: Text(
                        "ID: ${item["id"]}\n"
                        "ROLL NO: ${item["rollno"]}\n"
                        "CLASS: ${item["class"]}\n"
                        "YEAR: ${item["year"]}",
                      ),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                            iconSize: 25,
                            icon: Icon(Icons.edit, color: Colors.blue),
                            onPressed: () {
                              showEditDialog(item);
                            },
                          ),
                          IconButton(
                            iconSize: 30,
                            icon: Icon(Icons.delete, color: Colors.red),
                            onPressed: () {
                              deleteData(item["id"]);
                            },
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
