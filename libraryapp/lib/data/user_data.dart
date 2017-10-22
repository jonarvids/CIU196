import 'dart:async';

class User {
  final String name;
  final String occupation;
  final String year;
  final String description;
  final List<EventTheme> eventThemes;

  const User({
    this.name,
    this.occupation,
    this.year,
    this.description,
    this.eventThemes});
}

abstract class UserRepository {
  Future<List<User>> fetch();
}

class FetchDataException implements Exception {
  String _message;

  FetchDataException(this._message);

  String toString() {
    return "Exception: $_message";
  }
}

//MARK: Theme data (Only use predefined theme names).
class EventTheme {
  final String name;

  const EventTheme({
    this.name});

}