import "package:flutter/material.dart";

class Interested extends StatelessWidget  {
  @override
  Widget build(BuildContext context) {
    return new Container(
      child: new Center(
        child: new Icon(
          Icons.arrow_left, 
          size: 150.0, 
          color: Colors.green
        )
      )
    );
  }
}