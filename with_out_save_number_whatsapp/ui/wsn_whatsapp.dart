import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:country_code_picker/country_code_picker.dart';
import 'package:bloc_stm/with_out_save_number_whatsapp/bloc/wsap_bloc.dart';
import 'package:bloc_stm/with_out_save_number_whatsapp/events/wts_event.dart';
import 'package:bloc_stm/with_out_save_number_whatsapp/state/wstap_state.dart';

class WhatsAppScreen extends StatefulWidget {
  const WhatsAppScreen({super.key});

  @override
  State<WhatsAppScreen> createState() => _WhatsAppScreenState();
}

class _WhatsAppScreenState extends State<WhatsAppScreen> {
  final TextEditingController countryController = TextEditingController(
    text: "+91",
  );
  final TextEditingController numberController = TextEditingController();
  final TextEditingController messageController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocListener<WhatsAppBloc, WhatsAppState>(
      listener: (context, state) {
        if (state is WhatsAppSending) {
          EasyLoading.show(status: 'Sending...');
        } else if (state is WhatsAppSentSuccess) {
          EasyLoading.dismiss();
          EasyLoading.showSuccess('Message Sent');
        } else if (state is WhatsAppFailed) {
          EasyLoading.dismiss();
          EasyLoading.showError(state.error);
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text('WhatsApp Sender'),
          backgroundColor: Colors.green,
        ),
        body: Padding(
          padding: const EdgeInsets.all(15),
          child: Column(
            children: [
              Row(
                children: [
                  Container(
                    height: 55,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey),
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: CountryCodePicker(
                      onChanged: (country) {
                        countryController.text = country.dialCode!;
                      },
                      initialSelection: 'IN',
                      favorite: ['+91', 'IN'],
                      textStyle: const TextStyle(fontSize: 16),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: TextField(
                      controller: numberController,
                      keyboardType: TextInputType.phone,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: 'Enter phone number',
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              TextField(
                controller: messageController,
                maxLines: 5,
                maxLength: 1000,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Type your message',
                ),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  context.read<WhatsAppBloc>().add(
                    SendWhatsAppMessage(
                      countryCode: countryController.text.trim(),
                      phoneNumber: numberController.text.trim(),
                      message: messageController.text.trim(),
                    ),
                  );
                },
                child: const Text("Send WhatsApp Message"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
