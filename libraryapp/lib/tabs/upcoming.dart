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
              new GestureDetector(
                onTap: () {
                  openEvent();
                },
                child:
                new Container(
                  margin: new EdgeInsets.only(bottom: 10.0),
                  height: 140.0,
                  decoration: new BoxDecoration(
                    color: const Color(0xFFFFFFFF),
                    boxShadow: <BoxShadow>[
                      new BoxShadow(
                        color: const Color(0x99000000),
                        offset: new Offset(0.0, 1.0),
                        blurRadius: 2.0,
                      ),
                    ],
                  ),
                  child: new Row(
                    children: [
                      // Fox
                      new Image.asset(
                        'images/gamenight.jpg',
                        height: 140.0,
                        width: 145.0,
                        fit: BoxFit.cover,
                      ),
                      // Info section
                      new Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          new Container(
                            padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
                            child: new Text(
                              'Chess & Checkers',
                              // textAlign: TextAlign.center,
                              overflow: TextOverflow.ellipsis,
                              style: new TextStyle(
                                  color:  Theme.of(context).primaryColor,
                                  fontSize: 18.0,),
                            ),
                          ),
                          new Container(
                            padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 2.0),
                            child: new Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  new Icon(Icons.access_time,
                                      size: 18.0, color: const Color(0xffababab)),
                                  new Text(
                                    '19:00  ',
                                    //textAlign: TextAlign.left,
                                    overflow: TextOverflow.ellipsis,
                                    style: new TextStyle(
                                        color: const Color(0xffababab), fontSize: 16.0),
                                  ),
                                  new Icon(Icons.date_range,
                                      size: 18.0, color: const Color(0xffababab)),
                                  new Text(
                                    '1st January 2018',
                                    //textAlign: TextAlign.left,
                                    overflow: TextOverflow.ellipsis,
                                    style: new TextStyle(
                                        color: const Color(0xffababab),
                                        fontSize: 16.0),
                                  )
                                ]),
                          ),
                          new Container(
                            padding:const EdgeInsets.symmetric(horizontal: 12.0, vertical: 2.0),
                            child: new Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  new Container(
                                      child: new Row(
                                        children: [
                                          new Icon(Icons.location_city,
                                              size: 18.0, color: const Color(0xffababab)),
                                          new Text(
                                            'Göteborgs Stadsbibliotek',
                                            //textAlign: TextAlign.left,
                                            overflow: TextOverflow.ellipsis,
                                            style: new TextStyle(
                                                color: const Color(0xffababab), fontSize: 16.0),
                                          )
                                        ],
                                      ))
                                ]),
                          ),
                          // People section
                          new Container(
                            //decoration: new BoxDecoration(color: Colors.blue),
                              padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 2.0),
                              child: (new Row(
                                children: [
                                  new Column(
                                    children: [
                                      new ClipOval(
                                        child: new Image.asset(
                                          'images/guy1.jpg',
                                          height: 30.0,
                                          width: 30.0,
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ],
                                  ),
                                  new Column(
                                    children: [
                                      new ClipOval(
                                        child: new Image.asset(
                                          'images/guy2.jpg',
                                          height: 30.0,
                                          width: 30.0,
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ],
                                  ),
                                  new Column(
                                    children: [
                                      new ClipOval(
                                        child: new Image.asset(
                                          'images/girl1.jpg',
                                          height: 30.0,
                                          width: 30.0,
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ],
                                  ),
                                  new Column(
                                    children: [
                                      new Icon(
                                        Icons.person_pin,
                                        size: 39.0,
                                        color: Theme.of(context).accentColor,
                                      )
                                    ],
                                  ),
                                ],
                              )))
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              //NEW ROW.
            ]),
          ],
        ));
  }
}

void openEvent() {
  print("Container clicked");
}