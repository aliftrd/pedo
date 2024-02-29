import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:pedo/config/endpoint.dart';
import 'package:pedo/core/models/animal_breed_model.dart';
import 'package:pedo/core/models/animal_type_model.dart';

class PartnerPostProvider extends ChangeNotifier {
  List<AnimalTypeModel> _animalTypes = [];
  List<AnimalBreedModel> _animalBreeds = [];
  List<AnimalTypeModel> get animalTypes => _animalTypes;
  List<AnimalBreedModel> get animalBreeds => _animalBreeds;

  PartnerPostProvider() {
    if (_animalTypes.isNotEmpty) _animalTypes.clear();
    if (_animalBreeds.isNotEmpty) _animalBreeds.clear();

    getAnimalType();
  }

  Future addAnimal({
    required String animalName,
    required String animalDescription,
    required String animalTypeId,
    required String animalBreedId,
    required String animalGender,
    required String animalColorPrimary,
    required String animalColorSecondary,
    required String animalIsPaid,
    required String animalPrice,
    required List<File> animalImages,
  }) async {
    try {
      List images = [];
      for (File animalImage in animalImages) {
        images.add(base64Encode(animalImage.readAsBytesSync()));
      }

      Map<String, dynamic> body = {
        'images': images,
        'animal_type_id': animalTypeId,
        'animal_breed_id': animalBreedId,
        'title': animalName,
        'description': animalDescription,
        'is_paid': animalIsPaid,
        'price': animalPrice,
        'gender': animalGender,
        'primary_color': animalColorPrimary,
        'secondary_color': animalColorSecondary,
      };

      var response = await Endpoint.urlAnimalAdd(body);
      if (response['code'] == 200) {
        return response;
      } else {
        return response;
      }
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  Future updateAnimal({
    required String animalId,
    required String animalName,
    required String animalDescription,
    required String animalTypeId,
    required String animalBreedId,
    required String animalGender,
    required String animalColorPrimary,
    required String animalColorSecondary,
    required String animalIsPaid,
    required String animalPrice,
    required List<File> animalImages,
  }) async {
    try {
      List images = [];
      for (File animalImage in animalImages) {
        images.add(base64Encode(animalImage.readAsBytesSync()));
      }

      Map<String, dynamic> body = {
        'id': animalId,
        'images': images,
        'animal_type_id': animalTypeId,
        'animal_breed_id': animalBreedId,
        'title': animalName,
        'description': animalDescription,
        'is_paid': animalIsPaid,
        'price': animalPrice,
        'gender': animalGender,
        'primary_color': animalColorPrimary,
        'secondary_color': animalColorSecondary,
      };

      var response = await Endpoint.urlAnimalEdit(body);
      if (response['code'] == 200) {
        return response;
      } else {
        return response;
      }
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  Future updateAdoptAnimal({
    required String animalId,
  }) async {
    try {
      Map<String, dynamic> body = {
        'id': animalId,
      };

      var response = await Endpoint.urlAnimalAdopt(body);
      if (response['code'] == 200) {
        return response;
      } else {
        return response;
      }
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  Future<void> getAnimalType() async {
    try {
      var response = await Endpoint.urlAnimalType();
      if (response['code'] == 200) {
        for (var type in response['data']) {
          _animalTypes.add(AnimalTypeModel.fromJson(type));
        }
        notifyListeners();

        return response;
      } else {
        return response;
      }
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  Future<void> getAnimalBreed(String animalTypeId) async {
    try {
      if (_animalBreeds.isNotEmpty) _animalBreeds.clear();

      var response = await Endpoint.urlAnimalBreed(animalTypeId);
      if (response['code'] == 200) {
        for (var breed in response['data']) {
          _animalBreeds.add(AnimalBreedModel.fromJson(breed));
        }
        notifyListeners();

        return response;
      } else {
        return response;
      }
    } catch (e) {
      debugPrint(e.toString());
    }
  }
}
