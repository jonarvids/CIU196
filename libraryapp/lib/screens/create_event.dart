import 'dart:async';
import 'package:flutter/material.dart';

class CreateEvent extends StatefulWidget {
  @override
  createState() => new CreateEventState();
}


class EventData {
  String description = '';
  String title = '';
}

class CreateEventState extends State<CreateEvent> {

  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  EventData event = new EventData();

  //MARK: Form preamble
  bool _autovalidate = false;
  bool _formWasEdited = false;
  final GlobalKey<FormState> _formKey = new GlobalKey<FormState>();

  void showInSnackBar(String value) {
    _scaffoldKey.currentState.showSnackBar(new SnackBar(
        content: new Text(value)
    ));
  }

  //MARK: Form Submission
  void _handleSubmitted() {
    final FormState form = _formKey.currentState;
    if (!form.validate()) {
      _autovalidate = true; // Start validating on every change.
      showInSnackBar('Please fix the errors in red before submitting.');
    } else {
      form.save();
      showInSnackBar('${event.title}\'s description is ${event.description}');
    }
  }

  //MARK: Validation messages
  String _validateTitle(String value) {
    _formWasEdited = true;
    if (value.isEmpty)
      return 'Title is required.';
    final RegExp nameExp = new RegExp(r'^[A-Za-z ]+$');
    if (!nameExp.hasMatch(value))
      return 'Please enter only alphabetical characters.';
    return null;
  }

  //MARK: Actions

  Future<bool> _warnUserAboutInvalidData() async {
    final FormState form = _formKey.currentState;
    if (form == null || !_formWasEdited || form.validate())
      return true;
    return await showDialog<bool>(
      context: context,
      child: new AlertDialog(
        title: const Text('This form has errors'),
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
    ) ?? false;
  }

  //MARK: User Interface
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: new AppBar(title: new Text('Create event'), centerTitle: true),
        body: new Form(
            key: _formKey,
            autovalidate: _autovalidate,
            onWillPop: _warnUserAboutInvalidData,
            child: new ListView(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                children: <Widget>[
                  new TextFormField(
                    decoration: const InputDecoration(
                      hintText: 'What do you want to call this event?',
                      labelText: 'Title *',
                    ),
                    onSaved: (String value) {
                      event.title = value;
                    },
                    validator: _validateTitle,
                  ),
                  new TextFormField(
                      decoration: const InputDecoration(
                        hintText: 'What is this event about?',
                        helperText: 'Make it flavorful!',
                        labelText: 'About *',
                      ),
                      maxLines: 10,
                      onSaved: (String value) {
                        event.description = value;
                      }
                    //TODO: No validator yet.
                  ),
                  new Container(
                    padding: const EdgeInsets.all(20.0),
                    //       Unclear     alignment: Alignment.center ,
                    child: new RaisedButton(
                      child: const Text('SUBMIT'),
                      onPressed: _handleSubmitted,
                    ),
                  ),
                  new Container(
                    padding: const EdgeInsets.only(top: 20.0),
                    child: new Text('* indicates required field', style: Theme
                        .of(context)
                        .textTheme
                        .caption),
                  ),
                ]
            )
        )
    );
  }
}

