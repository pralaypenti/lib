import 'dart:core';

import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(home: MyApp()));
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State createState() => _State();
}

class _State extends State<MyApp> {
  double silder = 1;

  void silderValue(double value) {
    setState(() {
      silder = value;
    });
  }

  int invat = 0;
  void groupValue(int? vales) {
    setState(() {
      invat = vales!;
    });
  }

  var name = 'hello';
  void submited(String value) {
    setState(() {
      name = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Name here')),
      body: Container(
        padding: EdgeInsets.all(32.0),
        child: Column(
          children: <Widget>[
            Text(name),
            TextButton(
              onPressed: () {
                submited('hi');
              },
              child: Text('Click'),
            ),

            Expanded(
              child: ListView(
                children: [
                  ListTile(
                    leading: Radio(
                      value: 0,
                      groupValue: invat,
                      onChanged: (value) => groupValue(value!),
                    ),
                    title: Text('Option 0'),
                  ),
                  ListTile(
                    leading: Radio(
                      value: 1,
                      groupValue: invat,
                      onChanged: (value) => groupValue(value!),
                    ),
                    title: Text('Option 0'),
                  ),
                  ListTile(
                    leading: Radio(
                      value: 2,
                      groupValue: invat,
                      onChanged: (value) => groupValue(value!),
                    ),
                    title: Text('Option 0'),
                  ),
                ],
              ),
            ),

            Slider(
              value: silder,
              min: 0,
              max: 100,
              divisions: 100,
              label: silder.round().toString(),
              onChanged: silderValue,
            ),
            Text('Slider Value: ${silder.toStringAsFixed(1)}'),
          ],
        ),
      ),
    );
  }
}

//checkbox
//switch
//datepicker
