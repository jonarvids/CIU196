import "package:flutter/material.dart";
import 'dart:async';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/services.dart';
import '../data/user_data_mock.dart' as mockUser;
import '../data/user_data.dart' as user;
import '../data/theme_names.dart' as theme;

class EditProfile extends StatefulWidget {
  @override
  EditProfileState createState() => new EditProfileState();
}

class EditProfileState extends State<EditProfile> {
  final GlobalKey<ScaffoldState> scaffoldKey = new GlobalKey<ScaffoldState>();
  user.User person = mockUser.MockUserRepository.kUsers[0];
  File imageFile;
  bool formWasEdited = false, autoValidate = false;
  final GlobalKey<FormState> formKey = new GlobalKey<FormState>();
  final TextEditingController nameController = new TextEditingController();
  final TextEditingController occupationController =
      new TextEditingController();
  final TextEditingController ageController = new TextEditingController();

  bool artToggle = false,
      bookToggle = false,
      cultureToggle = false,
      poetryToggle = false,
      appsToggle = false,
      filmToggle = false,
      natureToggle = false,
      languageToggle = false;

  void checkUserThemes() {
    for (int i = 0; i < person.eventThemes.length; i++) {
      var currentTheme = person.eventThemes[i];

      switch (currentTheme) {
        case theme.ThemeNames.apps_internet:
          appsToggle = true;
          break;
        case theme.ThemeNames.art_music:
          artToggle = true;
          break;
        case theme.ThemeNames.book_circles:
          bookToggle = true;
          break;
        case theme.ThemeNames.culture_edu:
          cultureToggle = true;
          break;
        case theme.ThemeNames.film:
          filmToggle = true;
          break;
        case theme.ThemeNames.language:
          languageToggle = true;
          break;
        case theme.ThemeNames.nature_society:
          natureToggle = true;
          break;
        case theme.ThemeNames.poetry_prose:
          poetryToggle = true;
          break;
        default:
          break;
      }
    }
  }

  void showInSnackBar(BuildContext context, String value) {
    scaffoldKey.currentState
        .showSnackBar(new SnackBar(content: new Text(value)));
  }

  getImage() async {
    var fileName = await ImagePicker.pickImage();
    setState(() {
      imageFile = fileName;
    });
  }

  void handleSubmittedData() {
    final FormState form = formKey.currentState;
    if (!form.validate()) {
      autoValidate = true;
      showInSnackBar(context,
          "Could not update profile. Fix errors in red and try again.");
    } else if (!(artToggle ||
        bookToggle ||
        cultureToggle ||
        poetryToggle ||
        appsToggle ||
        filmToggle ||
        natureToggle ||
        languageToggle)) {
      showInSnackBar(context, "At least one interest is required");
    } else {
      showInSnackBar(context, "Profile updated");
      form.save();
      var userThemes = <String>[];
      if (artToggle) {
        userThemes.add(theme.ThemeNames.art_music);
      }
      if (bookToggle) {
        userThemes.add(theme.ThemeNames.book_circles);
      }
      if (cultureToggle) {
        userThemes.add(theme.ThemeNames.culture_edu);
      }
      if (poetryToggle) {
        userThemes.add(theme.ThemeNames.poetry_prose);
      }
      if (appsToggle) {
        userThemes.add(theme.ThemeNames.apps_internet);
      }
      if (filmToggle) {
        userThemes.add(theme.ThemeNames.film);
      }
      if (natureToggle) {
        userThemes.add(theme.ThemeNames.nature_society);
      }
      if (languageToggle) {
        userThemes.add(theme.ThemeNames.language);
      }
      print(userThemes);
      person.eventThemes = userThemes;
      // TODO: Save/upload data
    }
  }

  String validateName(String value) {
    if (value.isEmpty) {
      return "Error: Name is required";
    }
    final RegExp nameExp = new RegExp(r'^[A-Öa-ö ]+$');
    if (!nameExp.hasMatch(value)) {
      return "Error: Use only alpabethical characters";
    }
    return null;
  }

