class AnimalTypeModel {
  late int id;
  late String title;

  AnimalTypeModel({
    required this.id,
    required this.title,
  });

  AnimalTypeModel.fromJson(Map<String, dynamic> json) {
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
