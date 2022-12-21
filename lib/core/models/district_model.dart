class DistrictModel {
  late int id;
  late String name;

  DistrictModel({
    required this.id,
    required this.name,
  });

  DistrictModel.fromJson(Map<String, dynamic> json) {
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
