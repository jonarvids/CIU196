import 'dart:async';
import 'dart:io';

class User {
  final String name;
  final String occupation;
  final String year;
  final String description;
  final File imageFile;
  final List<EventTheme> eventThemes;
  final String id; //Used mainly to associate with events.

  const User({
    this.name,
    this.imageFile,
    this.occupation,
    this.year,
    this.description,
    this.eventThemes,
    this.id});
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
  final String name;

  const EventTheme({
    this.name});

}