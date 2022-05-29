import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:obm_market/modules/advert/models/entities/advert.dart';
import 'package:obm_market/modules/advert/models/entities/category.dart';
import 'package:obm_market/modules/location/models/entities/city.dart';
import '../repository/advert_repository.dart';

class AdvertSearchController extends GetxController with StateMixin<List<Advert>>, SingleGetTickerProviderMixin {

  Rx<Category> category = Rx<Category>(new Category(id: 0, name: ''));
  Rx<City> city = Rx<City>(new City(name: '', countryCode: '', slug: ''));

  late AnimationController animationController;
  int itemsPerPage = 3;
  RxInt page = 1.obs;
  RxInt totalItem = 0.obs;
  RxInt lastPage = 0.obs;
  RxInt firstPage = 0.obs;
  RxMap filter = RxMap({});
  RxBool positionOrderState = true.obs;
  RxBool priceOrderDescState = false.obs;
  RxBool priceOrderAscState = false.obs;

  @override
  void onInit() {
    super.onInit();

    animationController = AnimationController(duration: const Duration(milliseconds: 2000), vsync: this);

    ever(filter, (value) {getAdverts();});
    ever(page, (value) {getAdverts();});
  }

  @override
  void onClose() {
    super.onClose();

    animationController.dispose();
  }

  getAdverts() async {
    change(null, status: RxStatus.loading());

    final response = await AdvertRepository().getAdvertList(
      page: page.value,
      itemsPerPage: itemsPerPage,
      positionOrder: filter['positionOrder'],
      priceOrder: filter['priceOrder'],
      city: filter['city']
    );

    totalItem.value = response.totalItems;

    lastPage.value = int.parse(
      (response.hydraView.containsKey('hydra:last')) ?
      response.hydraView['hydra:last'].toString().substring(response.hydraView['hydra:last'].toString().length-1) :
      '1'
    );

    firstPage.value = int.parse(
      (response.hydraView.containsKey('hydra:first')) ?
      response.hydraView['hydra:first'].toString().substring(response.hydraView['hydra:first'].toString().length-1) :
      '1'
    );

    if (response.adverts.isNotEmpty) {
      change(response.adverts, status: RxStatus.success());

    } else if(response.adverts.isEmpty) {
      change(null, status: RxStatus.error('Aucun élément trouvé'));

    } else {
      change(null, status: RxStatus.empty());
    }
  }

  void changeCategory(Category data) => category.value = data;

  void changeCity(City data) => city.value = data;

  changePositionOrderState(bool value) => positionOrderState.value = value;

  changePriceOrderDescState(bool value) => priceOrderDescState.value = value;

  changePriceOrderAscState(bool value) => priceOrderAscState.value = value;
}


