import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:obm_market/modules/advert/models/entities/advert.dart';

class AdvertViewController extends GetxController with SingleGetTickerProviderMixin {
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

  /*Map getMapData(Advert advert) {

    Map data = {};

    data.addAll({
      if (advert['marque'] != null) 'Marque': '${advert['marque']}',
      if (advert['model'] != null) 'Modèle': '${advert['model']}',
      if (advert['traitement'] != null) 'Traitement': '${advert['traitement']}',
      if (advert['autoYear'] != null) 'Année': '${advert['autoYear']}',
      if (advert['autoType'] != null) 'Type de véhicule': '${advert['autoType']}',
      if (advert['autoState'] != null) 'Etat du véhicule': '${advert['autoState']}',
      if (advert['kilo'] != null) 'Kilométrage (Km)': '${advert['kilo']}',
      if (advert['boiteVitesse'] != null) 'Boite à vitesse': '${advert['boiteVitesse']}',
      if (advert['transmission'] != null) 'Transmission': '${advert['transmission']}',
      if (advert['autoColor'] != null) 'Couleur': '${advert['autoColor']}',
      if (advert['typeCarburant'] != null) 'Type de carburant': '${advert['typeCarburant']}',
      if (advert['nombrePorte'] != null) 'Nombre de portes': '${advert['nombrePorte']}',
      if (advert['nombrePlace'] != null) 'Nombre de places': '${advert['nombrePlace']}',
      if (advert['autreInformation'] != null) 'Autres informations': advert['autreInformation'].join('\n'),
      if (advert['cylindree'] != null) 'Cylindrée (Cm3)': '${advert['cylindree']}',
      if (advert['autoSecurity'] != null) 'Sécurité et confort': advert['autoSecurity'].join('\n'),
      if (advert['informationExterieur'] != null) 'Elements extérieurs': advert['informationExterieur'].join('\n'),
      if (advert['surface'] != null) 'Surface': advert['surface'],
      if (advert['nombrePiece'] != null) 'Nombre de pièces': advert['nombrePiece'],
      if (advert['immobilierState'] != null) 'Etat': advert['immobilierState'],
      if (advert['nombreChambre'] != null) 'Nombre de chambres': advert['nombreChambre'],
      if (advert['nombreSalleBain '] != null) 'Nombre de salles de bain': advert['nombreSalleBain '],
      if (advert['surfaceBalcon'] != null) 'Surface du balcon': advert['surfaceBalcon'],
      if (advert['access'] != null) 'Accès': advert['access'].join('\n'),
      if (advert['exterior'] != null) 'Extérieures': advert['exterior'].join('\n'),
      if (advert['dateConstruction'] != null) 'Date de construction': advert['dateConstruction'],
      if (advert['situation'] != null) 'Situation': advert['situation'],
      if (advert['standing'] != null) 'Standing': advert['standing'],
      if (advert['cuisine'] != null) 'Cuisine': advert['cuisine'],
      if (advert['salleManger'] != null) 'Salle à manger': advert['salleManger'],
      if (advert['nombrePlacard'] != null) 'Nombre de placards': advert['nombrePlacard'],
      if (advert['interior'] != null) 'Intérieur': advert['interior'].join('\n'),
      if (advert['serviceInclus'] != null) 'Services inclus': advert['serviceInclus'].join('\n'),
      if (advert['typeSol'] != null) 'Type de sol': advert['typeSol'].join('\n'),
      if (advert['proximite'] != null) 'Proximité': advert['proximite'].join('\n'),
      if (advert['stateGenerale'] != null) 'Etat général': advert['stateGenerale'],
      if (advert['facade'] != null) 'Façade': advert['facade'].join('\n'),
      if (advert['toiture'] != null) 'Toiture': advert['toiture'].join('\n'),
      if (advert['state'] != null) 'Etat du produit': advert['state'],
      if (advert['brand'] != null) 'Marque': advert['brand'],
    });

    return data;
  }*/
}

