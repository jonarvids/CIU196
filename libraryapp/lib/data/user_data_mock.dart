import 'dart:collection';
import 'user_data.dart';
import 'theme_names.dart';
class MockUserRepository implements UserRepository{
  // Mock data
  // TODO: (No user image yet!!)
  Map _kUsers = new HashMap<String, User>();

  MockUserRepository() {
    var eventThemesa= new HashSet<String>();
    eventThemesa.add(ThemeNames.language);
    eventThemesa.add(ThemeNames.poetry_prose);
    User _a = new User(
        name: "Alice Johnsson",
        occupation:"History Teacher",
        year:"1979",
        description:
        "A cheerful teacher who loves to read and work with children.",
        eventThemes: eventThemesa,
        id: "user_3");

    var eventThemesb= new HashSet<String>();
    eventThemesb.add(ThemeNames.language);
    eventThemesb.add(ThemeNames.culture_edu);
    User _b = new User(
        name: "Ibrahim Syed",
        occupation:"Author/Writer",
        year:"1985",
        description:
        "Lorem ipsum dolor sit amet, consectetur adipisicing elit,"
            " sed do eiusmod tempor incididunt ut labore et dolore"
            " magna aliqua.",
        eventThemes: eventThemesb,
        id: "user_2"
    );

    var eventThemesc= new HashSet<String>();
    eventThemesc.add(ThemeNames.language);
    eventThemesc.add(ThemeNames.culture_edu);
    User _c = new User(
        name: "Will Gardiner",
        occupation:"Student",
        year:"1996",
        description:
        "Lorem ipsum dolor sit amet, consectetur adipisicing elit,"
            " sed do eiusmod tempor incididunt ut labore et dolore"
            " magna aliqua.",
        eventThemes:eventThemesc,
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