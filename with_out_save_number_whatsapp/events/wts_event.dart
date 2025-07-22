// bloc/country_code_event.dart
abstract class CountryCodeEvent {}

class LoadCountryCodes extends CountryCodeEvent {}

// bloc/country_code_state.dart
abstract class CountryCodeState {}

class CountryCodeInitial extends CountryCodeState {}
class CountryCodeLoading extends CountryCodeState {}
class CountryCodeLoaded extends CountryCodeState {
  final List<Map<String, dynamic>> countryCodes;
  CountryCodeLoaded(this.countryCodes);
}
class CountryCodeError extends CountryCodeState {
  final String error;
  CountryCodeError(this.error);
}


// bloc/whatsapp_event.dart
abstract class WhatsAppEvent {}

class SendWhatsAppMessage extends WhatsAppEvent {
  final String countryCode;
  final String phoneNumber;
  final String message;

  SendWhatsAppMessage({
    required this.countryCode,
    required this.phoneNumber,
    required this.message,
  });
}