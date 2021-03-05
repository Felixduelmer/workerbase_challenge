import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:workerbase_challenge/database/database.dart';
import 'package:workerbase_challenge/models/qr_entry.dart';
import 'package:equatable/equatable.dart';

part 'database_event.dart';

part 'database_state.dart';

class DatabaseBloc extends Bloc<DatabaseEvent, DatabaseState> {
  List<QREntry> list;

  DatabaseBloc() : super(DatabaseEmpty());

  @override
  void onTransition(Transition<DatabaseEvent, DatabaseState> transition) {
    print(transition);
    super.onTransition(transition);
  }

  @override
  Stream<DatabaseState> mapEventToState(DatabaseEvent event,) async* {
    if (event is QueryEntries) {
      _mapQueryEntriesToState(event);
    } else if (event is InsertEntry){
      _mapInsertEntryToState(event);
    }
  }

  _mapQueryEntriesToState(QueryEntries entries) async* {
    try {
      list = await DBProvider.db.fetchEntries();
      if (list.isEmpty)
        yield DatabaseEmpty();
      else
        yield DatabaseAvailable(list);
    } catch (e) {
      print(e);
      yield DatabaseNotAvailable();
    }
  }

  _mapInsertEntryToState(InsertEntry event) async*{
    try{
      await DBProvider.db.insertEntry(event.entry);
      list = await DBProvider.db.fetchEntries();
      assert(list.length>0);
      yield DatabaseAvailable(list);
    }catch(e) {
      print(e);
      yield DatabaseNotAvailable();
    }
  }
}
