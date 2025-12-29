//! SEMANTICS--> Wrap any widget with Semantics() to give accessibility meaning.

import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';

void main() => runApp(
  MaterialApp(
    // showSemanticsDebugger: true,  //! to view semantics in debug
    home: MyApp(),
  ),
);

class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  int counter = 0;
  bool isChecked = true;

  FlutterTts tts = FlutterTts();

  Future speak(String text) async {
    await tts.setLanguage("en_US");
    await tts.setSpeechRate(0.5);
    await tts.speak(text);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('SEMANTICS + TTS'),
        centerTitle: true,
        backgroundColor: Colors.teal,
      ),
      body: Center(
        child: Column(
          children: [
            // TITLE
            //! LABEL,HINT,VALUE,INCREASED VALUE
            //! 1.LABEL-->Describes the widget
            Semantics(
              label: 'semantic widget Text',
              child: GestureDetector(
                onTap: () => speak('semantic widget'),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(" Semantics Widget", style: TextStyle(fontSize: 30)),
                    // SUBMIT BUTTON
                    //! 2.HINT-->Explain what user should do.
                    Semantics(
                      label: 'login button',
                      hint: 'tap to login',

                      child: ElevatedButton(
                        onPressed: () {
                          speak('submit button pressed');
                        },
                        child: Text('Submit'),
                      ),
                    ),

                    // SLIDER
                    //! 3.VALUE
                    Semantics(
                      label: 'Volume',
                      value: '50 percent',
                      child: Slider(
                        value: 50,
                        min: 0,
                        max: 100,
                        onChanged: (value) {
                          speak('volume is $value percent');
                        },
                      ),
                    ),

                    //COUNTER
                    //! 4.INCREASED & DECREASED VALUE
                    Semantics(
                      label: 'Counter button',
                      hint: 'tap to count',
                      value: '$counter',
                      increasedValue: '${counter + 1}',
                      decreasedValue: '${counter - 1}',
                      child: IconButton(
                        onPressed: () {
                          setState(() {
                            counter++;
                            print("icon clicked");
                          });
                          speak('counter value is $counter');
                        },
                        icon: Icon(Icons.add),
                      ),
                    ),

                    //! ROLE FLAG(button, image, slider, header, checked, enabled)
                    //==>These flags tell screen readers what type of control it is.

                    //proceed box
                    //! BUTTON
                    Semantics(
                      label: 'proceed ',
                      button: true,
                      child: GestureDetector(
                        onTap: () => speak('proceed button clicked'),

                        child: Container(
                          height: 30,
                          width: 70,
                          padding: EdgeInsets.all(5),
                          color: Colors.blue,
                          child: Text('proceed'),
                        ),
                      ),
                    ),
                    SizedBox(height: 10),
                    //IMAGE
                    //! IMAGE
                    Semantics(
                      label: 'Profile picture',
                      image: true,
                      child: GestureDetector(
                        onTap: () => speak('profile image tapped'),

                        child: CircleAvatar(
                          radius: 40,
                          backgroundImage: NetworkImage(
                            "https://cdn.vectorstock.com/i/500p/53/42/user-member-avatar-face-profile-icon-vector-22965342.jpg",
                          ),
                        ),
                      ),
                    ),

                    //HEADER
                    //! HEADER
                    Semantics(
                      label: 'User Information',
                      header: true,
                      child: GestureDetector(
                        onTap: () => speak('User Information Header'),
                        child: Text(
                          "User Information",
                          style: TextStyle(
                            fontSize: 26,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 10),

                    // CHECK BOX
                    //! CHECKED
                    Semantics(
                      label: "Accept terms",
                      checked: isChecked,
                      child: GestureDetector(
                        onTap: () {
                          setState(() {
                            isChecked = !isChecked;
                          });
                          speak(
                            isChecked ? "terms accepted" : "Terms not accepted",
                          );
                        },

                        child: Icon(
                          isChecked
                              ? Icons.check_box
                              : Icons.check_box_outline_blank,
                        ),
                      ),
                    ),

                    //! EXCLUDING SEMANTICS
                    ExcludeSemantics(child: Text('this will be ignored')),

                    // MERGE SEMANTICS
                    //! MERGE SEMANTICS
                    //Combine multiple widgets as one semantic node.

                    // Example: Checkbox + text
                    // Without Merge → screen reader reads 2 items
                    // With Merge → reads as 1 item
                    MergeSemantics(
                      child: GestureDetector(
                        onTap: () => speak('i agree'),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Checkbox(
                              value: true,
                              onChanged: (_) {
                                speak('checkbox selected');
                              },
                            ),
                            Text('I agree'),
                          ],
                        ),
                      ),
                    ),

                    SizedBox(height: 10),
                    //SEMANTIC FOR CUSTOM BUTTONS
                    Semantics(
                      label: 'add item',
                      button: true,
                      onTapHint: 'item added to cart',
                      child: GestureDetector(
                        onTap: () => speak('item added'),
                        child: Container(
                          padding: EdgeInsets.all(12),
                          color: Colors.grey,
                          child: Text('Add'),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 20),

            //TEXTFIELD
            Semantics(
              label: 'text field',
              hint: 'Type your full name',
              textField: true,
              child: Container(
                width: 200,
                height: 40,
                child: TextField(
                  onTap: () {
                    speak('text field focused, start typing');
                  },
                  onChanged: (value) {
                    speak(' $value');
                  },
                  onSubmitted: (value) {
                    speak('you entered $value');
                  },

                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Enter a Text',
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
