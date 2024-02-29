class ArticleCategoryModel {
  late String title, slug;

  ArticleCategoryModel({
    required this.title,
    required this.slug,
  });

  ArticleCategoryModel.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    slug = json['slug'];
  }

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'slug': slug,
    };
  }
}
