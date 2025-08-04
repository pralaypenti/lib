import 'package:bloc_stm/qr_code/bloc/qr_bloc.dart';
import 'package:bloc_stm/qr_code/event/qr_event.dart';
import 'package:bloc_stm/qr_code/state/qr_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:url_launcher/url_launcher.dart';


class QRScannerScreen extends StatefulWidget {
  const QRScannerScreen({super.key});

  @override
  State<QRScannerScreen> createState() => _QRScannerScreenState();
}

class _QRScannerScreenState extends State<QRScannerScreen> {
  final MobileScannerController controller = MobileScannerController();
  bool hasScanned = false;

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  Future<void> _launchUrl(String url) async {
    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Could not launch URL")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('BLoC QR Scanner')),
      body: BlocConsumer<ScannerBloc, ScannerState>(
        listener: (context, state) async {
          if (state is ScannerSuccess) {
            await _launchUrl(state.url);
            hasScanned = false;
            controller.start();
          } else if (state is ScannerError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.message)),
            );
            hasScanned = false;
            controller.start();
          }
        },
        builder: (context, state) {
          if (state is ScannerInitial) {
            return Center(
              child: ElevatedButton(
                onPressed: () => context.read<ScannerBloc>().add(StartScan()),
                child: const Text("Start Scanning"),
              ),
            );
          } else if (state is ScannerRunning) {
            return MobileScanner(
              controller: controller,
              onDetect: (capture) {
                final barcode = capture.barcodes.first;
                if (!hasScanned && barcode.rawValue != null) {
                  hasScanned = true;
                  controller.stop();
                  context.read<ScannerBloc>().add(QRScanned(barcode.rawValue!));
                }
              },
            );
          }
          return const Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}
