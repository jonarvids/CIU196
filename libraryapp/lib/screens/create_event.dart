import "package:flutter/material.dart";

class CreateEvent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(title: new Text('Create event'), centerTitle: true),
      body: new Center(
        child: new Icon(Icons.face),
      ),
    );
  }
}
