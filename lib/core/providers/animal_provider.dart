import 'package:flutter/cupertino.dart';
import 'package:pedo/config/endpoint.dart';
import 'package:pedo/core/models/animal_model.dart';

class AnimalProvider extends ChangeNotifier {
  bool isLoading = false, isLastPage = false;
  int currentPage = 1;
  List<AnimalModel> _animals = [];
  List<AnimalModel> get animals => _animals;
  AnimalModel findById(animalId) =>
      _animals.firstWhere((animal) => animal.id == animalId);

  AnimalProvider() {
    getAnimals();
  }

  ScrollController onScrollEvent() {
    final ScrollController scrollController = ScrollController();

    scrollController.addListener(() {
      if (scrollController.position.pixels ==
          scrollController.position.maxScrollExtent) {
        if (animals.isNotEmpty && isLastPage != true) {
          getAnimals(isHome: false);
        }
      }
    });

    return scrollController;
  }

  Future getAnimalDetail(String animalId) async {
    try {
      var response = await Endpoint.urlAnimalDetail(animalId);
      if (response['code'] == 200) {
        AnimalModel animalDetail =
            AnimalModel.fromJson(response['data']['data']);

        return animalDetail;
      } else {
        throw response;
      }
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  Future<void> getAnimals({
    bool isHome = true,
    bool isRefresh = false,
  }) async {
    try {
      isLoading = true;
      notifyListeners();

      if (isHome) {
        currentPage = 1;
        isLastPage = false;
        _animals.clear();
      }

      if (isRefresh) {
        currentPage = 1;
        isLastPage = false;
        _animals.clear();
      }

      var response = await Endpoint.urlAnimal(page: currentPage.toString());
      if (response['code'] == 200) {
        for (var animal in response['data']['data']) {
          _animals.add(AnimalModel.fromJson(animal));
        }

        if (response['data']['next_page_url'] == null) {
          isLastPage = true;
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
