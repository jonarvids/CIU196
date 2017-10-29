
import 'dart:async';
import 'user_data.dart';
import 'matched_event_data.dart';
import 'event_data.dart';
import 'event_data_mock.dart';
import 'user_data_mock.dart';

/*
 * Matched events should ideally 'extract' the matched events for a user
 * by searching for all events that include that user. This is mock data
 * for ALL matched events for every user.
 */

class MockMatchedEventRepository implements MatchedEventRepository{
    EventRepository eventRepository = new MockEventRepository();
    UserRepository userRepository = new MockUserRepository();


  static const kMatchedEvents = const <MatchedEventItem>[
    //TODO: Add mock event + users from the other repositories.
  ];

  @override
  void addEvent(MatchedEventItem event) {
    // TODO: implement addEvent
  }
  @override
  Map<String, MatchedEventItem> getMatchedEvents() {
    return null;//kMatchedEvents;
  }
}

