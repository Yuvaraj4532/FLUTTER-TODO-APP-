//!  user input in console
// import 'package:flutter/material.dart';

// void main() => runApp(MaterialApp(home: MyApp()));

// class MyApp extends StatefulWidget {
//   @override
//   State<MyApp> createState() => _MyAppState();
// }

// class _MyAppState extends State<MyApp> {
//   final TextEditingController _emailController = TextEditingController();

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('form and validation'),
//         centerTitle: true,
//         backgroundColor: Colors.teal,
//       ),
//       body: Padding(
//         padding: EdgeInsetsGeometry.all(15),
//         child: Column(
//           children: [
//             TextField(
//               controller: _emailController,
//               keyboardType: TextInputType.emailAddress,
//               decoration: InputDecoration(label: Text('Email Adress')),
//             ),
//             SizedBox(height: 20),
//             FilledButton(
//               onPressed: () {
//                 print(_emailController.text.trim());
//               },
//               child: Text('print the email'),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

void main() => runApp(MaterialApp(home: MyApp()));

class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final _formGlobalKey = GlobalKey<FormState>();
  String _title = '';
  String _description = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('validation'),
        centerTitle: true,
        backgroundColor: Colors.teal,
      ),
      body: Padding(
        padding: EdgeInsetsGeometry.all(20),
        child: Column(
          children: [
            //! form stuff below here
            Form(
              key: _formGlobalKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // title
                  TextFormField(
                    maxLength: 20,
                    decoration: InputDecoration(label: Text('Title')),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'you must enter  a value for titel';
                      }
                      return null;
                    },
                    onSaved: (value) {
                      _title = value!;
                    },
                  ),

                  // description
                  TextFormField(
                    maxLength: 20,
                    decoration: InputDecoration(label: Text('Description')),
                    validator: (value) {
                      if (value == null || value.isEmpty || value.length < 5) {
                        return 'Enter atleast 5 character length';
                      }
                      return null;
                    },
                    onSaved: (value) {
                      _description = value!;
                    },
                  ),

                  // // priority
                  // DropdownButtonFormField(
                  //   decoration: const InputDecoration(
                  //     label: Text('priority to todo'),
                  //   ),
                  //   items: Priority.values.map((p) {
                  //     return DropdownMenuItem(value: p, child: Text(p.title));
                  //   }).toList(),
                  //   onChanged: (value) {
                  //     print(value);
                  //   },
                  // ),

                  //submit button
                  SizedBox(height: 30),
                  FilledButton(
                    onPressed: () {
                      if (_formGlobalKey.currentState!.validate()) {}
                    },
                    style: FilledButton.styleFrom(
                      backgroundColor: Colors.grey[800],
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadiusGeometry.circular(10),
                      ),
                    ),
                    child: Text('submit'),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
