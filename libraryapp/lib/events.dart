import "package:flutter/material.dart";
import './tabs/upcoming.dart' as first;
import './tabs/created.dart' as second;
import './screens/create_event.dart' as create_event;

class Events extends StatefulWidget {
  @override
  TabsState createState() => new TabsState();
}

class TabsState extends State<Events> with SingleTickerProviderStateMixin {
  TabController controller;

  @override
  void initState() {
    super.initState();
    controller = new TabController(vsync: this, length: 4);
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(appBar: buildAppBar(context), body: buildBody(context));
  }

  Widget buildAppBar(BuildContext context) {
    return new AppBar(
        title: new Text("Events"),
        centerTitle: true,
        actions: <Widget>[
          new IconButton(
              icon: new Icon(Icons.add),
              onPressed: () {
                Navigator.of(context).push(new MaterialPageRoute<Null>(
                      builder: (BuildContext context) =>
                          new create_event.CreateEvent(),
                    ));
              })
        ],
        bottom: new TabBar(controller: controller, tabs: <Tab>[
          new Tab(text: "Matched"),
          new Tab(text: "Created")
        ]));
  }

  Widget buildBody(BuildContext context) {
    return new TabBarView(controller: controller, children: <Widget>[
      new first.Upcoming(),
      new second.Created()
    ]);
  }
}
