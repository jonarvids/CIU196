import 'package:flutter/material.dart';
import './profile.dart' as first;
import './matches.dart' as second;
import './events.dart' as third;
import 'package:shared_preferences/shared_preferences.dart';
import 'data/user_data.dart' as user;
import 'data/theme_names.dart' as themes;
import 'presenter/profile_presenter.dart' as profile;
import 'data/user_data_mock.dart';
import 'data/event_data_mock.dart';
import 'data/matched_event_mock.dart';

void main() {
  runApp(new MaterialApp(
    home: new Tabs(),
    theme: new ThemeData.light(),
  ));
}

class Tabs extends StatefulWidget {
  @override
  TabsState createState() => new TabsState();
}

class TabsState extends State<Tabs> with SingleTickerProviderStateMixin {
  TabController controller;
  Choice choice;
  MockUserRepository user_repo = new MockUserRepository();
  MockEventRepository event_repo = new MockEventRepository();
  MockMatchedEventRepository match_repo = new MockMatchedEventRepository();

  _saveUser() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String name = prefs.getString(user.UserKey.name);
    if (name == null || name == "") {
      prefs.setString(user.UserKey.name, "Jonas");
      prefs.setString(user.UserKey.year, "1994");
      prefs.setString(user.UserKey.description, "A cute horse with fluffy brown hair."
          " He loves to read and especially writing good code.");
      prefs.setString(user.UserKey.occupation, "Interaction design student");
      prefs.setString(user.UserKey.imageFile, "");
      prefs.setString(user.UserKey.id, "user_jonas");
      prefs.setStringList(user.UserKey.eventThemes, <String>[themes.ThemeNames.apps_internet,
          themes.ThemeNames.culture_edu,
          themes.ThemeNames.poetry_prose]);
    } else  {
      print("Default user not saved; already saved.");
      return;
    }
  }

  @override
  void initState() {
    super.initState();
    //_saveUser(); //We tried an easier solution since we don't care to save it to file.
    controller = new TabController(
      vsync: this,
      length: 3,
    );
    controller.addListener(select);
    choice = choices[controller.index];
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  void select() {
    setState(() {
      choice = choices[controller.index];
    });
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      bottomNavigationBar: new Material(
        color: Theme.of(context).primaryColor,
        child: new TabBar(
          controller: controller,
          tabs: <Tab>[
            new Tab(
              icon: new Icon(choices[0].icon),
              text: choices[0].title,
            ),
            new Tab(
              icon: new Icon(choices[1].icon),
              text: choices[1].title,
            ),
            new Tab(
              icon: new Icon(choices[2].icon),
              text: choices[2].title,
            ),
          ],
        ),
      ),
      body: new TabBarView(
        controller: controller,
        physics: new NeverScrollableScrollPhysics(),
        children: <Widget>[
          new first.Profile(user_repo),
          new second.Matches(user_repo, event_repo), //TODO: Uncomment + implement
          new third.Events(/*user_repo*/), //TODO: Uncomment + implement
        ],
      ),
    );
  }

  Widget buildBody(BuildContext context) {
    return new AppBar(
      centerTitle: true,
      title: new Text(
        choice.title,
      ),
      backgroundColor: Colors.green,
    );
  }
}

class Choice {
  const Choice({this.title, this.icon});
  final String title;
  final IconData icon;
}

const List<Choice> choices = const <Choice>[
  const Choice(
    title: 'Profile',
    icon: Icons.account_circle,
  ),
  const Choice(
    title: 'Match',
    icon: Icons.favorite,
  ),
  const Choice(
    title: 'Events',
    icon: Icons.calendar_today,
  ),
];
