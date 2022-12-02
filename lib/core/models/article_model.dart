import 'package:pedo/core/models/article_category_model.dart';

class ArticleModel {
  late int id;
  late String title, slug, description, thumbnail;
  late DateTime createdAt, updatedAt;
  late List<ArticleCategoryModel> categories;

  ArticleModel({
    required this.id,
    required this.title,
    required this.slug,
    required this.description,
    required this.thumbnail,
    required this.createdAt,
    required this.updatedAt,
  });

  ArticleModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    slug = json['slug'];
    description = json['description'];
    thumbnail = json['thumbnail'];
    categories = json['categories']
        .map<ArticleCategoryModel>(
            (category) => ArticleCategoryModel.fromJson(category))
        .toList();
    createdAt = DateTime.parse(json['created_at']);
    updatedAt = DateTime.parse(json['updated_at']);
  }

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'slug': slug,
      'description': description,
      'thumbnail': thumbnail,
      'categories': categories.map((category) => category.toJson()).toList(),
      'createdAt': createdAt,
      'updatedAt': updatedAt,
    };
  }
}
