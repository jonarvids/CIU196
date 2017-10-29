
import 'dart:io';

import 'package:flutter/material.dart';
import 'dart:collection';
import 'event_data.dart';
import 'theme_names.dart';

class MockEventRepository implements EventRepository{
    MockEventRepository() {
      var eventThemesa= new HashSet<String>();
      eventThemesa.add(ThemeNames.language);
      eventThemesa.add(ThemeNames.poetry_prose);
      EventItem a = new EventItem(
          id: "event_1",
          title: "Book-writing workshop",
          description:
          "Lorem ipsum dolor sit amet, consectetur adipisicing elit,"
              " sed do eiusmod tempor incididunt ut labore et dolore"
              " magna aliqua. Ut enim ad minim veniam, quis nostrud "
              "exercitation ullamco laboris nisi ut aliquip ex ea "
              "commodo consequat. ",
          fromDate: "2017-11-20 20:00:00",
          fromTime: const TimeOfDay(hour: 20,minute: 0),
          eventThemes: eventThemesa,
      );
      var eventThemesb= new HashSet<String>();
      eventThemesb.add(ThemeNames.language);
      eventThemesb.add(ThemeNames.culture_edu);
      EventItem b =  new EventItem(
        id: "event_2",
        title: "Language Café",
        description:
        "Lorem ipsum dolor sit amet, consectetur adipisicing elit,"
        " sed do eiusmod tempor incididunt ut labore et dolore"
        " magna aliqua. Ut enim ad minim veniam, quis nostrud "
        "exercitation ullamco laboris nisi ut aliquip ex ea "
        "commodo consequat. ",
        fromDate: "2017-11-2 20:00:00",
        fromTime: const TimeOfDay(hour: 20,minute: 0),
        eventThemes: eventThemesb,

      );
      var eventThemesc= new HashSet<String>();
      eventThemesc.add(ThemeNames.language);
      eventThemesc.add(ThemeNames.culture_edu);
      EventItem c = new EventItem(
        id: "event_3",
        title: "Code night featuring Ericsson",
        description:
        "Lorem ipsum dolor sit amet, consectetur adipisicing elit,"
        " sed do eiusmod tempor incididunt ut labore et dolore"
        " magna aliqua. Ut enim ad minim veniam, quis nostrud "
        "exercitation ullamco laboris nisi ut aliquip ex ea "
        "commodo consequat.",
        fromDate: "2017-11-2 20:00:00",
        fromTime: const TimeOfDay(hour: 20,minute: 0),
        eventThemes: eventThemesc,
      );
      var eventThemesd= new HashSet<String>();
      eventThemesd.add(ThemeNames.art_music);
      eventThemesd.add(ThemeNames.apps_internet);
      EventItem d = new EventItem(
          id: "event_3",
          title: "Roleplaying: The Burning Wheel",
          description:
          "Burning Wheel is a tabletop roleplaying game , "
              "one which plays out more like improv-theatre; you can't win,"
              " and neither can you lose.",
          fromDate: "2017-11-2 20:00:00",
          fromTime: const TimeOfDay(hour: 20,minute: 0),
          eventThemes: eventThemesd,
      );
      addEvent(a);
      addEvent(b);
      addEvent(c);
      addEvent(d);
    }
    Map<String,EventItem> _kEvents = new HashMap<String,EventItem>();


  @override
  void addEvent(EventItem event) {
    _kEvents.putIfAbsent(event.id, () => event);
  }

  @override
  Map<String, EventItem> getEvents() {
    return _kEvents;
  }
}

