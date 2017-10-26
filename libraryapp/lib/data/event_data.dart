import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:libraryapp/data/user_data.dart';

class EventItem {
  String title;
  String description;
  String fromDate; //Parse into DateTime
  TimeOfDay fromTime; //Parse into TimeOfDay
  File imageFile;
  List<EventTheme> eventThemes;

  EventItem({
    this.description,
    this.title,
    this.fromDate,
    this.fromTime,
    this.imageFile,
    this.eventThemes
  });
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
