import 'dart:async';
import 'package:libraryapp/data/event_data.dart';
import 'package:libraryapp/data/user_data.dart';

class MatchedEventItem {
  final EventItem match;
  final List<User> matchedUsers;

  const MatchedEventItem({
    this.match,
    this.matchedUsers
  });
}

abstract class MatchedEventRepository {
  Future<List<MatchedEventItem>> fetch();
}

class FetchMatchedEventDataException implements Exception {
  String _message;

  FetchMatchedEventDataException(this._message);

  String toString() {
    return "Exception: $_message";
  }
}
