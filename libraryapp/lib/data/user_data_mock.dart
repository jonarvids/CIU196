
import 'dart:async';
import 'dart:collection';
import 'user_data.dart';
import 'theme_names.dart';
class MockUserRepository implements UserRepository{
  // Mock data
  // TODO: (No user image yet!!)
  Map _kUsers = new HashMap<String, User>();

  MockUserRepository() {
    User _a = new User(
        name: "Alice Johnsson",
        occupation:"History Teacher",
        year:"1979",
        description:
        "A cheerful teacher who loves to read and work with children.",
        eventThemes: <String>[
          ThemeNames.culture_edu,
          ThemeNames.art_music,
          ThemeNames.nature_society
        ],
        id: "user_3");
    User _b = new User(
        name: "Ibrahim Syed",
        occupation:"Author/Writer",
        year:"1985",
        description:
        "Lorem ipsum dolor sit amet, consectetur adipisicing elit,"
            " sed do eiusmod tempor incididunt ut labore et dolore"
            " magna aliqua.",
        eventThemes: <String>[
          ThemeNames.poetry_prose,
          ThemeNames.language,
          ThemeNames.apps_internet
        ],
        id: "user_2"
    );
    User _c = new User(
        name: "Will Gardiner",
        occupation:"Student",
        year:"1996",
        description:
        "Lorem ipsum dolor sit amet, consectetur adipisicing elit,"
            " sed do eiusmod tempor incididunt ut labore et dolore"
            " magna aliqua.",
        eventThemes: <String>[
          ThemeNames.poetry_prose,
          ThemeNames.language,
          ThemeNames.apps_internet
        ],
        id: "user_default");
    _kUsers.putIfAbsent(_a.id, ()=> _a);
    _kUsers.putIfAbsent(_b.id, ()=> _b);
    _kUsers.putIfAbsent(_c.id, ()=> _c);
  }


  @override
  void addUser(User user) {
    _kUsers.putIfAbsent(user.id, ()=> user);
  }

  @override
  Map<String, User> getUsers() {
    return _kUsers;
  }
}