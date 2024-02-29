class AnimalBreedModel {
  late int id;
  late String title;

  AnimalBreedModel({
    required this.id,
    required this.title,
  });

  AnimalBreedModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
    };
  }
}
