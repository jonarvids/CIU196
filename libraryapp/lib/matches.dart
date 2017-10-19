import "package:flutter/material.dart";

enum MatchesAction { reset, leftSwipe, rightSwipe, horizontal }

class Matches extends StatefulWidget {
  @override
  MatchesState createState() => new MatchesState();
}

class EventItem implements Comparable<EventItem> {
  EventItem({this.index, this.name, this.subject, this.body});

  EventItem.from(EventItem item)
      : index = item.index,
        name = item.name,
        subject = item.subject,
        body = item.body;

  final int index;
  final String name;
  final String subject;
  final String body;

  @override
  int compareTo(EventItem other) => index.compareTo(other.index);
}

class MatchesState extends State<Matches> {
  List<EventItem> eventItems;
  DismissDirection dismissDirection = DismissDirection.horizontal;

  void initEventItems() {
    eventItems = new List<EventItem>.generate(16, (int index) {
      return new EventItem(
          index: index,
          name: "Event $index",
          subject: "Subject: $index",
          body: "The body of event [$index]...");
    });
  }

  @override
  initState() {
    super.initState();
    initEventItems();
  }

  void handleAction(MatchesAction action) {
    switch (action) {
      case MatchesAction.reset:
        initEventItems();
        break;
      case MatchesAction.leftSwipe:
        dismissDirection = DismissDirection.endToStart;
        break;
      case MatchesAction.rightSwipe:
        dismissDirection = DismissDirection.startToEnd;
        break;
      case MatchesAction.horizontal:
        dismissDirection = DismissDirection.horizontal;
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: buildAppBar(context),
        body: new ListView(
          children: eventItems.map(buildItem).toList(),
        ));
  }

  Widget buildAppBar(BuildContext context) {
    return new AppBar(
      title: new Text("Matches"),
      centerTitle: true,
    );
  }

  Widget buildItem(EventItem item) {
    return new Dismissible(
      key: new ObjectKey(item),
      direction: dismissDirection,
      onDismissed: (DismissDirection direction) {
        setState(() {
          eventItems.remove(item);
        });
        final String action = (direction == DismissDirection.endToStart)
            ? "Accepted"
            : "Not interested";
        Scaffold.of(context).showSnackBar(new SnackBar(
          content: new Text("$action"),
        ));
      },
      child: new Padding(
        padding: const EdgeInsets.all(16.0),
        child: new Card(
          color: Colors.white,
          child: new Center(
            child: new Column(
              children: [
                new Text(item.name),
                new Text(item.subject),
                new Text(item.body),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget buildBody(BuildContext context) {
    return new Padding(
      padding: const EdgeInsets.all(16.0),
      child: new Dismissible(
        key: new ObjectKey("yo"),
        child: new Card(
          color: Colors.white,
          child: new Center(
            child: new Text("MATCH BODY"),
          ),
        ),
        onDismissed: (DismissDirection direction) {
          setState(() {});
        },
      ),
    );
  }
}
