import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:workerbase_challenge/bloc/database_bloc.dart';

class HistoryScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DatabaseBloc, DatabaseState>(builder: (context, databasestate) {
      if (databasestate is DatabaseEmpty) {
        return Center(
          child: Text("Please Scan a Item to view the history"),
        );
      }
      if (databasestate is DatabaseAvailable) {
        return ListView.separated(
          padding: const EdgeInsets.all(8),
          itemCount: databasestate.entries.length,
          itemBuilder: (BuildContext context, int index) {
            return Container(
              height: 50,
              child: Center(child: Text('URI: ${databasestate.entries[index].uri}')),
            );
          },
          separatorBuilder: (BuildContext context, int index) => const Divider(),
        );
      } else
        return CircularProgressIndicator();
    });
  }
}
