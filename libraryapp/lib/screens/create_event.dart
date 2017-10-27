import "package:flutter/material.dart";
import 'dart:async';
import 'package:intl/intl.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/services.dart';

class CreateEvent extends StatefulWidget {
  static const String routeName = '/material/date-and-time-pickers';

  @override
  createState() => new CreateEventState();
}

class EventTheme {
  bool isToggled;

  EventTheme(bool isToggled) {
    this.isToggled = isToggled;
  }
}

class EventData {
  String description = '';
  String title = '';
  DateTime _fromDate = new DateTime.now();
  TimeOfDay _fromTime = const TimeOfDay(hour: 18, minute: 0);
  File imageFile;
  EventTheme artTheme = new EventTheme(false);
  EventTheme bookTheme = new EventTheme(false);
  EventTheme cultureTheme = new EventTheme(false);
  EventTheme poetryTheme = new EventTheme(false);
  EventTheme appsTheme = new EventTheme(false);
  EventTheme filmTheme = new EventTheme(false);
  EventTheme natureTheme = new EventTheme(false);
  EventTheme languageTheme = new EventTheme(false);
}

class CreateEventState extends State<CreateEvent> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  EventData event = new EventData();
  //MARK: Form preamble
  bool _autovalidate = false;
  bool _formWasEdited = false;
  final GlobalKey<FormState> _formKey = new GlobalKey<FormState>();

  void showInSnackBar(String value) {
    _scaffoldKey.currentState
        .showSnackBar(new SnackBar(content: new Text(value)));
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
    if (value.isEmpty) return 'Title is required.';
    final RegExp nameExp = new RegExp(r'^[A-Za-z ]+$');
    if (!nameExp.hasMatch(value))
      return 'Please enter only alphabetical characters.';
    return null;
  }

  //MARK: Actions

  Future<bool> _warnUserAboutInvalidData() async {
    final FormState form = _formKey.currentState;
    if (form == null || !_formWasEdited || form.validate()) return true;
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
        ) ??
        false;
  }

  getImage() async {
    var fileName = await ImagePicker.pickImage();
    setState(() {
      event.imageFile = fileName;
    });
  }

  //MARK: User Interface
  Widget eventImageSection(BuildContext context) {
    return new Container(
        child: new Column(
      children: <Widget>[
        new ClipRect(
          child: event.imageFile == null
              ? new Container(
                  alignment: Alignment.center,
                  color: Theme.of(context).disabledColor,
                  height: 150.0,
                  child: new IconButton(
                    padding: const EdgeInsets.only(
                        left: 100.0, right: 100.0, bottom: 40.0, top: 40.0),
                    icon: new Icon(
                      Icons.add_a_photo,
                      color: Colors.white,
                    ),
                    onPressed: getImage,
                  ),
                )
              : new Container(
                  alignment: Alignment.center,
                  child: new IconButton(
                    padding: const EdgeInsets.only(
                        left: 200.0, right: 200.0, bottom: 40.0, top: 40.0),
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
                        event.imageFile,
                        scale: 0.25,
                      ),
                    ),
                  ),
                ),
        ),
        new Container(
          margin: const EdgeInsets.only(top: 8.0),
          child: new Text(
            "Tap to update the event banner",
            style: new TextStyle(
              color: Theme.of(context).disabledColor,
            ),
          ),
        )
      ],
    ));
  }

  Widget formSection(BuildContext context) {
    return wrapWithPadding(new Form(
        key: _formKey,
        autovalidate: _autovalidate,
        onWillPop: _warnUserAboutInvalidData,
        child: new Column(children: <Widget>[
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
                labelText: 'Description *',
              ),
              maxLines: 5,
              onSaved: (String value) {
                event.description = value;
              }
              //TODO: No validator yet.
              ),
        ])));
  }

  Widget dateSection(BuildContext context) {
    return wrapWithPadding(new Column(children: <Widget>[
      new _DateTimePicker(
        labelText: 'Date & Time *',
        selectedDate: event._fromDate,
        selectedTime: event._fromTime,
        selectDate: (DateTime date) {
          setState(() {
            event._fromDate = date;
          });
        },
        selectTime: (TimeOfDay time) {
          setState(() {
            event._fromTime = time;
          });
        },
      )
    ]));
  }

  Widget themeSection(BuildContext context) {
    return wrapWithPadding(
      new Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          new Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              new Container(
                margin: const EdgeInsets.only(top: 16.0),
                child: new Text(
                  "Event theme **",
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
                                color: setEventTheme(event.artTheme, context),
                                onPressed: toggleTheme(event.artTheme),
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
                                color: setEventTheme(event.appsTheme, context),
                                onPressed: toggleTheme(event.appsTheme),
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
                                color: setEventTheme(event.bookTheme, context),
                                onPressed: toggleTheme(event.bookTheme),
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
                                color: setEventTheme(event.filmTheme, context),
                                onPressed: toggleTheme(event.filmTheme),
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
                                color:
                                    setEventTheme(event.cultureTheme, context),
                                onPressed: toggleTheme(event.cultureTheme),
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
                                color:
                                    setEventTheme(event.natureTheme, context),
                                onPressed: toggleTheme(event.natureTheme),
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
                                color:
                                    setEventTheme(event.poetryTheme, context),
                                onPressed: toggleTheme(event.poetryTheme),
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
                                color:
                                    setEventTheme(event.languageTheme, context),
                                onPressed: toggleTheme(event.languageTheme),
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
  }

  Widget footerSection(BuildContext context) {
    return wrapWithPadding(
      new Column(
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
  }

  //MARK: Theme selection

  Color setEventTheme(EventTheme theme, BuildContext context) {
    return theme.isToggled
        ? Theme.of(context).primaryColor
        : Theme.of(context).disabledColor;
  }

  VoidCallback toggleTheme(EventTheme theme) {
    return () {
      setState(() => theme.isToggled = !theme.isToggled);
    };
  }

  //MARK: Build Screen
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: new AppBar(
          title: new Text('Create event'),
          centerTitle: true,
          actions: <Widget>[
            new IconButton(
              icon: new Icon(Icons.check),
              onPressed: _handleSubmitted,
            )
          ],
        ),
        body: _buildContent(context));
  }

  Widget _buildContent(BuildContext context) {
    return new ListView(
      children: [
        eventImageSection(context),
        formSection(context),
        dateSection(context),
        themeSection(context),
        footerSection(context)
      ],
    );
  }
}

//Mark: Helpers
EdgeInsets appInset() {
  return const EdgeInsets.all(16.0);
}

Container wrapWithPadding(Widget widget) {
  return new Container(padding: appInset(), child: widget);
}
//Mark: Date Picker Demo Code
//[https://github.com/flutter/flutter/blob/master/examples/flutter_gallery/lib/demo/material/date_and_time_picker_demo.dart]

class _InputDropdown extends StatelessWidget {
  const _InputDropdown(
      {Key key,
      this.child,
      this.labelText,
      this.valueText,
      this.valueStyle,
      this.onPressed})
      : super(key: key);

  final String labelText;
  final String valueText;
  final TextStyle valueStyle;
  final VoidCallback onPressed;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return new InkWell(
      onTap: onPressed,
      child: new InputDecorator(
        decoration: new InputDecoration(
          labelText: labelText,
        ),
        baseStyle: valueStyle,
        child: new Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            new Text(valueText, style: valueStyle),
            new Icon(Icons.arrow_drop_down,
                color: Theme.of(context).brightness == Brightness.light
                    ? Colors.grey.shade700
                    : Colors.white70),
          ],
        ),
      ),
    );
  }
}

