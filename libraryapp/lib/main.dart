import 'package:flutter/material.dart';
import './profile.dart' as first;
import './matches.dart' as second;
import './events.dart' as third;
import './edit_profile.dart' as edit_profile;
import './create_event.dart' as create_event;

void main() {
  runApp(new MaterialApp(home: new Tabs()));
}

class Tabs extends StatefulWidget {
  @override
  TabsState createState() => new TabsState();
}

class TabsState extends State<Tabs> with SingleTickerProviderStateMixin {
  TabController controller;
  Choice choice;

  @override
  void initState() {
    super.initState();
    controller = new TabController(vsync: this, length: 3);
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
        appBar: buildBody(context),
        bottomNavigationBar: new Material(
            color: Colors.green,
            child: new TabBar(controller: controller, tabs: <Tab>[
              new Tab(icon: new Icon(choices[0].icon), text: choices[0].title),
              new Tab(icon: new Icon(choices[1].icon), text: choices[1].title),
              new Tab(icon: new Icon(choices[2].icon), text: choices[2].title)
            ])),
        body: new TabBarView(controller: controller, physics: new NeverScrollableScrollPhysics(), children: <Widget>[
          new first.Profile(),
          new second.Matches(),
          new third.Events()
        ]));
  }

  Widget buildBody(BuildContext context) {
    return new AppBar(
      centerTitle: true,
      title: new Text(
        choice.title,
      ),
      backgroundColor: Colors.green,
      actions: <Widget>[
        new IconButton(
            icon: new Icon(Icons.edit),
            onPressed: () {
              Navigator.of(context).push(new MaterialPageRoute<Null>(
                    builder: (BuildContext context) =>
                        new edit_profile.EditProfile(),
                  ));
            }),
        new IconButton(
            icon: new Icon(Icons.add),
            onPressed: () {
              Navigator.of(context).push(new MaterialPageRoute<Null>(
                    builder: (BuildContext context) =>
                        new create_event.CreateEvent(),
                  ));
            }),
      ],
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
  const Choice(title: 'Match', icon: Icons.favorite),
  const Choice(title: 'Events', icon: Icons.calendar_today),
];
