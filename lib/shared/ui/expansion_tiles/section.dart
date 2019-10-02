import 'package:flutter/material.dart';

class Section {
  String title;
  List<String> entries;
  List<Widget> reviews;

  Section(this.title, {this.entries, this.reviews});
}

List<Section> createSection(String title,
        {List<String> entries, List<Widget> reviews}) =>
    entries != null
        ? <Section>[Section(title, entries: entries)]
        : <Section>[Section(title, reviews: reviews)];
