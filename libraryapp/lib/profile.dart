import "package:flutter/material.dart";
import './screens/edit_profile.dart' as edit_profile;

class Profile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: buildAppBar(context),
      body: buildBody(context),
    );
  }

  Widget buildAppBar(BuildContext context) {
    return new AppBar(
        title: new Text("Profile"),
        centerTitle: true,
        actions: <Widget>[
          new IconButton(
            icon: new Icon(Icons.edit),
            onPressed: () {
              Navigator.of(context).push(new MaterialPageRoute<Null>(
                    builder: (BuildContext context) =>
                        new edit_profile.EditProfile(),
                  ));
            },
          ),
        ]);
  }

  Widget buildBody(BuildContext context) {
    return new Container(
      child: new Center(
        child: new Text("PROFILE BODY"),
      ),
    );
  }
}
