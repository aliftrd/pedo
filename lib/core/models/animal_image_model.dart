class AnimalImageModel {
  late int id;
  late String path;

  AnimalImageModel({
    required this.id,
    required this.path,
  });

  AnimalImageModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    path = json['path'];
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'path': path,
    };
  }
}
