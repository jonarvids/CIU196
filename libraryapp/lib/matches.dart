import "package:flutter/material.dart";
import 'package:collection/collection.dart' show lowerBound;
import 'package:libraryapp/data/event_data.dart';
import 'package:libraryapp/data/user_data.dart';
import "dart:io";
import "dart:math";
import 'data/user_data_mock.dart';
import 'data/event_data_mock.dart';

enum MatchesAction { reset, leftSwipe, rightSwipe, horizontal }

class Matches extends StatefulWidget {
  UserRepository user_repo;
  EventRepository event_repo;

  Matches(this.user_repo, this.event_repo);

  @override
  MatchesState createState() => new MatchesState(user_repo, event_repo);
}

class EventItem implements Comparable<EventItem> {
  static var rand = new Random();


  EventItem({this.index, this.title, this.description, this.imageFile});

  EventItem.from(EventItem item)
      : index = item.index,
        title = item.title,
        description = item.description,
        imageFile = item.imageFile;

  final int index;
  final String title;
  final String description;
  final File imageFile;

  bool artToggle = rand.nextBool(),
      bookToggle = rand.nextBool(),
      cultureToggle = rand.nextBool(),
      poetryToggle = rand.nextBool(),
      appsToggle = rand.nextBool(),
      filmToggle = rand.nextBool(),
      natureToggle = rand.nextBool(),
      languageToggle = rand.nextBool();

  @override
  int compareTo(EventItem other) => index.compareTo(other.index);
}

class MatchesState extends State<Matches> {
  UserRepository user_repo;
  EventRepository event_repo;
  List<EventItem> eventItems;
  DismissDirection dismissDirection = DismissDirection.horizontal;
  MatchesState(this.user_repo, this.event_repo);

  @override
  initState() {
    super.initState();
    initEventItems();
  }

