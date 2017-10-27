import "package:flutter/material.dart";
import './screens/edit_profile.dart' as edit_profile;
import './data/user_data_mock.dart' as mockUser;
import './data/user_data.dart' as user;
import './data/theme_names.dart' as theme;

class Profile extends StatefulWidget {
  @override
  ProfileState createState() => new ProfileState();
}

class ProfileState extends State<Profile> {
  user.User person = mockUser.MockUserRepository.kUsers[0];

  @override
  void initState() {
    super.initState();
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
                    child: person.imagePath == ""
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
                                image: new AssetImage(
                                  person.imagePath,
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
                        fontSize: 16.0,
                      ),
                    ),
                  ),
                  new Container(
                    child: new Text(
                      person.occupation,
                      style: new TextStyle(
                          fontSize: 12.0,
                          color: Theme.of(context).primaryColor,
                          fontStyle: FontStyle.italic),
                    ),
                  ),
                  new Container(
                    child: new Text(
                      "Born " + person.year,
                      style: new TextStyle(
                          fontSize: 12.0,
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
                fontSize: 16.0,
              ),
            ),
          ),
          new Text(
            person.description,
            textAlign: TextAlign.start,
            style: new TextStyle(
              fontSize: 12.0,
            ),
          ),
        ],
      ),
    );

    Widget buildInterest(IconData icon, String theme) {
      return new Column(
        children: <Widget>[
          new Padding(
            padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
            child: new Icon(
              icon,
              size: 30.0,
              color: person.eventThemes.contains(theme)
                  ? Theme.of(context).primaryColor
                  : Theme.of(context).disabledColor,
            ),
          ),
          new Text(
            theme,
            style: new TextStyle(
              color: Colors.grey,
              fontSize: 11.0,
            ),
          ),
        ],
      );
    }

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
                  style: new TextStyle(
                    fontSize: 16.0,
                    color: Theme.of(context).primaryColor,
                  ),
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
                          child: buildInterest(
                            Icons.palette,
                            theme.ThemeNames.art_music,
                          ),
                        ),
                        new Container(
                          margin: const EdgeInsets.all(8.0),
                          child: buildInterest(
                            Icons.computer,
                            theme.ThemeNames.apps_internet,
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
                          child: buildInterest(
                            Icons.local_library,
                            theme.ThemeNames.book_circles,
                          ),
                        ),
                        new Container(
                          margin: const EdgeInsets.all(8.0),
                          child: buildInterest(
                            Icons.movie,
                            theme.ThemeNames.film,
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
                          child: buildInterest(
                            Icons.school,
                            theme.ThemeNames.culture_edu,
                          ),
                        ),
                        new Container(
                          margin: const EdgeInsets.all(8.0),
                          child: buildInterest(
                            Icons.nature_people,
                            theme.ThemeNames.nature_society,
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
                          child: buildInterest(
                            Icons.edit,
                            theme.ThemeNames.poetry_prose,
                          ),
                        ),
                        new Container(
                          margin: const EdgeInsets.all(8.0),
                          child: buildInterest(
                            Icons.language,
                            theme.ThemeNames.language,
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
