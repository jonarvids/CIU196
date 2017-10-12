import "package:flutter/material.dart";

class Matches extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(appBar: buildAppBar(context), body: buildBody(context));
  }

  Widget buildAppBar(BuildContext context) {
    return new AppBar(
        title: new Text("Matches"),
        centerTitle: true,
        backgroundColor: Colors.green);
  }

  Widget buildBody(BuildContext context) {
    return new Container(child: new Center(child: new Text("MATCH BODY")));
  }
}
