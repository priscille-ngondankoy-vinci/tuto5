import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

class Film {
  static const baseUrl = "https://sebstreb.github.io/flutter-fiche-5/films-api";

  final int id;
  final String title;
  final String director;
  final int duration;
  final String link;

  const Film({
    required this.id,
    required this.title,
    required this.director,
    required this.duration,
    required this.link,
  });

  @override
  String toString() =>
      'Film: $title, directed by $director, $duration min, $link';

  static Future<List<Film>> fetchFilms() async {
    var response = await http.get(Uri.parse("$baseUrl/"));

    if (response.statusCode != 200) {
      throw Exception("Error ${response.statusCode} fetching movies");
    }

    return compute((input) {
      final jsonList = jsonDecode(input);
      return jsonList.map<Film>((jsonObj) => Film(
        id: jsonObj["id"],
        title: jsonObj["title"],
        director: jsonObj["director"],
        duration: jsonObj["duration"],
        link: jsonObj["link"],
      )).toList();
    }, response.body);
  }
}