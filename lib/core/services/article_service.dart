import 'dart:convert';
import 'package:pedo/constant/api_path.dart';
import 'package:http/http.dart';
import 'package:pedo/core/models/article_model.dart';
import 'package:pedo/utils/secure_storage_service.dart';

class ArticleService {
  static Future<List<ArticleModel>> getArticles({
    int? page,
  }) async {
    String token = await SecureStorageService.getToken();

    var uri = Uri.https(BASE_URL, '/api/articles.php', {
      'page': page.toString(),
    });

    var headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': token,
    };

    var response = await get(
      uri,
      headers: headers,
    );

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      List<ArticleModel> articles = [];

      for (var article in data['data']['data']) {
        articles.add(ArticleModel.fromJson(article));
      }

      return articles;
    } else {
      throw Exception('Failed load articles');
    }
  }
}
