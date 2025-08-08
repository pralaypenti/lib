import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
class TermsState {
  final bool isChecked;
  TermsState({required this.isChecked});

  TermsState copyWith({bool? isChecked}) {
    return TermsState(isChecked: isChecked ?? this.isChecked);
  }
}
abstract class TermsEvent {}

class ToggleCheckboxEvent extends TermsEvent {
  final bool isChecked;
  ToggleCheckboxEvent(this.isChecked);
}

class TermsBloc extends Bloc<TermsEvent, TermsState> {
  TermsBloc() : super(TermsState(isChecked: false)) {
    on<ToggleCheckboxEvent>((event, emit) {
      emit(state.copyWith(isChecked: event.isChecked));
    });
  }
}



class TermsScreen extends StatelessWidget {
  const TermsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => TermsBloc(),
      child: Scaffold(
        appBar: AppBar(title: const Text("Terms & Conditions")),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: BlocBuilder<TermsBloc, TermsState>(
            builder: (context, state) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Please read and accept our Terms and Conditions to continue.",
                    style: TextStyle(fontSize: 16),
                  ),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      Checkbox(
                        value: state.isChecked,
                        onChanged: (value) {
                          context.read<TermsBloc>().add(
                            ToggleCheckboxEvent(value ?? false),
                          );
                        },
                      ),
                      const Expanded(
                        child: Text("I agree to the Terms and Conditions"),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed:
                          state.isChecked
                              ? () {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text("Proceeding..."),
                                  ),
                                );
                              }
                              : null, // disabled when unchecked
                      child: const Text("Evaluate"),
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
