import 'dart:io';
import 'package:flutter/material.dart';
import 'package:quiver/core.dart';

class EventItem {
  String title;
  String description;
  String fromDate; //Parse into DateTime
  TimeOfDay fromTime; //Parse into TimeOfDay
  File imageFile;
  Set<String> eventThemes;
  String id;

  EventItem({
    this.description,
    this.title,
    this.fromDate,
    this.fromTime,
    this.imageFile,
    this.eventThemes,
    this.id
  });

  @override
  bool operator == (o) => o is EventItem && o.id == id;
  @override
  int get hashCode => hash2(title.hashCode, description.hashCode);

}

abstract class EventRepository {
  Map<String, EventItem> getEvents();
  void addEvent(EventItem event);
}

class FetchEventDataException implements Exception {
  String _message;

  FetchEventDataException(this._message);

  String toString() {
    return "Exception: $_message";
  }
}
