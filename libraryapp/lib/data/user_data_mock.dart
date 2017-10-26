
import 'dart:async';
import 'user_data.dart';
import 'theme_names.dart';
class MockUserRepository implements UserRepository{
  // Mock data
  // TODO: (No user image yet!!)
  static List<User> kUsers = <User>[
    new User(
        name: "Alice Johnsson",
        occupation:"History Teacher",
        year:"1979",
      description:
      "A cheerful teacher who loves to read and work with children.",
      eventThemes: <EventTheme>[
        new EventTheme(ThemeNames.culture_edu),
        new EventTheme(ThemeNames.art_music),
        new EventTheme(ThemeNames.nature_society)
      ],
      id: "user_3"
    ),
    new User(
        name: "Ibrahim Syed",
        occupation:"Author/Writer",
        year:"1985",
        description:
       "Lorem ipsum dolor sit amet, consectetur adipisicing elit,"
           " sed do eiusmod tempor incididunt ut labore et dolore"
           " magna aliqua.",
        eventThemes: <EventTheme>[
          new EventTheme(ThemeNames.poetry_prose),
          new EventTheme(ThemeNames.language),
          new EventTheme(ThemeNames.apps_internet)
        ],
        id: "user_2"
    ),
    new User(
        name: "Will Gardiner",
        occupation:"Student",
        year:"1996",
        description:
        "Lorem ipsum dolor sit amet, consectetur adipisicing elit,"
            " sed do eiusmod tempor incididunt ut labore et dolore"
            " magna aliqua.",
        eventThemes: <EventTheme>[
          new EventTheme(ThemeNames.poetry_prose),
          new EventTheme(ThemeNames.language),
          new EventTheme(ThemeNames.apps_internet)
        ],
        id: "user_1"
    )
  ];

  Future<List<User>> fetch(){
    return new Future.value(kUsers);
  }
}