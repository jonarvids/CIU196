import "package:flutter/material.dart";
import '../data/event_data.dart';
import '../data/user_data.dart';
import '../data/matched_event_data.dart';

class Interested extends StatelessWidget {
  TabController controller;
  EventRepository event_repo;
  MatchedEventRepository matched_event_repo;
  UserRepository user_repo;
  User user;
  Interested(this.event_repo, this.matched_event_repo, this.user_repo);

  @override
  Widget build(BuildContext context) {
    return new Container(
      child: new Center(
        child: new Text("INTERESTED"),
      ),
    );
  }
}
