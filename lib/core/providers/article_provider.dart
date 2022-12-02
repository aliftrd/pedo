import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart';
import 'package:pedo/constant/api_path.dart';
import 'package:pedo/core/models/article_model.dart';
import 'package:pedo/utils/secure_storage_service.dart';

class ArticleHomeProvider extends ChangeNotifier {
  bool isLoading = false;
  List<ArticleModel> _articles = [];
  List<ArticleModel> get articles => _articles;

  ArticleHomeProvider() {
    getArticles();
  }

  Future<void> getArticles() async {
    isLoading = true;
    notifyListeners();

    try {
      Uri articleUrl = Uri.https(BASE_URL, '/api/articles.php');
      String token = await SecureStorageService.getToken();
      var headers = {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': token,
      };

      var response = await get(articleUrl, headers: headers);

      if (response.statusCode == 200) {
        var data = jsonDecode(response.body);
        List<ArticleModel> articles = [];

        for (var article in data['data']['data']) {
          articles.add(ArticleModel.fromJson(article));
        }

        _articles = articles;
      } else {
        throw Exception('Failed load articles');
      }
    } catch (e) {
      debugPrint(e.toString());
    }

    isLoading = false;
    notifyListeners();
  }
}

class ArticlePageProvider extends ChangeNotifier {
  bool isLoading = false, isLastPage = false;

  int currentPage = 1;
  List<ArticleModel> _articles = [];
  List<ArticleModel> get articles => _articles;

  ArticlePageProvider() {
    getArticles();
  }

  Future<void> getArticles({
    bool isRefresh = false,
  }) async {
    if (isRefresh) {
      currentPage = 1;
      isLastPage = false;
      _articles.clear();
    }

    isLoading = true;
    notifyListeners();

    try {
      Uri articleUrl = Uri.https(BASE_URL, '/api/articles.php', {
        'page': currentPage.toString(),
      });
      print(articleUrl);

      String token = await SecureStorageService.getToken();
      var headers = {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': token,
      };

      var response = await get(articleUrl, headers: headers);

      if (response.statusCode == 200) {
        var data = jsonDecode(response.body);

        for (var article in data['data']['data']) {
          _articles.add(ArticleModel.fromJson(article));
        }
        if (data['data']['next_page_url'] == null) {
          isLastPage = true;
        } else {
          currentPage++;
        }
      } else {
        throw Exception('Failed load articles');
      }
    } catch (e) {
      debugPrint(e.toString());
    }

    isLoading = false;
    notifyListeners();
  }
}
