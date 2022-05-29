import 'dart:io';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:obm_market/modules/advert/models/entities/category.dart';
import 'package:obm_market/views/widgets/message/errorMessage.dart';
import 'package:obm_market/views/widgets/message/successMessage.dart';
import '../models/entities/advert.dart';
import '../repository/advert_repository.dart';

class AdvertCreateController extends GetxController {

  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController priceController = TextEditingController();
  TextEditingController kiloController = TextEditingController();
  TextEditingController cylindreController = TextEditingController();
  TextEditingController modelController = TextEditingController();
  TextEditingController surfaceController = TextEditingController();
  TextEditingController nombreChambreController = TextEditingController();
  TextEditingController nombreSalleBainController = TextEditingController();
  TextEditingController surfaceBalconController = TextEditingController();
  TextEditingController nombrePlacardController = TextEditingController();

  RxString nombrePiece = ''.obs;
  RxString immobilierState = ''.obs;
  RxString dateConstruction = ''.obs;
  RxString situation = ''.obs;
  RxString standing = ''.obs;
  RxString cuisine = ''.obs;
  RxString salleManger = ''.obs;
  RxString stateGenerale = ''.obs;
  RxList<String> access = [''].obs;
  RxList<String> exterior = [''].obs;
  RxList<String> interior = [''].obs;
  RxList<String> serviceInclus = [''].obs;
  RxList<String> typeSol = [''].obs;
  RxList<String> proximite = [''].obs;
  RxList<String> facade = [''].obs;
  RxList<String> toiture = [''].obs;

  RxString city = ''.obs;
  RxString zone = ''.obs;
  RxString type = 'J\'offre'.obs;
  RxBool priceStatus = false.obs;
  RxString traitement = ''.obs;

  // Auto Moto
  RxString marque = ''.obs;
  RxString model = ''.obs;
  RxString autoYear = ''.obs;
  RxString autoType = ''.obs;
  RxString autoState = ''.obs;
  RxString boiteVitesse = ''.obs;
  RxString transmission = ''.obs;
  RxString autoColor = ''.obs;
  RxString typeCarburant = ''.obs;
  RxString nombrePorte = ''.obs;
  RxString nombrePlace = ''.obs;
  RxList<String> autreInformation = [''].obs;
  RxList<String> autoSecurity = [''].obs;
  RxList<String> informationExt = [''].obs;

  RxString state = ''.obs;
  RxString brand = ''.obs;

  RxString typeValidatorState = ''.obs;
  RxString cityValidatorState = ''.obs;
  RxString marqueValidatorState = ''.obs;
  RxString modelValidatorState = ''.obs;
  RxString autoYearValidatorState = ''.obs;
  RxString autoTypeValidatorState = ''.obs;
  RxString autoStateValidatorState = ''.obs;
  RxString stateValidatorState = ''.obs;
  RxString brandValidatorState = ''.obs;

  RxString nombrePieceValidatorState = ''.obs;
  RxString immobilierStateValidatorState = ''.obs;

  RxInt activeStepIndex = 1.obs;

  Rx<Category> category = Rx<Category>(new Category(id: 0, name: '', slug: ''));
  Rx<Category> categoryParent = Rx<Category>(new Category(id: 0, name: '', slug: ''));
  RxList<File> images = [new File('')].obs;
  RxList advertImageId = [].obs;


  late ImagePicker imagePicker;

  final box = GetStorage();

  @override
  void onInit() {
    super.onInit();

    imagePicker = ImagePicker();
    clear();
  }

  @override
  void onClose() {
    super.onClose();
  }