class _DateTimePicker extends StatelessWidget {
  const _DateTimePicker(
      {Key key,
      this.labelText,
      this.selectedDate,
      this.selectedTime,
      this.selectDate,
      this.selectTime})
      : super(key: key);

  final String labelText;
  final DateTime selectedDate;
  final TimeOfDay selectedTime;
  final ValueChanged<DateTime> selectDate;
  final ValueChanged<TimeOfDay> selectTime;

  Future<Null> _selectDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: new DateTime(2015, 8),
        lastDate: new DateTime(2101));
    if (picked != null && picked != selectedDate) selectDate(picked);
  }

  Future<Null> _selectTime(BuildContext context) async {
    final TimeOfDay picked =
        await showTimePicker(context: context, initialTime: selectedTime);
    if (picked != null && picked != selectedTime) selectTime(picked);
  }

  @override
  Widget build(BuildContext context) {
    final TextStyle valueStyle = Theme.of(context).textTheme.body2;
    return new Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: <Widget>[
        new Expanded(
          flex: 4,
          child: new _InputDropdown(
            labelText: labelText,
            valueText: new DateFormat.yMMMd().format(selectedDate),
            valueStyle: valueStyle,
            onPressed: () {
              _selectDate(context);
            },
          ),
        ),
        const SizedBox(width: 12.0),
        new Expanded(
          flex: 3,
          child: new _InputDropdown(
            valueText: selectedTime.format(context),
            valueStyle: valueStyle,
            onPressed: () {
              _selectTime(context);
            },
          ),
        ),
      ],
    );
  }
}
