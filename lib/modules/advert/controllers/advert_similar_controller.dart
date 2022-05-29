import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:obm_market/modules/advert/models/entities/advert.dart';

import '../repository/advert_repository.dart';

class AdvertSimilarController extends GetxController with SingleGetTickerProviderMixin {
  late AnimationController animationController;
  late ScrollController scrollController = ScrollController();

  RxBool isAppbar = false.obs;
  RxString title = ''.obs;
  RxString advertTitle = ''.obs;
  RxInt current = 0.obs;
  RxInt imageCurrent = 0.obs;
  int itemsPerPage = 5;

  @override
  void onInit() {
    super.onInit();

    animationController = AnimationController(duration: const Duration(milliseconds: 1000), vsync: this);
    setData();

    scrollController.addListener(() {
      if (scrollController.offset >= (Get.width / 1.2) - 80.0) {
        isAppbar.value = true;
        title.value = advertTitle.value;
      } else if (scrollController.offset <= (Get.width / 1.2) - 80.0) {
        isAppbar.value = false;
        title.value = '';
      }
    });
  }

  @override
  void onClose() {
    animationController.dispose();
    scrollController.dispose();

    super.onClose();
  }


  Future<void> setData() async {
    animationController.forward();
  }

  Map getData(Advert advert) {

    Map data = {};

    data.addAll({
      if (advert.marque!.isNotEmpty) 'Marque': '${advert.marque}',
      if (advert.model!.isNotEmpty) 'Modèle': '${advert.model}',
      if (advert.traitement!.isNotEmpty) 'Traitement': '${advert.traitement}',
      if (advert.autoYear!.isNotEmpty) 'Année': '${advert.autoYear}',
      if (advert.autoType!.isNotEmpty) 'Type de véhicule': '${advert.autoType}',
      if (advert.autoState!.isNotEmpty) 'Etat du véhicule': '${advert.autoState}',
      if (advert.kilo != null) 'Kilométrage (Km)': '${advert.kilo}',
      if (advert.boiteVitesse!.isNotEmpty) 'Boite à vitesse': '${advert.boiteVitesse}',
      if (advert.transmission!.isNotEmpty) 'Transmission': '${advert.transmission}',
      if (advert.autoColor!.isNotEmpty) 'Couleur': '${advert.autoColor}',
      if (advert.typeCarburant!.isNotEmpty) 'Type de carburant': '${advert.typeCarburant}',
      if (advert.nombrePorte!.isNotEmpty) 'Nombre de portes': '${advert.nombrePorte}',
      if (advert.nombrePlace!.isNotEmpty) 'Nombre de places': '${advert.nombrePlace}',
      if (advert.autreInformation!.isNotEmpty) 'Autres informations': advert.autreInformation!.join('\n'),
      if (advert.cylindree != null) 'Cylindrée (Cm3)': advert.cylindree,
      if (advert.autoSecurity!.isNotEmpty) 'Sécurité et confort': advert.autoSecurity!.join('\n'),
      if (advert.informationExterieur!.isNotEmpty) 'Elements extérieurs': advert.informationExterieur!.join('\n'),
      if (advert.surface != null) 'Surface': advert.surface,
      if (advert.nombrePiece!.isNotEmpty) 'Nombre de pièces': advert.nombrePiece,
      if (advert.immobilierState!.isNotEmpty) 'Etat': advert.immobilierState,
      if (advert.nombreChambre != null) 'Nombre de chambres': advert.nombreChambre,
      if (advert.nombreSalleBain != null) 'Nombre de salles de bain': advert.nombreSalleBain,
      if (advert.surfaceBalcon != null) 'Surface du balcon': advert.surfaceBalcon,
      if (advert.access!.isNotEmpty) 'Accès': advert.access!.join('\n'),
      if (advert.exterior!.isNotEmpty) 'Extérieures': advert.exterior!.join('\n'),
      if (advert.dateConstruction!.isNotEmpty) 'Date de construction': advert.dateConstruction,
      if (advert.situation!.isNotEmpty) 'Situation': advert.situation,
      if (advert.standing!.isNotEmpty) 'Standing': advert.standing,
      if (advert.cuisine!.isNotEmpty) 'Cuisine': advert.cuisine,
      if (advert.salleManger!.isNotEmpty) 'Salle à manger': advert.salleManger,
      if (advert.nombrePlacard != null) 'Nombre de placards': advert.nombrePlacard,
      if (advert.interior!.isNotEmpty) 'Intérieur': advert.interior!.join('\n'),
      if (advert.serviceInclus!.isNotEmpty) 'Services inclus': advert.serviceInclus!.join('\n'),
      if (advert.typeSol!.isNotEmpty) 'Type de sol': advert.typeSol!.join('\n'),
      if (advert.proximite!.isNotEmpty) 'Proximité': advert.proximite!.join('\n'),
      if (advert.stateGenerale!.isNotEmpty) 'Etat général': advert.stateGenerale,
      if (advert.facade!.isNotEmpty) 'Façade': advert.facade!.join('\n'),
      if (advert.toiture!.isNotEmpty) 'Toiture': advert.toiture!.join('\n'),
      if (advert.state!.isNotEmpty) 'Etat du produit': advert.state,
      if (advert.brand!.isNotEmpty) 'Marque': advert.brand,
    });

    return data;
  }

  Future<List<Advert>> getSimilar(int id) async {
    return await AdvertRepository().getSimilar(page: 1, itemsPerPage: itemsPerPage, id: id);
  }
}

