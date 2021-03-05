part of 'database_bloc.dart';

@immutable
abstract class DatabaseState {
}

class DatabaseFailed extends DatabaseState {}

class DatabaseNotAvailable extends DatabaseState {}

class DatabaseEmpty extends DatabaseState{}

class DatabaseAvailable extends DatabaseState{
  final List<QREntry> entries;
  DatabaseAvailable(this.entries);

  @override
  List<Object> get props {
    return [entries];
  }
}
