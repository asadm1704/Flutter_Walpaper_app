import 'package:http/http.dart' as http;
import 'dart:convert';
import '../models/wallpaper_model.dart';

class PexelsService {
  // Pexels API Key
  static const String apiKey = 'Egfe4rUDd85p5YU9VIP8NcVi6cK2cbPp4p7ZIdc2P2qsGYXyDcWxVazJ';
  static const String baseUrl = 'https://api.pexels.com/v1';
  static const int perPage = 80;

  static Future<WallpaperResponse> getCuratedWallpapers({
    int page = 1,
    String? category,
  }) async {
    try {
      final String endpoint = category != null
          ? '$baseUrl/search?query=$category&per_page=$perPage&page=$page'
          : '$baseUrl/curated?per_page=$perPage&page=$page';

      final response = await http.get(
        Uri.parse(endpoint),
        headers: {
          'Authorization': apiKey,
        },
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> jsonData = jsonDecode(response.body);
        return WallpaperResponse.fromJson(jsonData);
      } else {
        throw Exception('Failed to fetch wallpapers: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error fetching wallpapers: $e');
    }
  }

  static Future<WallpaperResponse> searchWallpapers({
    required String query,
    int page = 1,
  }) async {
    return getCuratedWallpapers(page: page, category: query);
  }

  static Future<WallpaperResponse> fetchNextPage({
    required String nextPageUrl,
  }) async {
    try {
      final response = await http.get(
        Uri.parse(nextPageUrl),
        headers: {
          'Authorization': apiKey,
        },
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> jsonData = jsonDecode(response.body);
        return WallpaperResponse.fromJson(jsonData);
      } else {
        throw Exception('Failed to fetch next page: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error fetching next page: $e');
    }
  }
}
