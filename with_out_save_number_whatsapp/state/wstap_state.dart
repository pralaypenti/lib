abstract class WhatsAppState {}

class WhatsAppInitial extends WhatsAppState {}

class WhatsAppSending extends WhatsAppState {}

class WhatsAppSentSuccess extends WhatsAppState {}

class WhatsAppFailed extends WhatsAppState {
  final String error;
  WhatsAppFailed(this.error);
}



