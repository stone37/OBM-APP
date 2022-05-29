import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:obm_market/modules/advert/models/entities/advert.dart';
import 'package:obm_market/modules/advert/models/entities/category.dart';
import 'package:obm_market/modules/advert/repository/advert_repository.dart';

class AdvertSubCategoryController extends GetxController with StateMixin<List<Advert>>, SingleGetTickerProviderMixin {

  late AnimationController animationController;
  Rx<Category> category = new Category(id: 0, name: '').obs;
  Rx<Category> categoryParent = new Category(id: 0, name: '').obs;
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
  List<String> immoStateList = ['Meuble', 'Vide'];
  List<String> stateDList = ['Neuf', 'Quasi neuf', 'Occasion', 'A rénover'];
  TextEditingController priceMinController = TextEditingController();
  TextEditingController priceMaxController = TextEditingController();
  TextEditingController kiloMinController = TextEditingController();
  TextEditingController kiloMaxController = TextEditingController();
  TextEditingController surfaceMinController = TextEditingController();
  TextEditingController surfaceMaxController = TextEditingController();
  TextEditingController nombreChambreController = TextEditingController();
  TextEditingController nombreSalleBainController = TextEditingController();

  RxBool typeOffertState = false.obs;
  RxBool typeSearchState = false.obs;
  RxBool typeTrocState = false.obs;
  RxBool typeDonState = false.obs;
  RxString type = ''.obs;
  RxString city = ''.obs;
  RxString zone = ''.obs;

  RxString marque = ''.obs;
  RxString model = ''.obs;
  RxString typeCarburant = ''.obs;
  RxString autoYearMin = ''.obs;
  RxString autoYearMax = ''.obs;

  RxBool immoVoidState = false.obs;
  RxBool immoInState = false.obs;
  RxString immobilierState = ''.obs;
  RxString nombrePiece = ''.obs;
  RxList<String> access = [''].obs;
  RxList<String> exterior = [''].obs;
  RxList<String> interior = [''].obs;
  RxList<String> proximite = [''].obs;

  RxBool neufState = false.obs;
  RxBool qNeufState = false.obs;
  RxBool occasionState = false.obs;
  RxBool renoverState = false.obs;
  RxString stateD = ''.obs;
  RxString brand = ''.obs;

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
      marque: filter['marque'],
      model: filter['model'],
      typeCarburant: filter['typeCarburant'],
      kiloMin: (filter['kiloMin'] != null && filter['kiloMin'].toString().isNotEmpty) ? int.parse(filter['kiloMin']) : null,
      kiloMax: (filter['kiloMax'] != null && filter['kiloMax'].toString().isNotEmpty) ? int.parse(filter['kiloMax']) : null,
      autoYearMin: filter['autoYearMin'],
      autoYearMax: filter['autoYearMax'],
      surfaceMin: (filter['surfaceMin'] != null && filter['surfaceMin'].toString().isNotEmpty) ? int.parse(filter['surfaceMin']) : null,//filter['surfaceMin'],
      surfaceMax: (filter['surfaceMax'] != null && filter['surfaceMax'].toString().isNotEmpty) ? int.parse(filter['surfaceMax']) : null,//filter['surfaceMax'],
      immoState: filter['immoState'],
      nombrePiece: filter['nombrePiece'],
      nombreChambre: (filter['nombreChambre'] != null && filter['nombreChambre'].toString().isNotEmpty) ? int.parse(filter['nombreChambre']) : null,//filter['nombreChambre'],
      nombreSalleBain: (filter['nombreSalleBain'] != null && filter['nombreSalleBain'].toString().isNotEmpty) ? int.parse(filter['nombreSalleBain']) : null,//filter['nombreSalleBain'],
      brand: (filter['brand'] != null && filter['brand'].isNotEmpty) ? filter['brand'] : null,//filter['brand'],
      state: (filter['state'] != null && filter['state'].isNotEmpty) ? filter['state'] : null
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

    kiloMinController.text = '';
    kiloMaxController.text = '';
    marque.value = '';
    model.value = '';
    typeCarburant.value = '';
    autoYearMin.value = '';
    autoYearMax.value = '';

    surfaceMinController.text = '';
    surfaceMaxController.text = '';
    nombreChambreController.text = '';
    nombreSalleBainController.text = '';

    immobilierState.value = '';
    nombrePiece.value = '';
    access.value = [''];
    exterior.value = [''];
    interior.value = [''];
    proximite.value = [''];
    stateD.value = '';
    brand.value = '';

    typeOffertState.value = false;
    typeSearchState.value = false;
    typeTrocState.value = false;
    typeDonState.value = false;
    immoVoidState.value = false;
    immoInState.value = false;
    neufState.value = false;
    qNeufState.value = false;
    occasionState.value = false;
    renoverState.value = false;

    Map<String, dynamic> data = {
      'type': '',
      'priceMin': '',
      'priceMax': '',
      'city': '',
      'zone': '',
      'marque': '',
      'model': '',
      'typeCarburant': '',
      'kiloMin': '',
      'kiloMax': '',
      'autoYearMin': '',
      'autoYearMax': '',
      'surfaceMin': '',
      'surfaceMax': '',
      'immoState': '',
      'nombrePiece': '',
      'nombreChambre': '',
      'nombreSalleBain': '',
      'access': '',
      'proximite': '',
      'exterior': '',
      'interior': '',
      'brand': '',
      'state': '',
    };

    filter.addAll(data);
  }

  changePositionOrderState(bool value) => positionOrderState.value = value;

  changePriceOrderDescState(bool value) => priceOrderDescState.value = value;

  changePriceOrderAscState(bool value) => priceOrderAscState.value = value;

  void onInteriorSelected(bool? selected, String data) => (selected == true) ? interior.add(data) : interior.remove(data);

  void onExteriorSelected(bool? selected, String data) => (selected == true) ? exterior.add(data) : exterior.remove(data);

  void onAccessSelected(bool? selected, String data) => (selected == true) ? access.add(data) : access.remove(data);

  void onProximiteSelected(bool? selected, String data) => (selected == true) ? proximite.add(data) : proximite.remove(data);

  initCategory() {
    category.value = new Category(id: 0, name: '');
  }
}

