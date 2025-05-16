import 'dart:convert';

import 'package:http/http.dart' as http;

import '../model/model_call.dart' show AgeDetailes;

class ApiCalling {
  Future<List<AgeDetailes>> getLatestResult() async {
    try {
      var data = await http.get(Uri.parse("https://api.agify.io?name=meelad"));

      final jsonResponse = json.decode(data.body);
      final ageDetail = AgeDetailes.fromJson(jsonResponse);

      return [ageDetail];
    } catch (e) {
      throw Exception(e);
    }
  }
}
