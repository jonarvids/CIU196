
import 'dart:async';
import 'package:flutter/material.dart';
import 'dart:collection';
import 'user_data.dart';
import 'event_data.dart';
import 'theme_names.dart';

class MockEventRepository implements EventRepository{
    Map<String,EventItem> _kEvents = new HashMap<String,EventItem>();
    MockEventRepository() {
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
          eventThemes: <String>[
            ThemeNames.poetry_prose,
            ThemeNames.language],
      );
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
        eventThemes: <String>[
        ThemeNames.language,
        ThemeNames.culture_edu]
      );
      EventItem c = new EventItem(
        id: "event_3",
        title: "Language Café",
        description:
        "Lorem ipsum dolor sit amet, consectetur adipisicing elit,"
        " sed do eiusmod tempor incididunt ut labore et dolore"
        " magna aliqua. Ut enim ad minim veniam, quis nostrud "
        "exercitation ullamco laboris nisi ut aliquip ex ea "
        "commodo consequat. ",
        fromDate: "2017-11-2 20:00:00",
        fromTime: const TimeOfDay(hour: 20,minute: 0),
        eventThemes: <String>[
        ThemeNames.language,
        ThemeNames.culture_edu]
      );
      addEvent(a);
      addEvent(b);
      addEvent(c);
    }


  @override
  void addEvent(EventItem event) {
    _kEvents.putIfAbsent(event.id, () => event);
  }

  @override
  Map<String, EventItem> getEvents() {
    return _kEvents;
  }
}

