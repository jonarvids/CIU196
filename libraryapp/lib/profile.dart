import "package:flutter/material.dart";
import 'dart:io';
import 'data/theme_names.dart';
import './screens/edit_profile.dart' as edit_profile;
import 'package:shared_preferences/shared_preferences.dart';
import 'data/user_data.dart';

class Profile extends StatefulWidget{
  UserRepository user_repo;
  Profile(this.user_repo);

  @override
  ProfileState createState() => new ProfileState(user_repo);
}

class ProfileState extends State<Profile> {
  UserRepository user_repo;
  User person = new User(name: "",description: "", year:  "",occupation: "");
  bool artToggle = true,
      bookToggle = false,
      cultureToggle = true,
      poetryToggle = true,
      appsToggle = false,
      filmToggle = false,
      natureToggle = false,
      languageToggle = false;

  ProfileState(this.user_repo);

  //We don't use this right now since we want it to be demoable.
    _loadUser() async {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      person.name = prefs.getString(UserKey.name);
      person.description = prefs.getString(UserKey.description);
      person. occupation = prefs.getString(UserKey.occupation);
      person.year = prefs.getString(UserKey.year);
      person.imageFile = new File(prefs.getString(UserKey.imageFile));
      person.id = prefs.getString(UserKey.id);
      List<String> eventThemes = prefs.getStringList(UserKey.eventThemes);
      person.eventThemes = eventThemes;
      artToggle = person.eventThemes.contains(ThemeNames.art_music);
      bookToggle = person.eventThemes.contains(ThemeNames.book_circles);
      cultureToggle = person.eventThemes.contains(ThemeNames.culture_edu);
      poetryToggle = person.eventThemes.contains(ThemeNames.poetry_prose);
      appsToggle = person.eventThemes.contains(ThemeNames.apps_internet);
      filmToggle = person.eventThemes.contains(ThemeNames.film);
      natureToggle = person.eventThemes.contains(ThemeNames.nature_society);
      languageToggle = person.eventThemes.contains(ThemeNames.language);
     }

  @override
  void initState() {
    super.initState();
    //get the DEFAULT USER
    person = user_repo.getUsers()["user_default"];
    print(person.eventThemes[0]);
    updateInterests();
  }

  updateInterests() {
    artToggle = person.eventThemes.contains(ThemeNames.art_music);
    bookToggle = person.eventThemes.contains(ThemeNames.book_circles);
    cultureToggle = person.eventThemes.contains(ThemeNames.culture_edu);
    poetryToggle = person.eventThemes.contains(ThemeNames.poetry_prose);
    appsToggle = person.eventThemes.contains(ThemeNames.apps_internet);
    filmToggle = person.eventThemes.contains(ThemeNames.film);
    natureToggle = person.eventThemes.contains(ThemeNames.nature_society);
    languageToggle = person.eventThemes.contains(ThemeNames.language);
  }

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
                        new edit_profile.EditProfile(person),
                  ));
            },
          ),
        ]);
  }

  Widget buildBody(BuildContext context) {
    updateInterests();
    Widget pictureSection = new Container(
      margin: const EdgeInsets.only(top: 8.0, bottom: 8.0),
      child: new Column(
        children: <Widget>[
          new Container(
            child: new Center(
              child: new Column(
                children: [
                  new ClipOval(
                    child: person.imageFile == null
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
                                  person.imageFile,
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
                                  color: appsToggle
                                      ? Theme.of(context).primaryColor
                                      : Theme.of(context).disabledColor,
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
                                  color: bookToggle
                                      ? Theme.of(context).primaryColor
                                      : Theme.of(context).disabledColor,
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
                                  color: filmToggle
                                      ? Theme.of(context).primaryColor
                                      : Theme.of(context).disabledColor,
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
                                  color: cultureToggle
                                      ? Theme.of(context).primaryColor
                                      : Theme.of(context).disabledColor,
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
                                  color: natureToggle
                                      ? Theme.of(context).primaryColor
                                      : Theme.of(context).disabledColor,
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
                                  color: poetryToggle
                                      ? Theme.of(context).primaryColor
                                      : Theme.of(context).disabledColor,
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
                                  color: languageToggle
                                      ? Theme.of(context).primaryColor
                                      : Theme.of(context).disabledColor,
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