  Future<bool> add() async {
    print('===> Debut de creation');

    final advert = await AdvertRepository().create(
      categoryId: category.value.id,
      token: box.read('token'),
      type: type.value,
      title: titleController.text.trim(),
      description: descriptionController.text.trim(),
      price: int.parse(priceController.text.trim()),
      city: city.value,
      zone: zone.value,
      marque: marque.value,
      model: model.value,
      autoYear: autoYear.value,
      autoType: autoType.value,
      autoState: autoState.value,
      kilo: (kiloController.text.isNotEmpty) ? int.parse(kiloController.text.trim()) : null,
      boiteVitesse: boiteVitesse.value,
      transmission: transmission.value,
      autoColor: autoColor.value,
      typeCarburant: typeCarburant.value,
      nombrePorte: nombrePorte.value,
      nombrePlace: nombrePlace.value,
      autreInformation: autreInformation,
      cylindree: (cylindreController.text.isNotEmpty) ? int.parse(cylindreController.text.trim()) : null,
      autoSecurity: autoSecurity,
      informationExterieur: informationExt,
      surface: (surfaceController.text.isNotEmpty) ? int.parse(surfaceController.text.trim()) : null,
      nombrePiece: nombrePiece.value,
      immobilierState: immobilierState.value,
      access: access,
      nombreChambre: (nombreChambreController.text.isNotEmpty) ? int.parse(nombreChambreController.text.trim()) : null,
      nombreSalleBain: (nombreSalleBainController.text.isNotEmpty) ? int.parse(nombreSalleBainController.text.trim()) : null,
      surfaceBalcon: (surfaceBalconController.text.isNotEmpty) ? int.parse(surfaceBalconController.text.trim()) : null,
      exterior: exterior,
      dateConstruction: dateConstruction.value,
      situation: situation.value,
      standing: standing.value,
      cuisine: cuisine.value,
      salleManger: salleManger.value,
      nombrePlacard: (surfaceBalconController.text.isNotEmpty) ? int.parse(nombrePlacardController.text.trim()) : null,
      interior: interior,
      serviceInclus: serviceInclus,
      typeSol: typeSol,
      toiture: toiture,
      facade: facade,
      proximite: proximite,
      stateGenerale: stateGenerale.value,
      state: state.value,
      brand: brand.value,
      traitement: traitement.value
    );

    if (advert.status == '201') {

      if (images.isNotEmpty) {
        await addAdvertImage(id: advert.id);
        return true;
      }

      return true;
    } else {
      return false;
    }
  }

  addAdvertImage({required int id}) async {
    await AdvertRepository().upload(id: id, files: images, token: box.read('token'));
  }

  void clear() {
    activeStepIndex.value = 1;
    category = Rx<Category>(new Category(id: 0, name: '', slug: ''));
    categoryParent = Rx<Category>(new Category(id: 0, name: '', slug: ''));

    city.value = '';
    zone.value = '';
    type.value = 'J\'offre';
    traitement.value = '';
    titleController.text = '';
    descriptionController.text = '';
    priceController.text = '';
    kiloController.text = '';
    cylindreController.text = '';
    modelController.text = '';
    surfaceController.text = '';
    nombreChambreController.text = '';
    nombreSalleBainController.text = '';
    surfaceBalconController.text = '';
    nombrePlacardController.text = '';

    marque.value = '';
    model.value = '';
    autoYear.value = '';
    autoType.value = '';
    autoState.value = '';
    boiteVitesse.value = '';
    transmission.value = '';
    autoColor.value = '';
    typeCarburant.value = '';
    nombrePorte.value = '';
    nombrePlace.value = '';
    autreInformation.value = [];
    autoSecurity.value = [];
    informationExt.value = [];

    state.value = '';
    brand.value = '';

    nombrePiece.value = '';
    immobilierState.value = '';
    dateConstruction.value = '';
    situation.value = '';
    standing.value = '';
    cuisine.value = '';
    salleManger.value = '';
    stateGenerale.value = '';
    access.value = [];
    exterior.value = [];
    interior.value = [];
    serviceInclus.value = [];
    typeSol.value = [];
    proximite.value = [];
    facade.value = [];
    toiture.value = [];

    typeValidatorState.value = '';
    cityValidatorState.value = '';
    marqueValidatorState.value = '';
    modelValidatorState.value = '';
    autoYearValidatorState.value = '';
    autoTypeValidatorState.value = '';
    autoStateValidatorState.value = '';
    stateValidatorState.value = '';
    brandValidatorState.value = '';
    nombrePieceValidatorState.value = '';
    immobilierStateValidatorState.value = '';

    images.value = [];
  }

