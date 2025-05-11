import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

abstract class AdditionEvent {}

class AdditionValue extends AdditionEvent {
  final int a;
  final int b;

  AdditionValue(this.a, this.b);
}

class AdditionResult {
  int result;
  AdditionResult(this.result);
}

class AdditionOperation extends Bloc<AdditionEvent, AdditionResult> {
  AdditionOperation() : super(AdditionResult(0)) {
    on<AdditionValue>((event, emit) {
      final result = event.a + event.b;
      emit(AdditionResult(result));
    });
  }
}

class AditionalOparator extends StatefulWidget {
  const AditionalOparator({super.key});

  @override
  State<AditionalOparator> createState() => _AditionalOparatorState();
}

class _AditionalOparatorState extends State<AditionalOparator> {
  final value1 = TextEditingController();
  final value2 = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AdditionOperation(),
      child: Scaffold(
        appBar: AppBar(
          title: Text('Aditional oparator Screen'),
          backgroundColor: Colors.limeAccent,
        ),
        body: Padding(
          padding: EdgeInsets.all(15),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              TextField(
                controller: value1,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Add Value',
                ),
              ),
              SizedBox(height: 20),
              TextField(
                controller: value2,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Add Value',
                ),
              ),

              SizedBox(height: 20),

              ElevatedButton(
                onPressed: () {
                  final a = int.tryParse(value1.text) ?? 0;
                  final b = int.tryParse(value2.text) ?? 0;
                  context.read<AdditionOperation>().add(AdditionValue(a, b));
                },
                style: ElevatedButton.styleFrom(
                  textStyle: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                child: Text(
                  'Add Value',
                  style: TextStyle(color: Colors.pinkAccent),
                ),
              ),

              SizedBox(height: 25),
              BlocBuilder<AdditionOperation, AdditionResult>(
                builder: (context, state) {
                  return Text(
                    'Result:${state.result}',
                    style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
