import 'dart:async';

class EventItem implements Comparable<EventItem>{
  String title;
  String description;
  String fromDate; //Parse into DateTime
  String fromTime; //Parse into TimeOfDay
  String imagePath;
  List<String> eventThemes;

  EventItem(String title, String description, String fromDate, String formTime, String imagePath, List<String> eventThemes) {
    this.title = title;
    this.description = description;
    this.fromDate = fromDate;
    this.fromTime = fromTime;
    this.imagePath = imagePath;
    this.eventThemes = eventThemes;
  }

    @override
  int compareTo(EventItem other) => index.compareTo(other.index);
}

abstract class EventRepository {
  Future<List<EventItem>> fetch();
}
class FetchEventDataException implements Exception {
  String _message;

  FetchEventDataException(this._message);

  String toString() {
    return "Exception: $_message";
  }
}