  void onAutreInformationSelected(bool? selected, String data) => (selected == true) ? autreInformation.add(data) : autreInformation.remove(data);

  void onAutoSecuritySelected(bool? selected, String data) => (selected == true) ? autoSecurity.add(data) : autoSecurity.remove(data);

  void onInformationExtSelected(bool? selected, String data) => (selected == true) ? informationExt.add(data) : informationExt.remove(data);

  void onProximiteSelected(bool? selected, String data) => (selected == true) ? proximite.add(data) : proximite.remove(data);

  void onServiceInclusSelected(bool? selected, String data) => (selected == true) ? serviceInclus.add(data) : serviceInclus.remove(data);

  void onTypeSolSelected(bool? selected, String data) => (selected == true) ? typeSol.add(data) : typeSol.remove(data);

  void onInteriorSelected(bool? selected, String data) => (selected == true) ? interior.add(data) : interior.remove(data);

  void onExteriorSelected(bool? selected, String data) => (selected == true) ? exterior.add(data) : exterior.remove(data);

  void onAccessSelected(bool? selected, String data) => (selected == true) ? access.add(data) : access.remove(data);

  void onFacadeSelected(bool? selected, String data) => (selected == true) ? facade.add(data) : facade.remove(data);

  void onToitureSelected(bool? selected, String data) => (selected == true) ? toiture.add(data) : toiture.remove(data);

  addImage() async {
    List<XFile>? files = await imagePicker.pickMultiImage();

    if (files != null && files.isNotEmpty) {
      files.forEach((file) => images.add(File(file.path)));
    }
  }

  deleteImage(File file) async {
    images.remove(file);
  }

  void initImmoState() {
    immobilierState.value = 'Vide';
  }

  void initState() {
    state.value = 'Quasi neuf';
  }

  hydrate({required Advert advert}) {
    activeStepIndex.value = 1;
    print(advert.location);

    city.value = advert.location!['name'];
    zone.value = (advert.location!['detail'] != null) ? advert.location!['detail'] : '';
    traitement.value = (advert.traitement != null && advert.traitement!.isNotEmpty) ? advert.traitement! : '';
    titleController.text = advert.title;
    descriptionController.text = advert.description;
    priceController.text = advert.price.toString();
    kiloController.text = (advert.kilo != null && advert.kilo.toString().isNotEmpty) ? advert.kilo.toString() : '';
    cylindreController.text = (advert.cylindree != null && advert.cylindree.toString().isNotEmpty) ? advert.cylindree.toString() : '';
    modelController.text = advert.model!;
    surfaceController.text = (advert.surface != null && advert.surface.toString().isNotEmpty) ? advert.surface.toString() : '';
    nombreChambreController.text = (advert.nombreChambre != null && advert.nombreChambre.toString().isNotEmpty) ? advert.nombreChambre.toString() : '';
    nombreSalleBainController.text = (advert.nombreSalleBain != null && advert.nombreSalleBain.toString().isNotEmpty) ? advert.nombreSalleBain.toString() : '';
    surfaceBalconController.text = (advert.surfaceBalcon != null && advert.surfaceBalcon.toString().isNotEmpty) ? advert.surfaceBalcon.toString() : '';
    nombrePlacardController.text = (advert.nombrePlacard != null && advert.nombrePlacard.toString().isNotEmpty) ? advert.nombrePlacard.toString() : '';

    marque.value = advert.marque!;
    model.value = advert.model!;
    autoYear.value = advert.autoYear!;
    autoType.value = advert.autoType!;
    autoState.value = advert.autoState!;
    boiteVitesse.value = advert.boiteVitesse!;
    transmission.value = advert.transmission!;
    autoColor.value = advert.autoColor!;
    typeCarburant.value = advert.typeCarburant!;
    nombrePorte.value = advert.nombrePorte!;
    nombrePlace.value = advert.nombrePlace!;
    autreInformation.value = advert.autreInformation!;
    autoSecurity.value = advert.autoSecurity!;
    informationExt.value = advert.informationExterieur!;

    state.value = advert.state!;
    brand.value = advert.brand!;

    nombrePiece.value = advert.nombrePiece!;
    immobilierState.value = advert.immobilierState!;
    dateConstruction.value = advert.dateConstruction!;
    situation.value = advert.situation!;
    standing.value = advert.standing!;
    cuisine.value = advert.cuisine!;
    salleManger.value = advert.salleManger!;
    stateGenerale.value = advert.stateGenerale!;
    access.value = advert.access!;
    exterior.value = advert.exterior!;
    interior.value = advert.interior!;
    serviceInclus.value = advert.serviceInclus!;
    typeSol.value = advert.typeSol!;
    proximite.value = advert.proximite!;
    facade.value = advert.facade!;
    toiture.value = advert.toiture!;

    typeValidatorState.value = '';
    cityValidatorState.value = '';
    marqueValidatorState.value = '';
    modelValidatorState.value = '';
    autoYearValidatorState.value = '';
    autoTypeValidatorState.value = '';
    autoStateValidatorState.value = '';
    stateValidatorState.value = '';
    brandValidatorState.value = '';
    nombrePieceValidatorState.value = '';
    immobilierStateValidatorState.value = '';

    images.value = [];
  }

