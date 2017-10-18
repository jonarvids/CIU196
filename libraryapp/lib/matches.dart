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
    );
  }

  Widget buildBody(BuildContext context) {
    return new Padding(
      padding: const EdgeInsets.all(16.0),
      child: new Dismissible(
        key: new ObjectKey("yo"),
        child: new Card(
          color: Colors.white,
          child: new Center(
            child: new Text("MATCH BODY"),
          ),
        ),
      ),
    );
  }
}
