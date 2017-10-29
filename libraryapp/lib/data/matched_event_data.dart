import 'dart:async';
import 'package:libraryapp/data/event_data.dart';
import 'package:libraryapp/data/user_data.dart';
import 'package:quiver/core.dart';

class MatchedEventItem {
  EventItem match;
  List<User> matchedUsers;
  String id;
  MatchedEventItem({
    this.match,
    this.matchedUsers,
    this.id
  });

  @override
  bool operator == (o) => o is MatchedEventItem && o.id == id;
  @override
  int get hashCode => hash2(match.hashCode, matchedUsers.hashCode);
}

abstract class MatchedEventRepository {
  Map<String, MatchedEventItem> getMatchedEvents();
  void addEvent(MatchedEventItem event);
}

class FetchMatchedEventDataException implements Exception {
  String _message;

  FetchMatchedEventDataException(this._message);

  String toString() {
    return "Exception: $_message";
  }
}
