import 'dart:async';

class User {
  String name;
  String occupation;
  String year;
  String description;
  String imagePath;
  List<String> eventThemes;
  String id; //Used mainly to associate with events.

  User(String name, String occupation, String year, String description,
      String imagePath, List<String> eventThemes, String id) {
    this.name = name;
    this.occupation = occupation;
    this.year = year;
    this.description = description;
    this.imagePath = imagePath;
    this.eventThemes = eventThemes;
    this.id = id;
  }
}

abstract class UserRepository {
  Future<List<User>> fetch();
}

class FetchUserDataException implements Exception {
  String _message;

  FetchUserDataException(this._message);

  String toString() {
    return "Exception: $_message";
  }
}

//MARK: Theme data (Only use predefined theme names).
class EventTheme {
  String name;

  EventTheme(String name) {
    this.name = name;
  }
}
