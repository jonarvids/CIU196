
import 'dart:async';
import 'user_data.dart';
import 'theme_names.dart';

class MockUserRepository implements UserRepository{
  // Mock data
  static const kUsers = const <User>[
    const User(name:"Alice Johnsson",
        occupation:"History Teacher",
        year:"1979",
        description:
        "Lorem ipsum dolor sit amet, consectetur adipisicing elit,"
            " sed do eiusmod tempor incididunt ut labore et dolore"
            " magna aliqua. Ut enim ad minim veniam, quis nostrud "
            "exercitation ullamco laboris nisi ut aliquip ex ea "
            "commodo consequat. ",
        eventThemes: const <EventTheme>[
          const EventTheme(name: ThemeNames.culture_edu),
          const EventTheme(name: ThemeNames.art_music),
          const EventTheme(name: ThemeNames.nature_society)]
    ),
    const User(name:"Ibrahim Syed",
        occupation:"Author/Writer",
        year:"1985",
        description:
        "Lorem ipsum dolor sit amet, consectetur adipisicing elit,"
            " sed do eiusmod tempor incididunt ut labore et dolore"
            " magna aliqua. Ut enim ad minim veniam, quis nostrud "
            "exercitation ullamco laboris nisi ut aliquip ex ea "
            "commodo consequat. Duis aute irure dolor in"
            " reprehenderit in voluptate velit esse cillum dolore"
            " eu fugiat nulla pariatur.",
        eventThemes: const <EventTheme>[
          const EventTheme(name: ThemeNames.poetry_prose),
          const EventTheme(name: ThemeNames.language),
          const EventTheme(name: ThemeNames.apps_internet),
          const EventTheme(name: ThemeNames.book_circles)]
    ),
    const User(name:"Will Gardiner",
        occupation:"Student",
        year:"1996",
        description:
        "Lorem ipsum dolor sit amet, consectetur adipisicing elit,"
            " sed do eiusmod tempor incididunt ut labore et dolore"
            " magna aliqua.",
        eventThemes: const <EventTheme>[
          const EventTheme(name: ThemeNames.film),
          const EventTheme(name: ThemeNames.apps_internet),
          const EventTheme(name: ThemeNames.art_music),
        ]
    )
  ];

  Future<List<User>> fetch(){
    return new Future.value(kUsers);
  }

}

