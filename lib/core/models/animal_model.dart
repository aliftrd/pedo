import 'package:pedo/core/models/animal_breed_model.dart';
import 'package:pedo/core/models/animal_image_model.dart';
import 'package:pedo/core/models/animal_type_model.dart';
import 'package:pedo/core/models/user_meta_model.dart';

class AnimalModel {
  late int id, price;
  late String title, description, gender, status, primaryColor, secondaryColor;
  late bool isPaid;
  late DateTime createdAt, updatedAt;
  late List<AnimalImageModel> images;
  late AnimalTypeModel type;
  late AnimalBreedModel breed;
  late UserMetaModel userMeta;

  AnimalModel({
    required this.id,
    required this.price,
    required this.title,
    required this.description,
    required this.images,
    required this.gender,
    required this.status,
    required this.primaryColor,
    required this.secondaryColor,
    required this.isPaid,
    required this.createdAt,
    required this.updatedAt,
  });

  AnimalModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    price = json['price'];
    title = json['title'];
    description = json['description'];
    images = json['animal_images']
        .map<AnimalImageModel>((image) => AnimalImageModel.fromJson(image))
        .toList();
    gender = json['gender'];
    status = json['status'];
    primaryColor = json['primary_color'];
    secondaryColor = json['secondary_color'];
    isPaid = json['is_paid'] == 1 ? true : false;
    type = AnimalTypeModel.fromJson(json['animal_type']);
    breed = AnimalBreedModel.fromJson(json['animal_breed']);
    userMeta = UserMetaModel.fromJson(json['user_meta']);
    createdAt = DateTime.parse(json['created_at']);
    updatedAt = DateTime.parse(json['updated_at']);
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'price': price,
      'title': title,
      'description': description,
      'images': images.map((image) => image.toJson()).toList(),
      'gender': gender,
      'status': status,
      'primaryColor': primaryColor,
      'secondaryColor': secondaryColor,
      'isPaid': isPaid,
      'type': type.toJson(),
      'breed': breed.toJson(),
      'user_meta': userMeta.toJson(),
      'createdAt': createdAt,
      'updatedAt': updatedAt,
    };
  }
}
