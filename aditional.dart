import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// --- Events ---
abstract class AddEvent {}

class AddValue extends AddEvent {
  final int a;
  final int b;

  AddValue(this.a, this.b);
}

// --- State ---
class AddResult {
  final int result;

  AddResult(this.result);
}

// --- BLoC ---
class BlocOperation extends Bloc<AddEvent, AddResult> {
  BlocOperation() : super(AddResult(0)) {
    on<AddValue>((event, emit) {
      final sum = event.a + event.b;
      emit(AddResult(sum));
    });
  }
}

// --- UI Widget ---
class AdditionalOperator extends StatefulWidget {
  const AdditionalOperator({super.key});

  @override
  State<AdditionalOperator> createState() => _AdditionalOperatorState();
}

class _AdditionalOperatorState extends State<AdditionalOperator> {
  final firstController = TextEditingController();
  final secondController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => BlocOperation(),
      child: Scaffold(
        appBar: AppBar(
          title: Text('Additional Operator Screen'),
          backgroundColor: Colors.limeAccent,
        ),
        body: Padding(
          padding: EdgeInsets.all(15),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              TextField(
                controller: firstController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Enter first value',
                ),
              ),
              SizedBox(height: 20),
              TextField(
                controller: secondController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Enter second value',
                ),
              ),
              SizedBox(height: 20),
              Builder(
                builder: (context) {
                  return ElevatedButton(
                    onPressed: () {
                      final a = int.tryParse(firstController.text) ?? 0;
                      final b = int.tryParse(secondController.text) ?? 0;
                      context.read<BlocOperation>().add(AddValue(a, b));
                    },
                    style: ElevatedButton.styleFrom(
                      textStyle: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    child: Text(
                      'Add Values',
                      style: TextStyle(color: Colors.pinkAccent),
                    ),
                  );
                },
              ),

              SizedBox(height: 25),
              BlocBuilder<BlocOperation, AddResult>(
                builder: (context, state) {
                  return Text(
                    'Result: ${state.result}',
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
