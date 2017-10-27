import 'dart:async';
import 'user_data.dart';
import 'theme_names.dart';

class MockUserRepository implements UserRepository {
  // Mock data
  // TODO: (No user image yet!!)
  static var kUsers = <User>[
    new User(
        "Alice Johnsson",
        "History Teacher",
        "1979",
        "Lorem ipsum dolor sit amet, consectetur adipisicing elit,"
        " sed do eiusmod tempor incididunt ut labore et dolore"
        " magna aliqua. Ut enim ad minim veniam, quis nostrud "
        "exercitation ullamco laboris nisi ut aliquip ex ea "
        "commodo consequat. ",
        "images/jonte.jpg",
        <String>[
          ThemeNames.culture_edu,
          ThemeNames.art_music,
          ThemeNames.nature_society
        ],
        "user_3"),
    new User(
        "Ibrahim Syed",
        "Author/Writer",
        "1985",
        "Lorem ipsum dolor sit amet, consectetur adipisicing elit,"
        " sed do eiusmod tempor incididunt ut labore et dolore"
        " magna aliqua. Ut enim ad minim veniam, quis nostrud "
        "exercitation ullamco laboris nisi ut aliquip ex ea "
        "commodo consequat. Duis aute irure dolor in"
        " reprehenderit in voluptate velit esse cillum dolore"
        " eu fugiat nulla pariatur.",
        "images/glMtb0Z.png",
        <String>[
          ThemeNames.poetry_prose,
          ThemeNames.language,
          ThemeNames.apps_internet,
          ThemeNames.book_circles
        ],
        "user_2"),
    new User(
        "Will Gardiner",
        "Student",
        "1996",
        "Lorem ipsum dolor sit amet, consectetur adipisicing elit,"
        " sed do eiusmod tempor incididunt ut labore et dolore"
        " magna aliqua.",
        "images/Waving bear.jpg",
        <String>[
          ThemeNames.film,
          ThemeNames.apps_internet,
          ThemeNames.art_music,
        ],
        "user_1")
  ];

  Future<List<User>> fetch() {
    return new Future.value(kUsers);
  }
}
