import "package:flutter/material.dart";
import 'dart:async';

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
  bool formWasEdited = false, autoValidate = false;
  final GlobalKey<FormState> formKey = new GlobalKey<FormState>();
  final TextEditingController nameController = new TextEditingController();
  final TextEditingController occupationController =
      new TextEditingController();
  final TextEditingController ageController = new TextEditingController();

  void showInSnackBar(BuildContext context, String value) {
    scaffoldKey.currentState
        .showSnackBar(new SnackBar(content: new Text(value)));
  }

  void handleSubmittedData() {
    final FormState form = formKey.currentState;
    if (!form.validate()) {
      autoValidate = true;
      showInSnackBar(context,
          "Could not update profile. Fix errors in red and try again.");
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
    Widget pictureSection = new Container();

    Widget textSection = new Form(
      key: formKey,
      autovalidate: autoValidate,
      onWillPop: warnUserAboutInvalidData,
      child: new Column(
        children: [
          new TextFormField(
            autocorrect: false,
            decoration: new InputDecoration(
                hintText: "Enter your name", labelText: "Name *"),
            onSaved: (String value) {
              profile.name = value;
            },
            controller: nameController,
            validator: validateName,
          ),
          new TextFormField(
            autocorrect: false,
            decoration: new InputDecoration(
                hintText: "Enter your occupation", labelText: "Occupation *"),
            onSaved: (String value) {
              profile.occupation = value;
            },
            controller: occupationController,
            validator: validateOccupation,
          ),
          new TextFormField(
            autocorrect: false,
            decoration:
                new InputDecoration(hintText: "YYYY", labelText: "Age *"),
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
                child: new Text("Interests **"),
              ),
              new Row(
                children: [
                  new RaisedButton(
                    color: Colors.red,
                    onPressed: () {
                      null;
                    },
                  ),
                  new RaisedButton(
                    color: Colors.yellow,
                    onPressed: () {
                      null;
                    },
                  ),
                  new RaisedButton(
                    color: Colors.blue,
                    onPressed: () {
                      null;
                    },
                  ),
                  new RaisedButton(
                    color: Colors.green,
                    onPressed: () {
                      null;
                    },
                  ),
                ],
              ),
              new Row(
                children: [
                  new RaisedButton(
                    color: Colors.orange,
                    onPressed: () {
                      null;
                    },
                  ),
                  new RaisedButton(
                    color: Colors.cyan,
                    onPressed: () {
                      null;
                    },
                  ),
                  new RaisedButton(
                    color: Colors.purple,
                    onPressed: () {
                      null;
                    },
                  ),
                  new RaisedButton(
                    color: Colors.brown,
                    onPressed: () {
                      null;
                    },
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
            child: new Text("* Required"),
          ),
          new Text("** One or more is required"),
        ],
      ),
    );

    ListView contentList = new ListView(
      children: [
        pictureSection,
        textSection,
        interestsSection,
      ],
    );

    return new Container(
      padding: const EdgeInsets.all(16.0),
      child: new Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          new Expanded(
            child: contentList,
          ),
          footerSection
        ],
      ),
    );
  }
}
