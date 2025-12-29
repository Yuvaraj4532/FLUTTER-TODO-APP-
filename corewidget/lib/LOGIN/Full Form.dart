import 'Login_Page.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'Success Page.dart';
import 'failed.dart';

void main() => runApp(MaterialApp(home: MyApp()));

class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final _formKey = GlobalKey<FormState>();

  final nameController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  final passwordController = TextEditingController();

  Future<void> saveUser() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('username', nameController.text);
    await prefs.setString('password', passwordController.text);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Sign Up'),
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

                // CONFIRM PASSWORD FIELD
                TextFormField(
                  controller: confirmPasswordController,
                  decoration: InputDecoration(
                    labelText: 'Confirm Password',
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Confirm Your Password';
                    }
                    if (value != passwordController.text) {
                      return 'Password do not match';
                    }
                  },
                ),
                SizedBox(height: 20),

                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red,
                    foregroundColor: Colors.white,
                  ),

                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      await saveUser();

                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => Login_Page()),
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

// ScaffoldMessenger.of(context).showSnackBar(
//   SnackBar(
//     content: Text("Form Submitted Successfully"),
//     duration: Duration(seconds: 2),   // optional
//     behavior: SnackBarBehavior.floating, // optional (makes it float)
//   ),
// );


// save credientials code

//    Save credentials to SharedPreferences
//    Future<void> _saveCredentials(String name, String password) async {
//      final prefs = await SharedPreferences.getInstance();
//     await prefs.setString('saved_name', name);
//     await prefs.setString('saved_password', password);
//   }

//   void _onSubmit() async {
//     if (_formKey.currentState?.validate() ?? false) {
//       final name = nameController.text.trim();
//       final password = passwordController.text;

//       // Save credentials locally
//       await _saveCredentials(name, password);

//       // Replace current page with Success_page
//       Navigator.pushReplacement(
//         context,
//         MaterialPageRoute(builder: (context) => const SuccessPage()),
//       );
//     }
//   }

//   @override
//   void dispose() {
//     nameController.dispose();
//     passwordController.dispose();
//     confirmPasswordController.dispose();
//     super.dispose();
//   }