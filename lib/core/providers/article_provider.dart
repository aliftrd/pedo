import 'package:flutter/cupertino.dart';
import 'package:pedo/config/endpoint.dart';
import 'package:pedo/core/models/article_model.dart';

class ArticleProvider extends ChangeNotifier {
  bool isLoading = false, isLastPage = false;
  int currentPage = 1;
  List<ArticleModel> _articles = [];
  List<ArticleModel> get articles => _articles;

  Future<void> getArticles({
    bool isHome = true,
    bool isRefresh = false,
  }) async {
    try {
      if (isHome) {
        currentPage = 1;
        isLastPage = false;
        _articles.clear();
      }

      if (isRefresh) {
        currentPage = 1;
        isLastPage = false;
        _articles.clear();
      }

      var response = await Endpoint.urlArticle(page: currentPage.toString());
      if (response['code'] == 200) {
        List<ArticleModel> articles = [];
        for (var article in response['data']['data']) {
          _articles.add(ArticleModel.fromJson(article));
        }

        if (response['data']['next_page_url'] == null) {
          isLastPage = true;
        } else {
          currentPage++;
        }

        isLoading = false;
        notifyListeners();
        return response;
      } else {
        return response;
      }
    } catch (e) {
      debugPrint(e.toString());
    }
  }
}
