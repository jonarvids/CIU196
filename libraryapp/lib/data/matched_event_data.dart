import 'dart:async';
import 'package:libraryapp/data/event_data.dart';
import 'package:libraryapp/data/user_data.dart';

class MatchedEventItem {
  EventItem match;
  List<User> matchedUsers;

  MatchedEventItem(EventItem match, List<User> matchedUsers) {
    this.match = match;
    this.matchedUsers = matchedUsers;
  }
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
