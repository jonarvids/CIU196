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
                      blurRadius: 6.0,
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
                        width: 80.0,
                        fit: BoxFit.cover,
                            ),
                        new Container(
                          //decoration: new BoxDecoration(color: Colors.red),
                          padding: new EdgeInsets.all(8.0),
                          child: (
                            new Column(children: 
                            [
                              new Text(
                              'GAME NIGHT',
                              textAlign: TextAlign.center,
                              overflow: TextOverflow.ellipsis,
                              style: new TextStyle(
                                color: Colors.white,
                                fontSize: 16.0,
                                fontWeight: FontWeight.bold
                                ),
                            ),
                            new Row(
                              children: [
                                new Icon(Icons.date_range,
                                size: 18.0,
                                color: Colors.white),
                                new Text(
                              '1st January 2018',
                                textAlign: TextAlign.left,
                                overflow: TextOverflow.ellipsis,
                                style: new TextStyle(
                                  color: Colors.white,
                                  fontSize: 10.0
                                  ),
                                )
                              ]
                            ),
                            new Row(
                              children: [
                               new Icon(Icons.access_time,
                               size: 18.0,
                                color: Colors.white),
                               new Text(
                                '19:00',
                                textAlign: TextAlign.left,
                                overflow: TextOverflow.ellipsis,
                                style: new TextStyle(
                                  color: Colors.white,
                                  fontSize: 10.0
                              ),
                                )
                              ]
                            ),
                             new Row(
                              children: [
                                new Icon(Icons.location_city,
                                size: 18.0,
                                color: Colors.white),
                               new Text(
                                'Göteborgs \nStadsbibliotek',
                                textAlign: TextAlign.left,
                                overflow: TextOverflow.ellipsis,
                                style: new TextStyle(
                                  color: Colors.white,
                                  fontSize: 10.0
                              ),
                                )
                              ]
                            ),
                            ]
                            )
                          ),
                          ),
                          new Container(
                            //decoration: new BoxDecoration(color: Colors.blue),
                            padding: new EdgeInsets.symmetric(vertical: 25.0, horizontal: 10.0),
                            child: (
                              new Row(children: [
                                new Column(
                                children:[
                                  new ClipOval(
                                    child: 
                                    new Image.asset(
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
                                children:[
                                      new ClipOval(
                                    child: 
                                    new Image.asset(
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
                                children:[
                                     new ClipOval(
                                    child: 
                                    new Image.asset(
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
                                children:[
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
                              )
                            )
                          )
                         ],
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