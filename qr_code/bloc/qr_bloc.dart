import 'package:bloc_stm/qr_code/event/qr_event.dart';
import 'package:bloc_stm/qr_code/state/qr_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


class ScannerBloc extends Bloc<ScannerEvent, ScannerState> {
  ScannerBloc() : super(ScannerInitial()) {
    on<StartScan>((event, emit) {
      emit(ScannerRunning());
    });

    on<QRScanned>((event, emit) {
      final data = event.scannedData;
      if (Uri.tryParse(data)?.isAbsolute ?? false) {
        emit(ScannerSuccess(data));
      } else {
        emit( ScannerError("Invalid QR Code"));
      }
    });
  }
}
