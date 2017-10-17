import "package:flutter/material.dart";
import 'dart:async';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/services.dart';

class EditProfile extends StatefulWidget {
  @override
  EditProfileState createState() => new EditProfileState();
}

class ProfileData {
  String name = "John Johnsson";
  String occupation = "Blacksmith";
  String year = "1901";
}

class EditProfileState extends State<EditProfile> {
  final GlobalKey<ScaffoldState> scaffoldKey = new GlobalKey<ScaffoldState>();
  ProfileData profile = new ProfileData();
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
    nameController.text = profile.name;
    occupationController.text = profile.occupation;
    ageController.text = profile.year;
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
                    child: imageFile == null
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
                                image: new FileImage(
                                  imageFile,
                                  scale: 0.25,
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
              style: new TextStyle(color: Theme.of(context).primaryColor),
            ),
          ),
          new TextFormField(
            autocorrect: false,
            decoration: new InputDecoration(
                icon: new Icon(Icons.person),
                hintText: "Enter your name",
                labelText: "Name *"),
            onSaved: (String value) {
              profile.name = value;
            },
            controller: nameController,
            validator: validateName,
          ),
          new TextFormField(
            autocorrect: false,
            decoration: new InputDecoration(
                icon: new Icon(Icons.work),
                hintText: "Enter your occupation",
                labelText: "Occupation *"),
            onSaved: (String value) {
              profile.occupation = value;
            },
            controller: occupationController,
            validator: validateOccupation,
          ),
          new TextFormField(
            autocorrect: false,
            decoration: new InputDecoration(
                icon: new Icon(Icons.cake),
                hintText: "YYYY",
                labelText: "Age *"),
            keyboardType: TextInputType.phone,
            onSaved: (String value) {
              profile.year = value;
            },
            controller: ageController,
            validator: validateYear,
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
