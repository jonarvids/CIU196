import 'dart:async';
import 'dart:io';
import 'package:quiver/core.dart';

class UserKey {
  static final String name = "name";
  static final String occupation = "occupation";
  static final String year = "year";
  static final String description = "description";
  static final String imageFile = "imageFile";
  static final String eventThemes = "eventThemes";
  static final String id = "id"; //Used mainly to associate with events.
}

class User {
  String name;
  String occupation;
  String year;
  String description;
  File imageFile;
  List<String> eventThemes;
  String id; //Used mainly to associate with events.

  User({
    this.name,
    this.imageFile,
    this.occupation,
    this.year,
    this.description,
    this.eventThemes,
    this.id});

  @override
  bool operator == (o) => o is User && o.id == id;
  @override
  int get hashCode => hash2(name.hashCode, year.hashCode);

}



abstract class UserRepository {
  Map<String, User> getUsers();
  void addUser(User user);
}

class FetchUserDataException implements Exception {
  String _message;

  FetchUserDataException(this._message);

  String toString() {
    return "Exception: $_message";
  }
}

//MARK: Theme data (Only use predefined theme names).
