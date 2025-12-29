import 'package:flutter/material.dart';

void main() => runApp(MaterialApp(home: ToDoApp()));

class ToDoApp extends StatefulWidget {
  @override
  State<ToDoApp> createState() => _ToDoAppState();
}

class _ToDoAppState extends State<ToDoApp> {
  void _showEditDialog(int index) {
    TextEditingController editTitle = TextEditingController(
      text: contents[index].title,
    );
    TextEditingController editDescription = TextEditingController(
      text: contents[index].description,
    );

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Edit Task'),
          content: SizedBox(
            height: 300,
            width: 250,
            child: Column(
              children: [
                TextField(
                  controller: editTitle,
                  decoration: InputDecoration(labelText: 'Title'),
                ),
                TextField(
                  controller: editDescription,
                  decoration: InputDecoration(labelText: 'Description'),
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('Cancel'),
            ),

            TextButton(
              onPressed: () {
                setState(() {
                  contents[index].title = editTitle.text;
                  contents[index].description = editDescription.text;
                });
                Navigator.pop(context);
              },
              child: Text('Update'),
            ),
          ],
        );
      },
    );
  }

  //to get user text
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();

  List<Content> contents = [];
  //List.empty(growable: true);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.purple[200],
      appBar: AppBar(
        title: Text('To-Do App', style: TextStyle(color: Colors.white)),
        centerTitle: true,
        backgroundColor: Colors.purple[700],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(20),
            child: TextField(
              controller: titleController,
              decoration: InputDecoration(
                labelText: 'Enter a Title',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(20),
            child: TextField(
              controller: descriptionController,
              decoration: InputDecoration(
                labelText: 'Write a Description',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              maxLines: 2,
            ),
          ),
          ElevatedButton(
            onPressed: () {
              String title = titleController.text; //.trim();
              String description = descriptionController.text; //.trim();
              if (title.isNotEmpty && description.isNotEmpty) {
                setState(() {
                  contents.add(Content(title, description));
                });
                //clear after adding
                titleController.clear();
                descriptionController.clear();
              }
            },
            child: Text('Add'),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.deepPurple[700],
              foregroundColor: Colors.white,
            ),
          ),
          SizedBox(height: 20),

          Expanded(
            child: contents.isEmpty
                ? Center(
                    child: Text(
                      'No content... ',
                      style: TextStyle(fontSize: 22),
                    ),
                  )
                : ListView.builder(
                    itemCount: contents.length,
                    itemBuilder: (context, index) => getRow(index),
                  ),
          ),
        ],
      ),
    );
  }

  Widget getRow(int index) {
    return Card(
      margin: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
      child: ListTile(
        title: Text(
          style: TextStyle(fontWeight: FontWeight.bold),
          contents[index].title,
        ),
        subtitle: Text(contents[index].description),
        //checkbox inside a Listtile
        leading: Checkbox(
          value: contents[index].isDone,
          onChanged: (value) {
            setState(() {
              contents[index].isDone = value!;
            });
          },
        ),
        trailing: SizedBox(
          width: 70,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              InkWell(
                onTap: () {
                  // edit icon function
                  _showEditDialog(index);
                },
                child: Icon(Icons.edit),
              ),
              InkWell(
                onTap: () {
                  // alret box in delete icon
                  showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        title: Text('Delete Item'),
                        content: Text('Are You sure want to dlete this item?'),
                        actions: [
                          TextButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: Text('Cancel'),
                          ),
                          TextButton(
                            onPressed: () {
                              setState(() {
                                contents.removeAt(index);
                              });
                              Navigator.pop(context);
                            },
                            child: Text('Delete'),
                          ),
                        ],
                      );
                    },
                  );
                },
                child: Icon(Icons.delete),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// create a class called Content
class Content {
  String title;
  String description;
  bool isDone;
  Content(this.title, this.description, {this.isDone = false});
}
