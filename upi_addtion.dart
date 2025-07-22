import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';



// Screen
class UpiScreenBlanceAddition extends StatefulWidget {
  const UpiScreenBlanceAddition({super.key});

  @override
  State<UpiScreenBlanceAddition> createState() =>
      _UpiScreenBlanceAdditionState();
}

class _UpiScreenBlanceAdditionState extends State<UpiScreenBlanceAddition> {
  final TextEditingController controller = TextEditingController();

  void _appendValue() {
    final input = controller.text.trim();
    if (input.isNotEmpty && RegExp(r'^\d+$').hasMatch(input)) {
      controller.text += '+';
      controller.selection = TextSelection.fromPosition(
        TextPosition(offset: controller.text.length),
      );
    }
  }

  void _submitExpression(BuildContext context) {
    final expression = controller.text.trim();
    if (expression.isNotEmpty) {
      // Remove trailing + if any
      final cleaned = expression.endsWith('+')
          ? expression.substring(0, expression.length - 1)
          : expression;

      // Split and calculate sum
      final parts = cleaned.split('+');
      int total = 0;
      for (var part in parts) {
        total += int.tryParse(part.trim()) ?? 0;
      }

      context.read<UpiBloc>().add(AdditionEvent(total));
      controller.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('UPI Balance'),
        backgroundColor: Colors.blueAccent,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Text field with suffix icon
              TextFormField(
                controller: controller,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Enter amount',
                  suffixIcon: IconButton(
                    icon: Icon(Icons.add),
                    onPressed: _appendValue,
                  ),
                ),
              ),
              SizedBox(height: 20),

              // Submit button
              ElevatedButton(
                onPressed: () => _submitExpression(context),
                child: Text('Submit'),
              ),
              SizedBox(height: 30),

              // Display result
              BlocBuilder<UpiBloc, UpiState>(
                builder: (context, state) {
                  return Text(
                    'Total Balance: ${state.result}',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
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

//
// Event
//
abstract class UpiAddtion {}

class AdditionEvent extends UpiAddtion {
  final int amount;
  AdditionEvent(this.amount);
}

//
// State
//
class UpiState {
  final int result;
  UpiState(this.result);
}

//
// Bloc
//
class UpiBloc extends Bloc<UpiAddtion, UpiState> {
  UpiBloc() : super(UpiState(0)) {
    on<AdditionEvent>((event, emit) {
      emit(UpiState(event.amount));
    });
  }
}
