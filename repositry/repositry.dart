import 'package:bloc_stm/api_reposity/api_calling.dart';
import 'package:bloc_stm/model/model_call.dart';

class Repository {
  ApiCalling details = ApiCalling();

  Future<List<AgeDetailes>> getLastetDetails() => details.getLatestResult();
}
