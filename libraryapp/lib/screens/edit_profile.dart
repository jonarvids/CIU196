import "package:flutter/material.dart";

class EditProfile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(title: new Text('Edit profile'), centerTitle: true),
      body: new Center(
        child: new Icon(Icons.face),
      ),
    );
  }
}
