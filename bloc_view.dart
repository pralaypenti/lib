import 'package:flutter/material.dart';

abstract class CounterEvent {}

class Increment extends CounterEvent {}

class Decrement extends CounterEvent {}

class SampleBloc {
  int count = 0;

  void countValue(CounterEvent event) {
    if (event is Increment) {
      count++;
    } else if (event is Decrement) {
      count--;
    }
  }
}

class BlocStatmanagement extends StatefulWidget {
  const BlocStatmanagement({super.key});

  @override
  State<BlocStatmanagement> createState() => _BlocStatmanagementState();
}

class _BlocStatmanagementState extends State<BlocStatmanagement> {
  final SampleBloc value = SampleBloc();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Bloc Statemanagement'),
        backgroundColor: Colors.tealAccent,
      ),
      body: Center(child: Text('count Value::${value.count} ')),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            onPressed: () {
              setState(() {
                value.countValue(Increment());
              });
            },
            child: Icon(Icons.add),
          ),
          SizedBox(width: 25),
          FloatingActionButton(
            onPressed: () {
              setState(() {
                value.countValue(Decrement());
              });
            },
            child: Icon(Icons.remove),
          ),
        ],
      ),
    );
  }
}
