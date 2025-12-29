import 'package:flutter/material.dart';

void main() => runApp(MaterialApp(home: MyApp()));

class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool _secureText = true;

  TextEditingController _passwordController = TextEditingController();
  String _passwordError;

  var _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Text field'),
        centerTitle: true,
        backgroundColor: Colors.teal,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            TextField(
              decoration: InputDecoration(
                hintText: 'Your Name',
                labelText: 'Name:',
                labelStyle: TextStyle(fontSize: 15, color: Colors.black),
                border: InputBorder.none,
                fillColor: Colors.grey,
                filled: true,
              ),
              keyboardType: TextInputType.emailAddress,
              obscureText: false,
              maxLength: 15,
            ),
            TextField(
              decoration: InputDecoration(
                hintText: ' Detailed Description ',
                labelText: 'Description',
                labelStyle: TextStyle(fontSize: 15, color: Colors.black),
                border: UnderlineInputBorder(),
                fillColor: Colors.grey,
                filled: false,
              ),
              keyboardType: TextInputType.emailAddress,
              obscureText: false,
              maxLines: 3,
            ),
            SizedBox(height: 20.0),
            TextField(
              controller: _passwordController,
              decoration: InputDecoration(
                hintText: ' password ',
                labelText: 'Password',
                errorText: null,
                labelStyle: TextStyle(fontSize: 15, color: Colors.black),
                border: OutlineInputBorder(),
                suffixIcon: IconButton(
                  onPressed: () {
                    _secureText = !_secureText;
                  },
                  icon: Icon(
                    _secureText ? Icons.remove_red_eye : Icons.security,
                  ),
                ),
              ),
              obscureText: true,
            ),
            SizedBox(height: 30.0),

            Form(
              key: _formKey,
              child: TextFormField(
                validator: (String value) {
                  if (value.lenght > 3)
                    return "Enter atleast 3 char";
                  else
                    return null;
                },
                decoration: InputDecoration(
                  hintText: 'Password',
                  labelText: 'password',
                  labelStyle: TextStyle(fontSize: 24, color: Colors.black),
                  border: OutlineInputBorder(),
                ),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                print('Password:' + _passwordController.text);
                setState(() {
                  print(
                    "Form Validation:" +
                        _formKey.currentState.validate().toString(),
                  );
                  if (_passwordController.text.length > 3)
                    _passwordError = "Enter at least 3 char";
                  else
                    _passwordError = null;
                });
              },
              child: Text('button'),
            ),
          ],
        ),
      ),
    );
  }
}
