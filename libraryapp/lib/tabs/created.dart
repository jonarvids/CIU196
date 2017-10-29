import "package:flutter/material.dart";

class Created extends StatelessWidget {
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
            height: 100.0,
            decoration: new BoxDecoration(
              color: Theme.of(context).primaryColor,
              boxShadow: <BoxShadow>[
                new BoxShadow(
                  color: const Color(0xcc000000),
                  offset: new Offset(0.0, 2.0),
                  blurRadius: 2.0,
                ),
              ],
            ),
            child: new Row(
              children: [
                // Fox
                new Image.asset(
                  'images/puzzles.jpg',
                  height: 100.0,
                  width: 100.0,
                  fit: BoxFit.cover,
                ),
                // Info section
                new Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    new Container(
                      padding: const EdgeInsets.all(4.0),
                      child: new Text(
                        'PUZZLES',
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
                              '4th June 2018',
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
                              '08:00',
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
              ],
            ),
          ),
          ),
          //second row
          //end of row
        ]),
      ],
    ));
  }
}

void openEvent() {
   print("Container clicked");
}