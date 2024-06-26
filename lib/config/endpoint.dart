import 'package:pedo/config/network.dart';

class Endpoint {
  static urlLogin({
    required Map<String, dynamic> body,
  }) async {
    return Network().post(
      url: 'login.php',
      body: body,
      useToken: false,
    );
  }

  static urlRegister(
    Map<String, dynamic> body,
  ) async {
    return Network().post(
      url: 'register.php',
      body: body,
      useToken: false,
    );
  }

  static urlLogout() async {
    return Network().post(
      url: 'logout.php',
    );
  }

  static urlProfile() async {
    return Network().get(
      url: 'profile.php',
    );
  }

  static urlUpdateProfile(Map<String, dynamic> body) async {
    return Network().post(
      url: 'profile.php',
      body: body,
    );
  }

  static urlArticle({
    String? page,
  }) async {
    return Network().get(
      url: 'articles.php',
      params: {
        'page': page.toString(),
      },
    );
  }

  static urlAnimal({
    String? page,
  }) async {
    return Network().get(
      url: 'animals.php',
      params: {
        'page': page.toString(),
      },
    );
  }

  static urlAnimalDetail(String animalId) async {
    return Network().get(
      url: 'animals.php',
      params: {
        'animal_id': animalId,
      },
    );
  }

  static urlProvince() async {
    return Network().get(
      url: 'province.php',
    );
  }

  static urlCity(String provinceId) async {
    return Network().get(
      url: 'city.php',
      params: {
        'province_id': provinceId,
      },
    );
  }

  static urlDistrict(String cityId) async {
    return Network().get(
      url: 'district.php',
      params: {
        'city_id': cityId,
      },
    );
  }

  static urlVillage(String districtId) async {
    return Network().get(
      url: 'village.php',
      params: {
        'district_id': districtId,
      },
    );
  }

  static urlRequestPending() async {
    return Network().get(
      url: 'upgrade.php',
    );
  }

  static urlUpgradeUser(Map<String, dynamic> body) async {
    return Network().post(
      url: 'upgrade.php',
      body: body,
    );
  }

  static urlPartner({String? page, String? status}) async {
    return Network().get(
      url: 'partners.php',
      params: {
        'page': page.toString(),
        'status': status.toString(),
      },
    );
  }

  static urlAnimalType() async {
    return Network().get(
      url: 'animals/type.php',
    );
  }

  static urlAnimalBreed(String animalTypeId) async {
    return Network().get(
      url: 'animals/breed.php',
      params: {
        'animal_type_id': animalTypeId,
      },
    );
  }

  static urlAnimalAdd(
    Map<String, dynamic> body,
  ) async {
    return Network().post(
      url: 'partners.php',
      body: body,
    );
  }

  static urlAnimalEdit(
    Map<String, dynamic> body,
  ) async {
    return Network().post(
      url: 'partners.php',
      params: {
        'method': 'update',
      },
      body: body,
    );
  }

  static urlAnimalAdopt(
    Map<String, dynamic> body,
  ) async {
    return Network().post(
      url: 'partners.php',
      params: {
        'method': 'adopted',
      },
      body: body,
    );
  }

  static urlNotification({
    String? page,
  }) async {
    return Network().get(
      url: 'notifications.php',
      params: {
        'page': page.toString(),
      },
    );
  }
}