  deleteImageServer({required int id}) async {
    final response = await AdvertRepository().deletePicture(id: id, token: box.read('token'));

    if (response.status == '204') {
      advertImageId.remove(id);
      showSuccessMessage(message: "L'image a été supprimée");
    } else {
      showErrorMessage("Erreur lors de la suppression de l'image");
    }
  }

  Future<bool> edit({required int id}) async {
    print('===> Debut de edition');

    final advert = await AdvertRepository().edit(
        id: id,
        token: box.read('token'),
        title: titleController.text.trim(),
        description: descriptionController.text.trim(),
        price: int.parse(priceController.text.trim()),
        city: city.value,
        zone: zone.value,
        marque: marque.value,
        model: model.value,
        autoYear: autoYear.value,
        autoType: autoType.value,
        autoState: autoState.value,
        kilo: (kiloController.text.isNotEmpty) ? int.parse(kiloController.text.trim()) : null,
        boiteVitesse: boiteVitesse.value,
        transmission: transmission.value,
        autoColor: autoColor.value,
        typeCarburant: typeCarburant.value,
        nombrePorte: nombrePorte.value,
        nombrePlace: nombrePlace.value,
        autreInformation: autreInformation,
        cylindree: (cylindreController.text.isNotEmpty) ? int.parse(cylindreController.text.trim()) : null,
        autoSecurity: autoSecurity,
        informationExterieur: informationExt,
        surface: (surfaceController.text.isNotEmpty) ? int.parse(surfaceController.text.trim()) : null,
        nombrePiece: nombrePiece.value,
        immobilierState: immobilierState.value,
        access: access,
        nombreChambre: (nombreChambreController.text.isNotEmpty) ? int.parse(nombreChambreController.text.trim()) : null,
        nombreSalleBain: (nombreSalleBainController.text.isNotEmpty) ? int.parse(nombreSalleBainController.text.trim()) : null,
        surfaceBalcon: (surfaceBalconController.text.isNotEmpty) ? int.parse(surfaceBalconController.text.trim()) : null,
        exterior: exterior,
        dateConstruction: dateConstruction.value,
        situation: situation.value,
        standing: standing.value,
        cuisine: cuisine.value,
        salleManger: salleManger.value,
        nombrePlacard: (surfaceBalconController.text.isNotEmpty) ? int.parse(nombrePlacardController.text.trim()) : null,
        interior: interior,
        serviceInclus: serviceInclus,
        typeSol: typeSol,
        toiture: toiture,
        facade: facade,
        proximite: proximite,
        stateGenerale: stateGenerale.value,
        state: state.value,
        brand: brand.value,
        traitement: traitement.value
    );

    if (advert.status == '200') {

      if (images.isNotEmpty) {
        await addAdvertImage(id: advert.id);
        return true;
      }

      return true;
    } else {
      return false;
    }
  }

  getImagesId({required Advert advert}) {
    if (advert.images.length > 0) {
      advert.images.forEach((element) {advertImageId.add(element['id']);});
    }
  }
}

