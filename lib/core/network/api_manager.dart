import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../models/articles_model.dart';
import '../../models/sources_model.dart';
import '../config/constants.dart';

class ApiManager {
  static Future<List<Source>> fetchSourcesList(String categoryID) async {
    var url = Uri.https(
      Constants.domain,
      "/v2/top-headlines/sources",
      {
        "apiKey": Constants.apiKey,
        "category": categoryID,
      },
    );

    final response = await http.get(url);

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      SourcesModel source = SourcesModel.fromJson(data);

      return source.sources;
    } else {
      throw Exception("Failed to get sources");
    }
  }

  static Future<List<Article>> fetchNews(String query) async {
    var url = Uri.https(
      Constants.domain,
      "/v2/everything",
      {
        "apiKey": Constants.apiKey,
        "q": query,
      },
    );

    final response = await http.get(url);

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      ArticlesModel articles = ArticlesModel.fromJson(data);

      return articles.articles;
    } else {
      throw Exception("Failed to get news");
    }
  }
}