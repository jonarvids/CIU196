import "package:flutter/material.dart";
import 'package:collection/collection.dart' show lowerBound;
import "dart:io";
import "dart:math";
import './data/event_data_mock.dart';
import './data/event_data.dart';
import './data/theme_names.dart';

enum MatchesAction { reset, leftSwipe, rightSwipe, horizontal }

class Matches extends StatefulWidget {
  @override
  MatchesState createState() => new MatchesState();
}

class MatchesState extends State<Matches> {
  var eventItems = MockEventRepository.kEvents;
  DismissDirection dismissDirection = DismissDirection.horizontal;

  @override
  initState() {
    super.initState();
  }

  void handleAction(MatchesAction action) {
    switch (action) {
      case MatchesAction.reset:
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
                child: item.imagePath == null
                    ? new Container(
                        alignment: Alignment.center,
                        color: Theme.of(context).disabledColor,
                        height: 175.0,
                      )
                    : new Container(
                        alignment: Alignment.center,
                        decoration: new BoxDecoration(
                          image: new DecorationImage(
                            fit: BoxFit.cover,
                            image: new AssetImage(
                              "images/Waving bear.jpg",
                            ),
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
                                            color: item.eventThemes.contains(
                                                    ThemeNames.art_music)
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
                                            color: item.eventThemes.contains(
                                                    ThemeNames.apps_internet)
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
                                            color: item.eventThemes.contains(
                                                    ThemeNames.book_circles)
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
                                            color: item.eventThemes
                                                    .contains(ThemeNames.film)
                                                ? Theme.of(context).primaryColor
                                                : Theme
                                                    .of(context)
                                                    .disabledColor,
                                          ),
                                        ),
                                        new Text(
                                          ThemeNames.film,
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
                                            color: item.eventThemes.contains(
                                                    ThemeNames.culture_edu)
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
                                            color: item.eventThemes.contains(
                                                    ThemeNames.nature_society)
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
                                            color: item.eventThemes.contains(
                                                    ThemeNames.poetry_prose)
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
                                            color: item.eventThemes.contains(
                                                    ThemeNames.language)
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
