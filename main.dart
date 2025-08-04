import 'package:bloc_stm/Screen/ui.dart';
import 'package:bloc_stm/addition_dloc.dart';
import 'package:bloc_stm/animated_login/animated_login.dart';
import 'package:bloc_stm/animated_login/bloc.dart';
import 'package:bloc_stm/bloc_view.dart';
import 'package:bloc_stm/permission_hendler/bloc/bloc_class.dart';
import 'package:bloc_stm/permission_hendler/ui/permission_handler.dart';
import 'package:bloc_stm/qr_code/bloc/qr_bloc.dart';
import 'package:bloc_stm/qr_code/ui/qr_code.dart';
import 'package:bloc_stm/upi_addtion.dart';
import 'package:bloc_stm/with_out_save_number_whatsapp/bloc/wsap_bloc.dart';
import 'package:bloc_stm/with_out_save_number_whatsapp/ui/wsn_whatsapp.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
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
              child: Text('Counter'),
            ),

            SizedBox(height: 25),

            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => AditionalOparator()),
                );
              },
              child: Text('Addition'),
            ),
            SizedBox(height: 25),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => DetailsViewScreen()),
                );
              },
              child: Text('DetailsViewScreen'),
            ),
            SizedBox(height: 25),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder:
                        (context) => BlocProvider(
                          create: (_) => PermissionBloc(),
                          child: const PermissionHandlerView(),
                        ),
                  ),
                );
              },
              child: const Text('Permission Button'),
            ),
            SizedBox(height: 25),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder:
                        (context) => BlocProvider(
                          create: (_) => UpiBloc(),
                          child: const UpiScreenBlanceAddition(),
                        ),
                  ),
                );
              },
              child: const Text('upibalance'),
            ),
            SizedBox(height: 25),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder:
                        (context) => MultiBlocProvider(
                          providers: [
                            BlocProvider(create: (_) => WhatsAppBloc()),
                          ],
                          child: const WhatsAppScreen(),
                        ),
                  ),
                );
              },
              child: const Text('Direct WhatsAppScreen'),
            ),
            SizedBox(height: 25),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder:
                        (context) => BlocProvider(
                          create: (_) => ScannerBloc(),
                          child: const QRScannerScreen(),
                        ),
                  ),
                );
              },
              child: const Text('QR Code'),
            ),
            SizedBox(height: 25),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder:
                        (context) => BlocProvider(
                          create: (_) => LoginBloc(),
                          child:  TeddyLoginScreen(),
                        ),
                  ),
                );
              },
              child: const Text('QR Code'),
            ),
          ],
        ),
      ),
    );
  }
}
