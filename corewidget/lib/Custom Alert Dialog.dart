import 'package:flutter/material.dart';

void main() => runApp(MaterialApp(home: MyApp()));

class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(' Simple Custom Alert Dialog'),
        centerTitle: true,
        backgroundColor: Colors.teal,
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            String title = "Text Message";
            String message = "Welcome to Simpel Alert Dialog Box";
            showAlertDialog(context, title, message);
          },
          child: Text('Click Me'),
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.red,
            foregroundColor: Colors.white,
          ),
        ),
      ),
    );
  }
}

showAlertDialog(BuildContext context, String title, String message) {
  //set button
  Widget okbtn = TextButton(
    onPressed: () {},
    child: Text('Ok'),
    style: TextButton.styleFrom(
      backgroundColor: Colors.orange,
      foregroundColor: Colors.white,
    ),
  );
  Widget cancelbtn = TextButton(
    onPressed: () {},
    child: Text('Cancel'),
    style: TextButton.styleFrom(
      backgroundColor: Colors.red,
      foregroundColor: Colors.white,
    ),
  );
  AlertDialog alert = AlertDialog(
    title: Text(title, style: TextStyle(color: Colors.orange)),
    content: Text(message),
    actions: [okbtn, cancelbtn],
  );

  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}
