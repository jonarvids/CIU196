import "package:flutter/material.dart";
import './screens/create_event.dart' as create_event;
import 'package:collection/collection.dart' show lowerBound;
import 'data/user_data.dart';
import 'data/event_data.dart';
import 'data/theme_names.dart';
import "dart:io";
import "dart:math";

enum MatchesAction { reset, leftSwipe, rightSwipe, horizontal }

class Matches extends StatefulWidget {
  User user;
  EventRepository event_repo;

  Matches(this.user, this.event_repo);

  @override
  MatchesState createState() => new MatchesState(user, event_repo);
}

class MatchesState extends State<Matches> {
  User user;
  EventRepository event_repo;
  List<EventItem> eventItems = new List<EventItem>();
  List<RandomEventItem> randomEvents;
  DismissDirection dismissDirection = DismissDirection.horizontal;
  MatchesState(this.user, this.event_repo);


  @override
  initState() {
    super.initState();
    //initEventItems();
    findEvents();
  }

  void findEvents() {
    Set<String> themes = this.user.eventThemes;
    var events = event_repo.getEvents().values.iterator;
    while(events.moveNext()) {
      if (events.current.eventThemes.intersection(themes).length > 0) {
        eventItems.add(events.current);
      }
    }
  }

  void initEventItems() {
    randomEvents = new List<RandomEventItem>.generate(16, (int index) {
      return new RandomEventItem(
          index: index,
          title: "Title: $index",
          description:
              "Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.",
          imageFile: null);
    });
  }

@override
  void handleAction(MatchesAction action) {
    switch (action) {
      case MatchesAction.reset:
        findEvents();
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
        actions: <Widget>[
          new IconButton(
            icon: new Icon(Icons.add),
            tooltip: "Create Event",
            onPressed: () {
                 Navigator.of(context).push(new MaterialPageRoute<Null>(
                      builder: (BuildContext context) =>
                          new create_event.CreateEvent(),
                    ));
            })
        ]);
  }

  Widget buildItem(EventItem item) {
    ImageProvider image = null;
    if (item.userFile != null) {
      image = new FileImage(item.userFile);
    } else {
      image = new AssetImage(item.imageFile);
    }
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
                child: item.imageFile != null
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
                            image: image,
                          ),
                        ),
                      ),
              ),
              new Container(
                alignment: Alignment.centerLeft,
                margin: const EdgeInsets.all(16.0),
                child: new Text(
                  item.title,
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
                                            color: item.eventThemes.contains(ThemeNames.art_music)
                                                ? Theme.of(context).primaryColor
                                                : Theme
                                                    .of(context)
                                                    .disabledColor,
                                          ),
                                        ),
                                        new Text(
                                          ThemeNames.art_music,
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
                                            color: item.eventThemes.contains(ThemeNames.apps_internet)
                                                ? Theme.of(context).primaryColor
                                                : Theme
                                                    .of(context)
                                                    .disabledColor,
                                          ),
                                        ),
                                        new Text(
                                          ThemeNames.apps_internet,
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
                                            color:  item.eventThemes.contains(ThemeNames.book_circles)
                                                ? Theme.of(context).primaryColor
                                                : Theme
                                                    .of(context)
                                                    .disabledColor,
                                          ),
                                        ),
                                        new Text(
                                          ThemeNames.book_circles,
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
                                            color:  item.eventThemes.contains(ThemeNames.film_games)
                                                ? Theme.of(context).primaryColor
                                                : Theme
                                                    .of(context)
                                                    .disabledColor,
                                          ),
                                        ),
                                        new Text(
                                          ThemeNames.film_games,
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
                                            color:  item.eventThemes.contains(ThemeNames.culture_edu)
                                                ? Theme.of(context).primaryColor
                                                : Theme
                                                    .of(context)
                                                    .disabledColor,
                                          ),
                                        ),
                                        new Text(
                                          ThemeNames.culture_edu,
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
                                            color:  item.eventThemes.contains(ThemeNames.nature_society)
                                                ? Theme.of(context).primaryColor
                                                : Theme
                                                    .of(context)
                                                    .disabledColor,
                                          ),
                                        ),
                                        new Text(
                                          ThemeNames.nature_society,
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
                                            color:  item.eventThemes.contains(ThemeNames.poetry_prose)
                                                ? Theme.of(context).primaryColor
                                                : Theme
                                                    .of(context)
                                                    .disabledColor,
                                          ),
                                        ),
                                        new Text(
                                          ThemeNames.poetry_prose,
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
                                            color:  item.eventThemes.contains(ThemeNames.language)
                                                ? Theme.of(context).primaryColor
                                                : Theme
                                                    .of(context)
                                                    .disabledColor,
                                          ),
                                        ),
                                        new Text(
                                          ThemeNames.language,
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
                                color: const Color(0xFFFFA726),
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
                                color:const Color(0xff00E676)
                                ,
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

class RandomEventItem implements Comparable<RandomEventItem> {
  static var rand = new Random();


  RandomEventItem({this.index, this.title, this.description, this.imageFile});

  RandomEventItem.from(RandomEventItem item)
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
  int compareTo(RandomEventItem other) => index.compareTo(other.index);
}
