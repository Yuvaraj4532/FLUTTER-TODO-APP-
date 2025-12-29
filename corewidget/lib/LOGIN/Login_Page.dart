import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'Success Page.dart';
import 'failed.dart';

void main() => runApp(MaterialApp(home: Login_Page()));

class Login_Page extends StatefulWidget {
  @override
  State<Login_Page> createState() => _Login_PageState();
}

class _Login_PageState extends State<Login_Page> {
  final _formKey = GlobalKey<FormState>();

  final nameController = TextEditingController();
  final passwordController = TextEditingController();

  Future<void> login() async {
    final prefs = await SharedPreferences.getInstance();

    String? username = prefs.getString('username');
    String? password = prefs.getString('password');

    if (nameController.text == username &&
        passwordController.text == password) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => Success_page()),
      );
    } else {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => Failed_page()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login Page'),
        centerTitle: true,
        backgroundColor: Colors.teal,
      ),
      body: Center(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(25),
          child: Form(
            key: _formKey,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            child: Column(
              children: [
                //NAME FIELD
                TextFormField(
                  // autofocus: true,
                  controller: nameController,
                  decoration: InputDecoration(
                    labelText: 'Name',
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Name cannot be empty';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 20),

                //PASSWORD FIELD
                TextFormField(
                  controller: passwordController,
                  decoration: InputDecoration(
                    labelText: 'Password',
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Enter Valid Password';
                    } else if (value.length != 8) {
                      return 'Password must be contain 8 character';
                    } else if (!RegExp(r'[A-Za-z]').hasMatch(value)) {
                      return 'Password contain atleast one alphabet';
                    } else if (!RegExp(r'[0-9]').hasMatch(value)) {
                      return 'Password contain atleast one Number';
                    } else if (!RegExp(
                      r'[!@#$%^&*(),.?":{}|<>]',
                    ).hasMatch(value)) {
                      return 'Password contain atleast one Special Character';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red,
                    foregroundColor: Colors.white,
                  ),

                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      login();
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => Success_page()),
                      );
                    } else {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => Failed_page()),
                      );

                      // ScaffoldMessenger.of(context).showSnackBar(
                      //   SnackBar(
                      //     content: Center(
                      //       child: Container(
                      //         height: 100,
                      //         width: 500,
                      //         child: Center(
                      //           child: Row(
                      //             children: [
                      //               Icon(
                      //                 Icons.thumb_up,
                      //                 size: 25,
                      //                 color: Colors.white,
                      //               ),
                      //               Text(
                      //                 'Form Submitted Successfuly',
                      //                 style: TextStyle(
                      //                   fontSize: 20,
                      //                   fontWeight: FontWeight.bold,
                      //                   color: Colors.white70,
                      //                 ),
                      //               ),
                      //             ],
                      //           ),
                      //         ),
                      //       ),
                      //     ),
                      //     duration: Duration(seconds: 1),
                      //     behavior: SnackBarBehavior.floating,
                      //     backgroundColor: Colors.brown,
                      //   ),
                      // );
                    }
                  },
                  child: Text('Submit'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
