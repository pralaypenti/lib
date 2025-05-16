import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// Events
abstract class CounterEvent {}

class Increment extends CounterEvent {}

class Decrement extends CounterEvent {}

// State
class CounterState {
  final int result;
  CounterState(this.result);
}

// BLoC
class CounterBloc extends Bloc<CounterEvent, CounterState> {
  CounterBloc() : super(CounterState(0)) {
    on<Increment>((event, emit) => emit(CounterState(state.result + 1)));
    on<Decrement>((event, emit) => emit(CounterState(state.result - 1)));
  }
}

// UI
class BlocStateManagement extends StatelessWidget {
  const BlocStateManagement({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Bloc State Management'),
          backgroundColor: Colors.tealAccent,
          foregroundColor: Colors.black,
        ),
        body: BlocBuilder<CounterBloc, CounterState>(
          builder: (context, state) =>
              Center(child: Text('Count Value: ${state.result}',
                style: const TextStyle(fontSize: 30))),
        ),
        floatingActionButton: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            FloatingActionButton(
              onPressed: () => context.read<CounterBloc>().add(Increment()),
              child: const Icon(Icons.add),
            ),
            const SizedBox(width: 25),
            FloatingActionButton(
              onPressed: () => context.read<CounterBloc>().add(Decrement()),
              child: const Icon(Icons.remove),
            ),
          ],
        ),
      );
  }
}
