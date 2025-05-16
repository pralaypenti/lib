import 'package:bloc_stm/Screen/ui.dart';
import 'package:bloc_stm/addition_dloc.dart';
import 'package:bloc_stm/bloc_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => CounterBloc()),
        BlocProvider(create: (_) => AdditionOperation()),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        ),
        home: ButtonViews(),
      ),
    );
  }
}

class ButtonViews extends StatefulWidget {
  const ButtonViews({super.key});

  @override
  State<ButtonViews> createState() => _ButtonViewsState();
}

class _ButtonViewsState extends State<ButtonViews> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Button Screen')),
      body: Center(
        child: Column(
          children: [
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => BlocStateManagement(),
                  ),
                );
              },
              child: Text('Button'),
            ),

            SizedBox(height: 25),

            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => AditionalOparator()),
                );
              },
              child: Text('Button'),
            ),

              ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => DetailsViewScreen()),
                );
              },
              child: Text('Button'),
            ),
            
          ],
        ),
      ),
    );
  }
}
