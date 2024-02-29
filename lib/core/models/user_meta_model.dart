import 'package:pedo/core/models/user_model.dart';
import 'package:pedo/core/models/village_model.dart';

class UserMetaModel {
  late int id;
  late String phone, type;
  late UserModel user;
  late VillageModel village;

  UserMetaModel({
    required this.id,
    required this.phone,
    required this.type,
  });

  UserMetaModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    phone = json['phone'];
    type = json['type'];
    user = UserModel.fromJson(json['user']);
    village = VillageModel.fromJson(json['village']);
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'phone': phone,
      'type': type,
      'user': user.toJson(),
      'village': village.toJson(),
    };
  }
}
