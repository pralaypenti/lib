abstract class ScannerState {}

class ScannerInitial extends ScannerState {}

class ScannerRunning extends ScannerState {}

class ScannerSuccess extends ScannerState {
  final String url;
  ScannerSuccess(this.url);
}

class ScannerError extends ScannerState {
  final String message;
  ScannerError(this.message);
}