  String validateOccupation(String value) {
    if (value.isEmpty) {
      return "Error: Occupation is required";
    }
    final RegExp nameExp = new RegExp(r'^[A-Öa-ö ]+$');
    if (!nameExp.hasMatch(value)) {
      return "Error: Use only alpabethical characters";
    }
    return null;
  }

  String validateYear(String value) {
    if (value.isEmpty) {
      return "Error: Age is required";
    }
    final RegExp phoneExp = new RegExp(r'^\d\d\d\d$');
    if (!phoneExp.hasMatch(value))
      return 'Error: Enter your year of birth with four numbers';
    return null;
  }

  Future<bool> warnUserAboutInvalidData() async {
    final FormState form = formKey.currentState;
    if (form == null || !formWasEdited || form.validate()) return true;

    return await showDialog<bool>(
          context: context,
          child: new AlertDialog(
            title: const Text('Entered data has errors'),
            content: const Text('Really leave this form?'),
            actions: <Widget>[
              new FlatButton(
                child: const Text('YES'),
                onPressed: () {
                  Navigator.of(context).pop(true);
                },
              ),
              new FlatButton(
                child: const Text('NO'),
                onPressed: () {
                  Navigator.of(context).pop(false);
                },
              ),
            ],
          ),
        ) ??
        false;
  }

