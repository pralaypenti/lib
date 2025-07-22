// bloc/country_code_bloc.dart
import 'package:bloc_stm/with_out_save_number_whatsapp/events/wts_event.dart';
import 'package:bloc_stm/with_out_save_number_whatsapp/state/wstap_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// bloc/whatsapp_bloc.dart
import 'dart:io';
import 'package:url_launcher/url_launcher.dart';

class WhatsAppBloc extends Bloc<WhatsAppEvent, WhatsAppState> {
  WhatsAppBloc() : super(WhatsAppInitial()) {
    on<SendWhatsAppMessage>((event, emit) async {
      emit(WhatsAppSending());
      try {
        final fullPhone = '${event.countryCode}${event.phoneNumber}';
        final encodedMsg = Uri.encodeComponent(event.message);

        final uri = Platform.isIOS
            ? 'https://wa.me/$fullPhone?text=$encodedMsg'
            : 'whatsapp://send?phone=$fullPhone&text=$encodedMsg';

        if (!await launchUrl(Uri.parse(uri),
            mode: LaunchMode.externalApplication)) {
          emit(
            WhatsAppFailed("WhatsApp is not installed or URL launch failed."),
          );
        } else {
          emit(WhatsAppSentSuccess());
        }
      } catch (e) {
        emit(WhatsAppFailed("Error: ${e.toString()}"));
      }
    });
  }
}