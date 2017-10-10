import "package:flutter/material.dart";

class Upcoming extends StatelessWidget  {
  @override
  Widget build(BuildContext context) {
    return new Container(
      child: new Center(
        child: new Icon(
          Icons.arrow_upward, 
          size: 150.0, 
          color: Colors.green
        )
      )
    );
  }
}