  @override
  void initState() {
    nameController.text = person.name;
    occupationController.text = person.occupation;
    ageController.text = person.year;
    checkUserThemes();
    return super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      key: scaffoldKey,
      appBar: new AppBar(
        title: new Text('Edit profile'),
        centerTitle: true,
        actions: <Widget>[
          new IconButton(
            icon: new Icon(Icons.check),
            onPressed: handleSubmittedData,
          )
        ],
      ),
      body: buildContent(context),
    );
  }

  Widget buildContent(BuildContext context) {
    Widget pictureSection = new Container(
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
                            child: new IconButton(
                              icon: new Icon(
                                Icons.add_a_photo,
                                color: Colors.white,
                              ),
                              onPressed: getImage,
                            ),
                          )
                        : new Container(
                            alignment: Alignment.center,
                            width: 100.0,
                            height: 100.0,
                            child: new IconButton(
                              icon: new Icon(
                                Icons.add_a_photo,
                                color: Colors.white,
                              ),
                              onPressed: getImage,
                            ),
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
                    margin: const EdgeInsets.only(top: 16.0, bottom: 16.0),
                    child: new Text(
                      "Tap to update your profile picture",
                      style: new TextStyle(
                        color: Theme.of(context).disabledColor,
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );

    Widget textSection = new Form(
      key: formKey,
      autovalidate: autoValidate,
      onWillPop: warnUserAboutInvalidData,
      child: new Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          new Container(
            margin: const EdgeInsets.only(top: 16.0),
            child: new Text(
              "Information",
              style: new TextStyle(
                fontSize: 16.0,
                color: Theme.of(context).primaryColor,
              ),
            ),
          ),
          new TextFormField(
            autocorrect: false,
            decoration: new InputDecoration(
                icon: new Icon(Icons.person),
                hintText: "Enter your name",
                labelText: "Name *"),
            onSaved: (String value) {
              person.name = value;
            },
            initialValue: person.name == "" ? null : person.name,
            validator: validateName,
          ),
          new TextFormField(
            autocorrect: false,
            decoration: new InputDecoration(
                icon: new Icon(Icons.work),
                hintText: "Enter your occupation",
                labelText: "Occupation *"),
            onSaved: (String value) {
              person.occupation = value;
            },
            initialValue: person.occupation == "" ? null : person.occupation,
            validator: validateOccupation,
          ),
          new TextFormField(
            autocorrect: false,
            decoration: new InputDecoration(
                icon: new Icon(Icons.cake),
                hintText: "YYYY",
                labelText: "Year of birth *"),
            keyboardType: TextInputType.phone,
            onSaved: (String value) {
              person.year = value;
            },
            initialValue: person.year == "" ? null : person.year,
            validator: validateYear,
          ),
          new TextFormField(
            autocorrect: false,
            maxLines: 5,
            decoration: new InputDecoration(
                icon: new Icon(Icons.short_text),
                hintText: "Write something about yourself",
                labelText: "Description "),
            onSaved: (String value) {
              person.description = value;
            },
            initialValue: person.year == "" ? "" : person.description,
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
                  "Interests **",
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
                          child: new Column(
                            children: <Widget>[
                              new IconButton(
                                icon: new Icon(Icons.palette),
                                iconSize: 30.0,
                                color: artToggle
                                    ? Theme.of(context).primaryColor
                                    : Theme.of(context).disabledColor,
                                onPressed: () {
                                  setState(() => artToggle = !artToggle);
                                },
                              ),
                              new Text(
                                theme.ThemeNames.art_music,
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
                              new IconButton(
                                icon: new Icon(Icons.computer),
                                iconSize: 30.0,
                                color: appsToggle
                                    ? Theme.of(context).primaryColor
                                    : Theme.of(context).disabledColor,
                                onPressed: () {
                                  setState(() => appsToggle = !appsToggle);
                                },
                              ),
                              new Text(
                                theme.ThemeNames.apps_internet,
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
                              new IconButton(
                                icon: new Icon(Icons.local_library),
                                iconSize: 30.0,
                                color: bookToggle
                                    ? Theme.of(context).primaryColor
                                    : Theme.of(context).disabledColor,
                                onPressed: () {
                                  setState(() => bookToggle = !bookToggle);
                                },
                              ),
                              new Text(
                                theme.ThemeNames.book_circles,
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
                              new IconButton(
                                icon: new Icon(Icons.movie),
                                iconSize: 30.0,
                                color: filmToggle
                                    ? Theme.of(context).primaryColor
                                    : Theme.of(context).disabledColor,
                                onPressed: () {
                                  setState(() => filmToggle = !filmToggle);
                                },
                              ),
                              new Text(
                                theme.ThemeNames.film,
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
                              new IconButton(
                                icon: new Icon(Icons.school),
                                iconSize: 30.0,
                                color: cultureToggle
                                    ? Theme.of(context).primaryColor
                                    : Theme.of(context).disabledColor,
                                onPressed: () {
                                  setState(
                                      () => cultureToggle = !cultureToggle);
                                },
                              ),
                              new Text(
                                theme.ThemeNames.culture_edu,
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
                              new IconButton(
                                icon: new Icon(Icons.nature_people),
                                iconSize: 30.0,
                                color: natureToggle
                                    ? Theme.of(context).primaryColor
                                    : Theme.of(context).disabledColor,
                                onPressed: () {
                                  setState(() => natureToggle = !natureToggle);
                                },
                              ),
                              new Text(
                                theme.ThemeNames.nature_society,
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
                              new IconButton(
                                icon: new Icon(Icons.edit),
                                iconSize: 30.0,
                                color: poetryToggle
                                    ? Theme.of(context).primaryColor
                                    : Theme.of(context).disabledColor,
                                onPressed: () {
                                  setState(() => poetryToggle = !poetryToggle);
                                },
                              ),
                              new Text(
                                theme.ThemeNames.poetry_prose,
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
                              new IconButton(
                                icon: new Icon(Icons.language),
                                iconSize: 30.0,
                                color: languageToggle
                                    ? Theme.of(context).primaryColor
                                    : Theme.of(context).disabledColor,
                                onPressed: () {
                                  setState(
                                      () => languageToggle = !languageToggle);
                                },
                              ),
                              new Text(
                                theme.ThemeNames.language,
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

    Widget footerSection = new Container(
      margin: const EdgeInsets.only(top: 16.0),
      child: new Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          new Container(
            margin: const EdgeInsets.only(
              bottom: 8.0,
            ),
            child: new Text(
              "* Required",
              style: new TextStyle(color: Theme.of(context).primaryColor),
            ),
          ),
          new Text(
            "** At least one is required",
            style: new TextStyle(color: Theme.of(context).primaryColor),
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
        footerSection,
      ],
    );
  }
}
