import "package:flutter/material.dart";
import './upcoming.dart' as first;
import './interested.dart' as second;
import './past.dart' as third;
import './created.dart' as fourth;

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
    return new Scaffold(
        appBar: new AppBar(
          title: new Text("Test"),
          backgroundColor: Colors.green,
          bottom: new TabBar(
            controller: controller,
            tabs: <Tab>[
              new Tab(
                text:"Upcoming"
              ),
              new Tab(
                text:"Interested"
              ),
              new Tab(
                text:"Past"
              ),
              new Tab(
                text:"Created"
              )
            ]
          )
        ),
        body: new TabBarView(
          controller: controller,
          children: <Widget> [
            new first.Upcoming(),
            new second.Interested(),
            new third.Past(),
            new fourth.Created()
          ]
        )
    );
  }
}