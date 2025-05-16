import 'package:bloc_stm/bloc/bloc_details.dart' show detailsDataBloc;
import 'package:bloc_stm/model/model_call.dart';
import 'package:flutter/material.dart';

class DetailsViewScreen extends StatefulWidget {
  const DetailsViewScreen({super.key});

  @override
  State<DetailsViewScreen> createState() => _DetailsViewScreenState();
}

class _DetailsViewScreenState extends State<DetailsViewScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    detailsDataBloc.fetchData();
  }

  @override
  void dispose() {
    detailsDataBloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Details Screen')),
      body: StreamBuilder<List<AgeDetailes>>(
        stream: detailsDataBloc.detailsDataStream,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            if (snapshot.data!.isEmpty) {
              return Center(child: Text('No data available.'));
            }
            final detail = snapshot.data!.reversed.first;
            return Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text('Name'),
                  SizedBox(width: 20),
                  Text(detail.name),
                  Text(detail.age.toString()),
                  Text(detail.count.toString()),
                ],
              ),
            );
          } else if (snapshot.hasError) {
            return Center(child: Text(snapshot.error.toString()));
          }
          return Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}
