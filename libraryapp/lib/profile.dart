import "package:flutter/material.dart";
import 'dart:io';
import './screens/edit_profile.dart' as edit_profile;

class Profile extends StatelessWidget {
  ProfileData person = new ProfileData();
  File imageFile;
  bool artToggle = true,
      bookToggle = false,
      cultureToggle = true,
      poetryToggle = true,
      appsToggle = false,
      filmToggle = false,
      natureToggle = false,
      languageToggle = false;

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: buildAppBar(context),
      body: buildBody(context),
    );
  }

  Widget buildAppBar(BuildContext context) {
    return new AppBar(
        title: new Text("Profile"),
        centerTitle: true,
        actions: <Widget>[
          new IconButton(
            icon: new Icon(Icons.edit),
            onPressed: () {
              Navigator.of(context).push(new MaterialPageRoute<Null>(
                    builder: (BuildContext context) =>
                        new edit_profile.EditProfile(),
                  ));
            },
          ),
        ]);
  }

  Widget buildBody(BuildContext context) {
    Widget pictureSection = new Container(
      margin: const EdgeInsets.only(top: 8.0, bottom: 8.0),
      child: new Column(
        children: <Widget>[
          new Container(
            child: new Center(
              child: new Column(
                children: [
                  new ClipOval(
                    child: imageFile == null
                        ? new Container(
                            alignment: Alignment.center,
                            color: Theme.of(context).disabledColor,
                            width: 100.0,
                            height: 100.0,
                            child: new Text(
                              "No profile picture",
                              textAlign: TextAlign.center,
                              style: new TextStyle(
                                color: Colors.white,
                              ),
                            ),
                          )
                        : new Container(
                            alignment: Alignment.center,
                            width: 100.0,
                            height: 100.0,
                            decoration: new BoxDecoration(
                              image: new DecorationImage(
                                fit: BoxFit.cover,
                                image: new FileImage(
                                  imageFile,
                                  scale: 0.25,
                                ),
                              ),
                            ),
                          ),
                  ),
                  new Container(
                    margin: const EdgeInsets.only(top: 16.0),
                    child: new Text(
                      person.name,
                      style: new TextStyle(
                        color: Theme.of(context).primaryColor,
                        fontWeight: FontWeight.bold,
                        fontSize: 18.0,
                      ),
                    ),
                  ),
                  new Container(
                    child: new Text(
                      person.occupation,
                      style: new TextStyle(
                          color: Theme.of(context).primaryColor,
                          fontStyle: FontStyle.italic),
                    ),
                  ),
                  new Container(
                    child: new Text(
                      "Born " + person.year,
                      style: new TextStyle(
                          color: Theme.of(context).primaryColor,
                          fontStyle: FontStyle.italic),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );

    Widget textSection = new Container(
      child: new Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          new Container(
            margin: const EdgeInsets.only(top: 16.0, bottom: 16.0),
            child: new Text(
              "Description",
              textAlign: TextAlign.start,
              overflow: TextOverflow.ellipsis,
              style: new TextStyle(
                color: Theme.of(context).primaryColor,
              ),
            ),
          ),
          new Text(
            person.description,
            textAlign: TextAlign.start,
            style: new TextStyle(
              fontSize: 11.0,
            ),
          ),
        ],
      ),
    );

    Widget interestsSection = new Container(
      child: new Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          new Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              new Container(
                margin: const EdgeInsets.only(top: 16.0),
                child: new Text(
                  "Interests",
                  style: new TextStyle(color: Theme.of(context).primaryColor),
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
                                  color: artToggle
                                      ? Theme.of(context).primaryColor
                                      : Theme.of(context).disabledColor,
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
                                  color: appsToggle
                                      ? Theme.of(context).primaryColor
                                      : Theme.of(context).disabledColor,
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
                                  color: bookToggle
                                      ? Theme.of(context).primaryColor
                                      : Theme.of(context).disabledColor,
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
                                  color: filmToggle
                                      ? Theme.of(context).primaryColor
                                      : Theme.of(context).disabledColor,
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
                                  color: cultureToggle
                                      ? Theme.of(context).primaryColor
                                      : Theme.of(context).disabledColor,
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
                                  color: natureToggle
                                      ? Theme.of(context).primaryColor
                                      : Theme.of(context).disabledColor,
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
                                  color: poetryToggle
                                      ? Theme.of(context).primaryColor
                                      : Theme.of(context).disabledColor,
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
                                  color: languageToggle
                                      ? Theme.of(context).primaryColor
                                      : Theme.of(context).disabledColor,
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
            ],
          ),
        ],
      ),
    );

    return new ListView(
      padding: const EdgeInsets.all(16.0),
      children: [
        pictureSection,
        textSection,
        interestsSection,
      ],
    );
  }
}

class ProfileData {
  String name = "John Johnsson";
  String occupation = "Blacksmith";
  String year = "1901";
  String description =
      "Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.";
}
