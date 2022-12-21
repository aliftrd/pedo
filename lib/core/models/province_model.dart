class ProvinceModel {
  late int id;
  late String name;

  ProvinceModel({
    required this.id,
    required this.name,
  });

  ProvinceModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
    };
  }
}
