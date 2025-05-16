import 'package:bloc_stm/model/model_call.dart';
import 'package:bloc_stm/repositry/repositry.dart';

import 'package:rxdart/rxdart.dart';

class DetailsDataBloc {
  final _repository = Repository();
  final _detailsDataFecther = PublishSubject<List<AgeDetailes>>();

  Stream<List<AgeDetailes>> get detailsDataStream => _detailsDataFecther.stream;

  fetchData() async {
    List<AgeDetailes> data = await _repository.getLastetDetails();
    _detailsDataFecther.sink.add(data);
  }

  dispose() {
    _detailsDataFecther.close();
  }
}

final detailsDataBloc = DetailsDataBloc();