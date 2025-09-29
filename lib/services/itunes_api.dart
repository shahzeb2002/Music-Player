import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/song.dart';

class ITunesApi {
  static Future<List<Song>> searchSongs(String query, {int limit = 100}) async {
    final url = Uri.parse(
      "https://itunes.apple.com/search?term=$query&entity=song&limit=$limit",
    );

    final response = await http.get(url);

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);

      if (!data.containsKey('results')) return [];

      final List results = data['results'];
      return results.map((json) => Song.fromJson(json)).toList();
    } else {
      throw Exception("Failed to load songs: ${response.statusCode}");
    }
  }
}