  void initEventItems() {
    eventItems = new List<EventItem>.generate(16, (int index) {
      return new EventItem(
          index: index,
          title: "Title: $index",
          description:
              "Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.",
          imageFile: null);
    });
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

  void handleUndo(EventItem item) {
    final int insertionIndex = lowerBound(eventItems, item);
    setState(() {
      eventItems.insert(insertionIndex, item);
    });
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: buildAppBar(context),
        body: new ListView(
          children: eventItems.map(buildItem).toList(),
          physics: new NeverScrollableScrollPhysics(),
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
            ? "Not interested"
            : "Interested";
        Scaffold.of(context).showSnackBar(new SnackBar(
              content: new Text("$action"),
              action: new SnackBarAction(
                label: "UNDO",
                onPressed: () {
                  handleUndo(item);
                },
              ),
            ));
      },
      child: new Padding(
        padding: const EdgeInsets.all(16.0),
        child: new Card(
          child: new Column(
            children: [
              new ClipRect(
                child: item.imageFile == null
                    ? new Container(
                        alignment: Alignment.center,
                        color: Theme.of(context).disabledColor,
                        height: 150.0,
                      )
                    : new Container(
                        alignment: Alignment.center,
                        decoration: new BoxDecoration(
                          image: new DecorationImage(
                            fit: BoxFit.cover,
                            image: new FileImage(
                              item.imageFile,
                            ),
                          ),
                        ),
                      ),
              ),
              new Container(
                alignment: Alignment.centerLeft,
                margin: const EdgeInsets.all(16.0),
                child: new Text(
                  "Event Title ${item.index}",
                  textAlign: TextAlign.start,
                  style: new TextStyle(
                    fontSize: 24.0,
                    color: Theme.of(context).primaryColor,
                  ),
                ),
              ),
              new Container(
                child: new Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    new Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        new Container(
                          margin: const EdgeInsets.only(
                            left: 16.0,
                            right: 16.0,
                          ),
                          child: new Text(
                            item.description,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        new Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            new Center(
                              child: new Column(
                                children: [
                                  new Container(
                                    margin: const EdgeInsets.all(8.0),
                                    child: new Column(
                                      children: <Widget>[
                                        new Padding(
                                          padding: const EdgeInsets.only(
                                              top: 8.0, bottom: 8.0),
                                          child: new Icon(
                                            Icons.palette,
                                            size: 30.0,
                                            color: item.artToggle
                                                ? Theme.of(context).primaryColor
                                                : Theme
                                                    .of(context)
                                                    .disabledColor,
                                          ),
                                        ),
                                        new Text(
                                          "Art & Music",
                                          style: new TextStyle(
                                            color: Colors.grey,
                                            fontSize: 11.0,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  new Container(
                                    margin: const EdgeInsets.all(8.0),
                                    child: new Column(
                                      children: <Widget>[
                                        new Padding(
                                          padding: const EdgeInsets.only(
                                              top: 8.0, bottom: 8.0),
                                          child: new Icon(
                                            Icons.computer,
                                            size: 30.0,
                                            color: item.appsToggle
                                                ? Theme.of(context).primaryColor
                                                : Theme
                                                    .of(context)
                                                    .disabledColor,
                                          ),
                                        ),
                                        new Text(
                                          "Apps & Internet",
                                          style: new TextStyle(
                                            color: Colors.grey,
                                            fontSize: 11.0,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            new Center(
                              child: new Column(
                                children: [
                                  new Container(
                                    margin: const EdgeInsets.all(8.0),
                                    child: new Column(
                                      children: <Widget>[
                                        new Padding(
                                          padding: const EdgeInsets.only(
                                              top: 8.0, bottom: 8.0),
                                          child: new Icon(
                                            Icons.local_library,
                                            size: 30.0,
                                            color: item.bookToggle
                                                ? Theme.of(context).primaryColor
                                                : Theme
                                                    .of(context)
                                                    .disabledColor,
                                          ),
                                        ),
                                        new Text(
                                          "Book circles",
                                          style: new TextStyle(
                                            color: Colors.grey,
                                            fontSize: 11.0,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  new Container(
                                    margin: const EdgeInsets.all(8.0),
                                    child: new Column(
                                      children: <Widget>[
                                        new Padding(
                                          padding: const EdgeInsets.only(
                                              top: 8.0, bottom: 8.0),
                                          child: new Icon(
                                            Icons.movie,
                                            size: 30.0,
                                            color: item.filmToggle
                                                ? Theme.of(context).primaryColor
                                                : Theme
                                                    .of(context)
                                                    .disabledColor,
                                          ),
                                        ),
                                        new Text(
                                          "Film",
                                          style: new TextStyle(
                                            color: Colors.grey,
                                            fontSize: 11.0,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            new Center(
                              child: new Column(
                                children: [
                                  new Container(
                                    margin: const EdgeInsets.all(8.0),
                                    child: new Column(
                                      children: <Widget>[
                                        new Padding(
                                          padding: const EdgeInsets.only(
                                              top: 8.0, bottom: 8.0),
                                          child: new Icon(
                                            Icons.school,
                                            size: 30.0,
                                            color: item.cultureToggle
                                                ? Theme.of(context).primaryColor
                                                : Theme
                                                    .of(context)
                                                    .disabledColor,
                                          ),
                                        ),
                                        new Text(
                                          "Culture & Education",
                                          style: new TextStyle(
                                            color: Colors.grey,
                                            fontSize: 11.0,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  new Container(
                                    margin: const EdgeInsets.all(8.0),
                                    child: new Column(
                                      children: <Widget>[
                                        new Padding(
                                          padding: const EdgeInsets.only(
                                              top: 8.0, bottom: 8.0),
                                          child: new Icon(
                                            Icons.nature_people,
                                            size: 30.0,
                                            color: item.natureToggle
                                                ? Theme.of(context).primaryColor
                                                : Theme
                                                    .of(context)
                                                    .disabledColor,
                                          ),
                                        ),
                                        new Text(
                                          "Nature & Society",
                                          style: new TextStyle(
                                            color: Colors.grey,
                                            fontSize: 11.0,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            new Center(
                              child: new Column(
                                children: [
                                  new Container(
                                    margin: const EdgeInsets.all(8.0),
                                    child: new Column(
                                      children: <Widget>[
                                        new Padding(
                                          padding: const EdgeInsets.only(
                                              top: 8.0, bottom: 8.0),
                                          child: new Icon(
                                            Icons.edit,
                                            size: 30.0,
                                            color: item.poetryToggle
                                                ? Theme.of(context).primaryColor
                                                : Theme
                                                    .of(context)
                                                    .disabledColor,
                                          ),
                                        ),
                                        new Text(
                                          "Poetry & Prose",
                                          style: new TextStyle(
                                            color: Colors.grey,
                                            fontSize: 11.0,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  new Container(
                                    margin: const EdgeInsets.all(8.0),
                                    child: new Column(
                                      children: <Widget>[
                                        new Padding(
                                          padding: const EdgeInsets.only(
                                              top: 8.0, bottom: 8.0),
                                          child: new Icon(
                                            Icons.language,
                                            size: 30.0,
                                            color: item.languageToggle
                                                ? Theme.of(context).primaryColor
                                                : Theme
                                                    .of(context)
                                                    .disabledColor,
                                          ),
                                        ),
                                        new Text(
                                          "Laguage",
                                          style: new TextStyle(
                                            color: Colors.grey,
                                            fontSize: 11.0,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        new Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            new Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: new FlatButton(
                                child: new Icon(
                                  Icons.block,
                                  color: Colors.white,
                                ),
                                color: Colors.red,
                                onPressed: () {
                                  setState(() {
                                    eventItems.remove(item);
                                  });
                                  Scaffold
                                      .of(context)
                                      .showSnackBar(new SnackBar(
                                        content: new Text("Not interested"),
                                        action: new SnackBarAction(
                                          label: "UNDO",
                                          onPressed: () {
                                            handleUndo(item);
                                          },
                                        ),
                                      ));
                                },
                              ),
                            ),
                            new Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: new IconButton(
                                icon: new Icon(
                                  Icons.info,
                                  color: Theme.of(context).primaryColor,
                                ),
                                iconSize: 35.0,
                                onPressed: () {
                                  setState(() {
                                    eventItems.remove(item);
                                  });
                                  Scaffold
                                      .of(context)
                                      .showSnackBar(new SnackBar(
                                        content: new Text("INFO ABOUT EVENT"),
                                      ));
                                },
                              ),
                            ),
                            new Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: new FlatButton(
                                child: new Icon(
                                  Icons.check,
                                  color: Colors.white,
                                ),
                                color: Colors.green,
                                onPressed: () {
                                  setState(() {
                                    eventItems.remove(item);
                                  });
                                  Scaffold
                                      .of(context)
                                      .showSnackBar(new SnackBar(
                                        content: new Text("Interested"),
                                        action: new SnackBarAction(
                                          label: "UNDO",
                                          onPressed: () {
                                            handleUndo(item);
                                          },
                                        ),
                                      ));
                                },
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
