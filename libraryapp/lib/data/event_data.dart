import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:libraryapp/data/user_data.dart';

class EventItem {
  final String title;
  final String description;
  final DateTime fromDate;
  final TimeOfDay fromTime;
  final File imageFile;
  final List<EventTheme> eventThemes;

  const EventItem({
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
