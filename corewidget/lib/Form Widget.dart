import 'package:flutter/material.dart';

void main() => runApp(MaterialApp(home: MyApp()));

class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Form Widget'),
        centerTitle: true,
        backgroundColor: Colors.teal,
      ),
      body: Padding(
        padding: EdgeInsetsGeometry.all(20.0),
        child: Form(
          //! onChanged--->  print msg in console while user typing.
          onChanged: () {
            print('User is typing');
          },
          //!autoValidateMode---> form should validte automaticly.
          //! 1.disabled-no auto validation , 2.always-validate every time UI changes , 3.onUserInteraction- after user types
          autovalidateMode: AutovalidateMode.onUserInteraction,
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                //! onChanged-->print live text.
                onChanged: (value) {
                  print("Typing: $value");
                },
                //! autofocus----> keyboard opens automaticqlly when screen loads.
                autofocus: true,
                //! conttoller---> print whatever user typed
                controller: _nameController,
                decoration: InputDecoration(
                  labelText: "User Name",
                  hintText: "Name",
                  border: OutlineInputBorder(),
                ),
                validator: (value) => value!.isEmpty ? "Enter Text" : null,
              ),
              SizedBox(height: 30),
              TextFormField(
                //! autofocus----> keyboard opens automaticqlly when screen loads.
                autofocus: true,
                //! KeyboardType--->keyboard type can be customized
                keyboardType: TextInputType.number,

                decoration: InputDecoration(
                  labelText: "Password",
                  hintText: "password",
                  border: OutlineInputBorder(),
                ),
                validator: (value) => value!.isEmpty ? "Enter password" : null,
              ),
              ElevatedButton(
                onPressed: () {
                  print(_nameController.text);

                  if (_formKey.currentState!.validate()) {
                    print('Form Valid');
                  } else {
                    print('nothing');
                  }
                },
                child: Text('Submit'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
