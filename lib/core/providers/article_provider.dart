import 'package:flutter/cupertino.dart';
import 'package:pedo/config/endpoint.dart';
import 'package:pedo/core/models/article_model.dart';

class ArticleProvider extends ChangeNotifier {
  bool isLoading = false, isLastPage = false;
  int currentPage = 1;
  List<ArticleModel> _articles = [];
  List<ArticleModel> get articles => _articles;
  ArticleModel findById(articleId) =>
      _articles.firstWhere((article) => article.id == articleId);

  ArticleProvider() {
    getArticles();
  }

  ScrollController onScrollEvent() {
    final ScrollController scrollController = ScrollController();

    scrollController.addListener(() {
      if (scrollController.position.pixels ==
          scrollController.position.maxScrollExtent) {
        if (!isLastPage) {
          getArticles(isHome: false);
        }
      }
    });

    return scrollController;
  }

  Future<void> getArticles({
    bool isHome = true,
    bool isRefresh = false,
  }) async {
    try {
      isLoading = true;
      notifyListeners();

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
