import 'package:flutter/material.dart';
import './profile.dart' as first;
import './matches.dart' as second;
import './events.dart' as third;
import 'data/user_data.dart' as user;
import 'data/theme_names.dart' as themes;
import 'data/user_data_mock.dart';
import 'data/event_data_mock.dart';
import 'data/matched_event_mock.dart';

void main() {
  runApp(new MaterialApp(
    home: new Tabs(),
    theme: new ThemeData(
           primaryColor: const Color(0xFF00acc1),
           accentColor: const Color(0xFFFFEB3B),
        ),
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
      if (choice.title == "Match") {
      //TODO: Make Matches listen to this and update events.
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      bottomNavigationBar: new Material(
        color: Theme.of(context).primaryColor,
        child: new TabBar(
         // indicatorColor: Color(0xFF448AFF),
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
          new second.Matches(user_repo.getUsers()["user_default"], event_repo),
          new third.Events(event_repo,match_repo,user_repo), //TODO: Uncomment + implement
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
