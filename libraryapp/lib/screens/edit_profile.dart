import "package:flutter/material.dart";

class EditProfile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text('Edit profile'),
        centerTitle: true,
      ),
      body: buildContent(context),
    );
  }
}

Widget buildContent(BuildContext context) {
  TextEditingController controller = new TextEditingController();

  Row buildEnterTextColumn(String title, String hint) {
    return new Row(
      children: [
        new Expanded(
          child: new Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              new Text(title),
              new Container(
                margin: const EdgeInsets.only(bottom: 8.0),
                child: new TextField(
                  controller: controller,
                  decoration: new InputDecoration(
                    hintText: hint,
                  ),
                ),
              ),
            ],
          ),
        )
      ],
    );
  }

  Row buildEnterYearColumn(String title, String hint) {
    return new Row(
      children: [
        new Expanded(
          child: new Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              new Text(title),
              new Container(
                width: 50.0,
                margin: const EdgeInsets.only(bottom: 8.0),
                child: new TextField(
                  controller: controller,
                  decoration: new InputDecoration(
                    hintText: hint,
                  ),
                ),
              ),
            ],
          ),
        )
      ],
    );
  }

  Widget pictureSection = new Container();

  Widget textSection = new Container(
    child: new Column(
      children: [
        buildEnterTextColumn("Name *", "Enter your name"),
        buildEnterTextColumn("Occupation ", "Enter your occupation"),
        buildEnterYearColumn("Age *", "Years"),
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
              margin: const EdgeInsets.only(bottom: 16.0),
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
