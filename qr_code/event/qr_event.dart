import 'package:equatable/equatable.dart';

abstract class ScannerEvent extends Equatable {
  const ScannerEvent();
  @override
  List<Object?> get props => [];
}

class StartScan extends ScannerEvent {}

class QRScanned extends ScannerEvent {
  final String scannedData;
  const QRScanned(this.scannedData);
  @override
  List<Object?> get props => [scannedData];
}
