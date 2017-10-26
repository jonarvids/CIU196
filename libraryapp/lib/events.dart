import "package:flutter/material.dart";
import 'data/event_data.dart';
import 'data/user_data.dart';
import 'data/matched_event_data.dart';
import './tabs/upcoming.dart' as first;
import './tabs/interested.dart' as second;
import './tabs/past.dart' as third;
import './tabs/created.dart' as fourth;
import './screens/create_event.dart' as create_event;

class Events extends StatefulWidget {
  EventRepository event_repo;
  MatchedEventRepository matched_event_repo;
  UserRepository user_repo;
  Events(this.event_repo, this.matched_event_repo, this.user_repo);

  @override
  TabsState createState() => new TabsState(event_repo,matched_event_repo,user_repo);
}

class TabsState extends State<Events> with SingleTickerProviderStateMixin {
  TabController controller;
  EventRepository event_repo;
  MatchedEventRepository matched_event_repo;
  UserRepository user_repo;
  User user;
  TabsState(this.event_repo, this.matched_event_repo, this.user_repo);

  @override
  void initState() {
    super.initState();
    controller = new TabController(vsync: this, length: 4);
    this.user = user_repo.getUsers()["user_default"];

  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(appBar: buildAppBar(context), body: buildBody(context));
  }

  Widget buildAppBar(BuildContext context) {
    return new AppBar(
        title: new Text("Events"),
        centerTitle: true,
        actions: <Widget>[
          new IconButton(
              icon: new Icon(Icons.add),
              onPressed: () {
                Navigator.of(context).push(new MaterialPageRoute<Null>(
                      builder: (BuildContext context) =>
                          new create_event.CreateEvent(),
                    ));
              })
        ],
        bottom: new TabBar(controller: controller, tabs: <Tab>[
          new Tab(text: "Upcoming"),
          new Tab(text: "Interested"),
          new Tab(text: "Past"),
          new Tab(text: "Created")
        ]));
  }

  Widget buildBody(BuildContext context) {
    return new TabBarView(controller: controller, children: <Widget>[
      new first.Upcoming(),
      new second.Interested(event_repo,matched_event_repo,user_repo),
      new third.Past(),
      new fourth.Created()
    ]);
  }
}
