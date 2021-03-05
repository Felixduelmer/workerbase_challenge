part of 'database_bloc.dart';

@immutable
abstract class DatabaseEvent extends Equatable {

    const DatabaseEvent();

}

class InitDb extends DatabaseEvent{
  @override
  List<Object> get props => [];

}

class QueryEntries extends DatabaseEvent{
    @override
    List<Object> get props => [];
}


class InsertEntry extends DatabaseEvent{
    final QREntry entry;

    InsertEntry(this.entry);

    @override
    List<Object> get props => [entry];

}

class DeleteEntry extends DatabaseEvent{
    final QREntry entry;
    const DeleteEntry({@required this.entry});
      @override
      List<Object> get props => [entry];

}
