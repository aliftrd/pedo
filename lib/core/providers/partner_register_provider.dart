import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:pedo/config/endpoint.dart';
import 'package:pedo/core/models/city_model.dart';
import 'package:pedo/core/models/district_model.dart';
import 'package:pedo/core/models/province_model.dart';
import 'package:pedo/core/models/village_model.dart';

class PartnerRegisterProvider extends ChangeNotifier {
  List<ProvinceModel> _provinces = [];
  List<CityModel> _cities = [];
  List<DistrictModel> _districts = [];
  List<VillageModel> _villages = [];

  List<ProvinceModel> get provinces => _provinces;
  List<CityModel> get cities => _cities;
  List<DistrictModel> get districts => _districts;
  List<VillageModel> get villages => _villages;

  PartnerRegisterProvider() {
    if (_provinces.isNotEmpty) _provinces.clear();
    if (_cities.isNotEmpty) _cities.clear();
    if (_districts.isNotEmpty) _districts.clear();
    if (_villages.isNotEmpty) _villages.clear();

    getProviceList();
  }

  Future<void> getProviceList() async {
    try {
      var response = await Endpoint.urlProvince();

      if (response['code'] == 200) {
        for (var province in response['data']) {
          _provinces.add(ProvinceModel.fromJson(province));
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

  Future<void> getCityList(String provinceId) async {
    try {
      if (_cities.isNotEmpty) _cities.clear();

      var response = await Endpoint.urlCity(provinceId);

      if (response['code'] == 200) {
        for (var city in response['data']) {
          _cities.add(CityModel.fromJson(city));
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

  Future<void> getDistrictList(String cityId) async {
    try {
      if (_districts.isNotEmpty) _districts.clear();

      var response = await Endpoint.urlDistrict(cityId);

      if (response['code'] == 200) {
        for (var district in response['data']) {
          _districts.add(DistrictModel.fromJson(district));
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

  Future<void> getVillageList(String districtId) async {
    try {
      if (_villages.isNotEmpty) _villages.clear();

      var response = await Endpoint.urlVillage(districtId);

      if (response['code'] == 200) {
        for (var village in response['data']) {
          _villages.add(VillageModel.fromJson(village));
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

  Future registerPartner({
    required String phone,
    required String village,
    required File imageOne,
    required File imageTwo,
    required File imageThree,
  }) async {
    try {
      Map<String, dynamic> body = {
        'phone': phone,
        'village_id': village,
        'pet': base64Encode(imageOne.readAsBytesSync()),
        'pet_with_you': base64Encode(imageTwo.readAsBytesSync()),
        'pet_home': base64Encode(imageThree.readAsBytesSync()),
      };
      var response = await Endpoint.urlUpgradeUser(body);

      return response;
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  Future requestPending() async {
    try {
      var response = await Endpoint.urlRequestPending();

      return response;
    } catch (e) {
      debugPrint(e.toString());
    }
  }
}
