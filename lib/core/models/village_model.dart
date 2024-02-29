class VillageModel {
  late int id;
  late String name;

  VillageModel({
    required this.id,
    required this.name,
  });

  VillageModel.fromJson(Map<String, dynamic> json) {
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
