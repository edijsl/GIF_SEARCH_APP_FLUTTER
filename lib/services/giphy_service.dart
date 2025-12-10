import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import '../models/gif_model.dart';

class GiphyService {
  final String baseUrl = 'https://api.giphy.com/v1/gifs/search';

  Future<List<GifModel>> getGifs(String query, int offset) async {
    final apiKey = dotenv.env['GIPHY_API_KEY'] ??'';
    final url = Uri.parse('$baseUrl?api_key=$apiKey&q=$query&limit=25&offset=$offset&rating=G&lang=en');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final List<dynamic> gifJsonList = data['data'];

      return gifJsonList.map((json) => GifModel.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load GIFs');
    }
  }
}