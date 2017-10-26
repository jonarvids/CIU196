import "package:flutter/material.dart";
import 'package:flutter/foundation.dart';
import 'dart:io';

class Upcoming extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Container(
        child: new ListView(
      padding: new EdgeInsets.all(8.0),
      children: <Widget>[
        //Column which contains all rows
        new Column(children: [
          //First row
          new Container(
            margin: new EdgeInsets.only(bottom: 10.0),
            height: 100.0,
            decoration: new BoxDecoration(
              color: Colors.green[400],
              boxShadow: <BoxShadow>[
                new BoxShadow(
                  color: const Color(0xcc000000),
                  offset: new Offset(0.0, 2.0),
                  blurRadius: 6.0,
                ),
              ],
              borderRadius: new BorderRadius.horizontal(left: 
                const Radius.circular(50.0),
              ),
            ),
            child: new Row(
              children: [
                // Fox
                new ClipOval(
                  child:
                new Image.asset(
                  'images/fox.jpg',
                  height: 100.0,
                  width: 100.0,
                  fit: BoxFit.cover,
                ),
                ),
                // Info section
                new Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    new Container(
                      padding: const EdgeInsets.all(4.0),
                      child: new Text(
                        'Game night',
                        // textAlign: TextAlign.center,
                        overflow: TextOverflow.ellipsis,
                        style: new TextStyle(
                            color: Colors.white,
                            fontSize: 16.0,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    new Container(
                      padding: const EdgeInsets.only(left: 2.0),
                      child: new Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            new Icon(Icons.date_range,
                                size: 18.0, color: Colors.white),
                            new Text(
                              '1st January 2018',
                              //textAlign: TextAlign.left,
                              overflow: TextOverflow.ellipsis,
                              style: new TextStyle(
                                  color: Colors.white, fontSize: 10.0),
                            )
                          ]),
                    ),
                    new Container(
                      padding: const EdgeInsets.only(left: 2.0),
                      child: new Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            new Icon(Icons.access_time,
                                size: 18.0, color: Colors.white),
                            new Text(
                              '19:00',
                              //textAlign: TextAlign.left,
                              overflow: TextOverflow.ellipsis,
                              style: new TextStyle(
                                  color: Colors.white, fontSize: 10.0),
                            )
                          ]),
                    ),
                    new Container(
                      padding: const EdgeInsets.only(left: 2.0),
                      child: new Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            new Container(
                                child: new Row(
                              children: [
                                new Icon(Icons.location_city,
                                    size: 18.0, color: Colors.white),
                                new Text(
                                  'Göteborgs \nStadsbibliotek',
                                  //textAlign: TextAlign.left,
                                  overflow: TextOverflow.ellipsis,
                                  style: new TextStyle(
                                      color: Colors.white, fontSize: 10.0),
                                )
                              ],
                            ))
                          ]),
                    ),
                  ],
                ),
                // People section
                new Container(
                    //decoration: new BoxDecoration(color: Colors.blue),
                    padding: new EdgeInsets.symmetric(
                        vertical: 25.0, horizontal: 5.0),
                    child: (new Row(
                      children: [
                        new Column(
                          children: [
                            new ClipOval(
                              child: new Image.asset(
                                'images/fox.jpg',
                                height: 30.0,
                                fit: BoxFit.cover,
                              ),
                            ),
                            new Text("Sven",
                                style: new TextStyle(
                                  color: Colors.white,
                                  fontSize: 12.0,
                                )),
                          ],
                        ),
                        new Column(
                          children: [
                            new ClipOval(
                              child: new Image.asset(
                                'images/fox.jpg',
                                height: 30.0,
                                fit: BoxFit.cover,
                              ),
                            ),
                            new Text("Eric",
                                style: new TextStyle(
                                  color: Colors.white,
                                  fontSize: 12.0,
                                )),
                          ],
                        ),
                        new Column(
                          children: [
                            new ClipOval(
                              child: new Image.asset(
                                'images/fox.jpg',
                                height: 30.0,
                                fit: BoxFit.cover,
                              ),
                            ),
                            new Text("Sandra",
                                //overflow: TextOverflow.ellipsis,
                                style: new TextStyle(
                                  color: Colors.white,
                                  fontSize: 12.0,
                                )),
                          ],
                        ),
                        new Column(
                          children: [
                            new Icon(
                              Icons.add,
                              size: 30.0,
                              color: Colors.white,
                            ),
                            new Text("+ 2",
                                //overflow: TextOverflow.ellipsis,
                                style: new TextStyle(
                                  color: Colors.white,
                                  fontSize: 12.0,
                                )),
                          ],
                        ),
                      ],
                    )))
              ],
            ),
          ),
          //second row
          new Container(
            margin: new EdgeInsets.only(bottom: 10.0),
            color: Colors.green[200],
            child: new Row(children: [
              new Image.asset(
                'images/fox.jpg',
                height: 100.0,
                fit: BoxFit.contain,
              ),
            ]),
          ),
          //end of row
        ]),
      ],
    ));
  }
}
