import "package:flutter/material.dart";
import './screens/create_event.dart' as create_event;

class Matches extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(appBar: buildAppBar(context), body: buildBody(context));
  }

  Widget buildAppBar(BuildContext context) {
    return new AppBar(
        title: new Text("Matches"),
        centerTitle: true,
        backgroundColor: Colors.green,
        actions: <Widget>[
          new IconButton(
            icon: new Icon(Icons.add),
            tooltip: "Create Event",
            onPressed: () {
                 Navigator.of(context).push(new MaterialPageRoute<Null>(
                      builder: (BuildContext context) =>
                          new create_event.CreateEvent(),
                    ));
            })
        ]);
  }

  Widget buildBody(BuildContext context) {
    return new Container(child: new Center(child: new Text("MATCH BODY")));
  }
}
