import "package:flutter/material.dart";
import 'dart:io';

class Upcoming extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    return new Container(
      child: new ListView(
        padding: new EdgeInsets.all(8.0),
          children: <Widget>[
            //Column which contains all rows
            new Column(
              children: [
                //First row
                new Container(
                 margin: new EdgeInsets.only(bottom: 10.0), 
                 height: 100.0,
                 decoration: new BoxDecoration(color: Colors.green[400],
                  boxShadow: <BoxShadow>[
                    new BoxShadow (
                      color: const Color(0xcc000000),
                      offset: new Offset(0.0, 2.0),
                      blurRadius: 4.0,
                    ),
                  ], 
                    borderRadius: new BorderRadius.all(
                  const Radius.circular(0.0),
                    ), ), 
                  child: new Row(
                    children: [
                      new Image.asset(
                        'images/fox.jpg',
                        height: 100.0,
                        fit: BoxFit.cover,
                            ),
                          ]
                        ),
                      ),
                    //second row
                       new Container(
                 margin: new EdgeInsets.only(bottom: 10.0), 
                  color: Colors.green[200],
                  child: new Row(
                    children: [
                      new Image.asset(
                        'images/fox.jpg',
                        height: 100.0,
                        fit: BoxFit.contain,

                            ),
                          ]
                        ),
                      ),
                      //end of row
                    ]),
                  ],
                )
              );
            }
          }


Widget getEvents(){

}