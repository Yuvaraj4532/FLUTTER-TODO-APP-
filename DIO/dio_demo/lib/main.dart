//! "https://6931047e11a8738467ccebfa.mockapi.io/api/Data/data1"

import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'student_model.dart';

void main() => runApp(MaterialApp(home: MyApp()));

class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final Dio dio = Dio(
    BaseOptions(
      baseUrl: "https://6931047e11a8738467ccebfa.mockapi.io/api/Data/data1",
      headers: {'Content-Type': 'application/json'},
    ),
  );

  List<Student> posts = [];
  bool isLoading = true;

  TextEditingController nameController = TextEditingController();
  TextEditingController rollnoController = TextEditingController();
  TextEditingController classController = TextEditingController();
  TextEditingController yearController = TextEditingController();

  //GET ALL ITEMS
  Future<void> fetchData() async {
    try {
      final res = await dio.get("/");
      setState(() {
        posts = (res.data as List)
            .map((json) => Student.fromJson(json))
            .toList();
        isLoading = false;
      });
    } catch (e) {
      isLoading = false;
      print("GET error: $e");
    }
  }

  //POST
  Future<void> postData() async {
    Student student = Student(
      id: '',
      name: nameController.text,
      rollno: rollnoController.text,
      className: classController.text,
      year: yearController.text,
    );

    try {
      await dio.post('/', data: student.toJson());

      fetchData(); // to refresh list
      clearControllers();

      Navigator.pop(context);
    } catch (e) {
      print("POST error: $e");
    }
  }

  //PUT
  Future<void> updateData(String id) async {
    Student student = Student(
      id: id,
      name: nameController.text,
      rollno: rollnoController.text,
      className: classController.text,
      year: yearController.text,
    );

    try {
      await dio.put("/$id", data: student.toJson());
      fetchData();
      clearControllers();
      Navigator.pop(context);
    } catch (e) {
      print("PUT error: $e");
    }
  }

  //DELETE
  Future<void> deleteData(String id) async {
    try {
      await dio.delete("/$id");
      fetchData();
    } catch (e) {
      print(' DELETE error: $e');
    }
  }

  //EDIT
  void showEditDialogue(Student item) {
    nameController.text = item.name;
    rollnoController.text = item.rollno;
    classController.text = item.className;
    yearController.text = item.year;

    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text('Edit Student'),
        content: SingleChildScrollView(
          child: Column(
            children: [
              TextField(
                controller: nameController,
                decoration: InputDecoration(labelText: "NAme"),
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
            onPressed: () {
              Navigator.pop(context);
              clearControllers();
            },
            child: Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              updateData(item.id);
            },
            child: Text('Update'),
          ),
        ],
      ),
    );
  }

  void clearControllers() {
    nameController.clear();
    rollnoController.clear();
    classController.clear();
    yearController.clear();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchData();
  }

  @override
  void dispose() {
    nameController.dispose();
    rollnoController.dispose();
    classController.dispose();
    yearController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('DIO_API'),
        centerTitle: true,
        backgroundColor: Colors.teal,
      ),

      //ADD BUTTON
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.greenAccent,
        child: Icon(Icons.add),
        onPressed: () {
          clearControllers();
          showDialog(
            context: context,
            builder: (context) => AlertDialog(
              title: Text('Add Student'),
              content: SingleChildScrollView(
                child: Column(
                  children: [
                    TextField(
                      controller: nameController,
                      decoration: InputDecoration(labelText: 'Name'),
                    ),
                    TextField(
                      controller: rollnoController,
                      decoration: InputDecoration(labelText: 'Roll No'),
                    ),
                    TextField(
                      controller: classController,
                      decoration: InputDecoration(labelText: 'Class'),
                    ),
                    TextField(
                      controller: yearController,
                      decoration: InputDecoration(labelText: 'Year'),
                    ),
                  ],
                ),
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: Text('Cancel'),
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.teal),
                  onPressed: postData,
                  child: Text('Save'),
                ),
              ],
            ),
          );
        },
      ),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : posts.isEmpty
          ? Center(child: Text('No Data Found'))
          : ListView.builder(
              itemCount: posts.length,
              itemBuilder: (_, index) {
                final item = posts[index];
                return Card(
                  child: ListTile(
                    title: Text(item.name),
                    subtitle: Column(
                      //mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Roll No: ${item.rollno}"),
                        Text("Class: ${item.className}"),
                        Text("Year: ${item.year}"),
                      ],
                    ),

                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          onPressed: () => showEditDialogue(item),
                          icon: Icon(Icons.edit),
                        ),
                        IconButton(
                          onPressed: () {
                            // Navigator.pop(context);
                            deleteData(item.id);
                          },
                          icon: Icon(Icons.delete),
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
