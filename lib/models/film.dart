import 'dart:convert';
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

  static Future<Film> fetchFilm(int id) async {
    var response = await http.get(Uri.parse("$baseUrl/$id"));

    if (response.statusCode != 200) {
      throw Exception("Error ${response.statusCode} fetching movie");
    }

    final jsonObj = jsonDecode(response.body);

    return Film(
      id: jsonObj["id"],
      title: jsonObj["title"],
      director: jsonObj["director"],
      duration: jsonObj["duration"],
      link: jsonObj["link"],
    );
  }
}