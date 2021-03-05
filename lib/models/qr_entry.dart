
class QREntry {
  final String uri;
  final int insertionTime;

  QREntry({this.uri, this.insertionTime});

  Map<String, dynamic> toMap() {
    return {
      'uri': uri,
      'insertionTime': insertionTime,
    };
  }

  // Implement toString to make it easier to see information about
  // each dog when using the print statement.
  @override
  String toString() {
    return 'QREntry{uri: $uri, insertionTime: $insertionTime}';
  }
}