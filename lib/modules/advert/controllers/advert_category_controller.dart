import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:obm_market/modules/advert/models/entities/advert.dart';
import 'package:obm_market/modules/advert/models/entities/category.dart';
import 'package:obm_market/modules/advert/repository/advert_repository.dart';

class AdvertCategoryController extends GetxController with StateMixin<List<Advert>>, SingleGetTickerProviderMixin {

  late AnimationController animationController;
  Rx<Category> category = new Category(id: 0, name: '').obs;
  int itemsPerPage = 3;
  RxInt page = 1.obs;
  RxInt totalItem = 0.obs;
  RxInt lastPage = 0.obs;
  RxInt firstPage = 0.obs;
  RxMap filter = RxMap({});
  RxBool positionOrderState = true.obs;
  RxBool priceOrderDescState = false.obs;
  RxBool priceOrderAscState = false.obs;

  // Filter
  List<String> typeList = ['j\'offre', 'je recherche', 'Troc', 'Don'];
  TextEditingController priceMinController = TextEditingController();
  TextEditingController priceMaxController = TextEditingController();

  RxBool typeOffertState = false.obs;
  RxBool typeSearchState = false.obs;
  RxBool typeTrocState = false.obs;
  RxBool typeDonState = false.obs;
  RxString type = ''.obs;
  RxString city = ''.obs;
  RxString zone = ''.obs;

  @override
  void onInit() {
    super.onInit();

    animationController = AnimationController(duration: const Duration(milliseconds: 2000), vsync: this);

    ever(filter, (Map value) {
      if (value.containsKey('page') && value.containsKey('itemsPerPage')) getAdverts();
    });
  }

  @override
  void onClose() {
    animationController.dispose();
    super.onClose();
  }

  fetch(Map<String, dynamic> data) {
    data.addAll({'page': page.value, 'itemsPerPage': itemsPerPage});

    filter.addAll(data);
  }

  getAdverts() async {
    change(null, status: RxStatus.loading());

    final response = await AdvertRepository().getAdvertList(
      page: filter['page'],
      itemsPerPage: filter['itemsPerPage'],
      category: filter['category'],
      levelDepth: filter['levelDepth'],
      positionOrder: filter['positionOrder'],
      priceOrder: filter['priceOrder'],
      type: filter['type'],
      city: filter['city'],
      zone: filter['zone'],
      priceMin: (filter['priceMin'] != null && filter['priceMin'].toString().isNotEmpty) ? int.parse(filter['priceMin']) : null,
      priceMax: (filter['priceMax'] != null && filter['priceMax'].toString().isNotEmpty) ? int.parse(filter['priceMax']) : null,
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

  clear() {
    type.value = '';
    priceMinController.text = '';
    priceMaxController.text = '';
    city.value = '';
    zone.value = '';

    typeOffertState.value = false;
    typeSearchState.value = false;
    typeTrocState.value = false;
    typeDonState.value = false;

    Map<String, dynamic> data = {'type': '', 'priceMin': '', 'priceMax': '', 'city': '', 'zone': ''};
    filter.addAll(data);
  }

  changePositionOrderState(bool value) => positionOrderState.value = value;

  changePriceOrderDescState(bool value) => priceOrderDescState.value = value;

  changePriceOrderAscState(bool value) => priceOrderAscState.value = value;

  initCategory() {
    category.value = new Category(id: 0, name: '');
  }
}

