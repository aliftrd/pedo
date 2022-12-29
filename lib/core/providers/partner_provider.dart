import 'package:flutter/cupertino.dart';
import 'package:pedo/config/endpoint.dart';
import 'package:pedo/core/models/animal_model.dart';

class PartnerProvider extends ChangeNotifier {
  bool isLoading = false, isLastPage = false;
  String currentStatus = 'pending';
  int currentPage = 1;
  List<AnimalModel> _animals = [];
  List<AnimalModel> get animals => _animals;
  AnimalModel findById(animalId) =>
      _animals.firstWhere((animal) => animal.id == animalId);

  Future<void> getPartnerAnimal({
    required String status,
    bool isRefresh = false,
  }) async {
    try {
      isLoading = true;
      currentStatus = status;
      notifyListeners();

      if (currentStatus != status) {
        currentPage = 1;
        isLastPage = false;
        _animals.clear();
      }

      if (isRefresh) {
        currentPage = 1;
        isLastPage = false;
        _animals.clear();
      }

      var response = await Endpoint.urlPartner(
          page: currentPage.toString(), status: status);

      if (response['code'] == 200) {
        List<AnimalModel> animals = [];
        for (var animal in response['data']['data']) {
          _animals.add(AnimalModel.fromJson(animal));
        }

        if (response['data']['next_page_url'] == null) {
          isLastPage = true;
          notifyListeners();
        } else {
          currentPage++;
        }

        isLoading = false;
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
