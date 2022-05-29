import 'package:obm_market/modules/advert/controllers/advert_create_controller.dart';

class AdvertCreateFieldState {
  AdvertCreateFieldState({required this.controller});

  final AdvertCreateController controller;

  bool marqueState() {
    return (controller.category.value.slug == 'voiture-doccasion' ||
        controller.category.value.slug == 'location-de-voiture' ||
        controller.category.value.slug == 'motocross' ||
        controller.category.value.slug == 'scooters-et-minimotos' ||
        controller.category.value.slug == 'motos-sport' ||
        controller.category.value.slug == 'routieres' ||
        controller.category.value.slug == 'autres-motos' ||
        controller.category.value.slug == 'pieces-de-carrosserie' ||
        controller.category.value.slug == 'transmission-et-train-roulant' ||
        controller.category.value.slug == 'pieces-et-accessoires-pour-motos' ||
        controller.category.value.slug == 'moteur-pieces-de-moteurs' ||
        controller.category.value.slug == 'vedettes-et-bateaux-a-moteur' ||
        controller.category.value.slug == 'jet-ski-scooter-des-mers');
  }

  bool brandState() {
    return (controller.category.value.slug == 'telephones-portables' ||
        controller.category.value.slug == 'ipad-et-tablettes' ||
        controller.category.value.slug == 'ordinateurs-de-bureau' ||
        controller.category.value.slug == 'portables');
  }

  bool modelState() {
    return (controller.category.value.slug == 'voiture-doccasion' ||
        controller.category.value.slug == 'location-de-voiture');
  }

  bool modelTextState() {
    return (controller.category.value.slug == 'vedettes-et-bateaux-a-moteur' ||
        controller.category.value.slug == 'scooters-et-minimotos' ||
        controller.category.value.slug == 'routieres' ||
        controller.category.value.slug == 'pieces-et-accessoires-pour-motos' ||
        controller.category.value.slug == 'motos-sport' ||
        controller.category.value.slug == 'motocross' ||
        controller.category.value.slug == 'jet-ski-scooter-des-mers' ||
        controller.category.value.slug == 'autres-motos');
  }

  bool autoYearState() {
    return (controller.category.value.slug == 'voiture-doccasion' ||
        controller.category.value.slug == 'location-de-voiture' ||
        controller.category.value.slug == 'motocross' ||
        controller.category.value.slug == 'scooters-et-minimotos' ||
        controller.category.value.slug == 'motos-sport' ||
        controller.category.value.slug == 'routieres' ||
        controller.category.value.slug == 'autres-motos' ||
        controller.category.value.slug == 'vedettes-et-bateaux-a-moteur' ||
        controller.category.value.slug == 'jet-ski-scooter-des-mers' ||
        controller.category.value.slug == 'equipement-agricole' ||
        controller.category.value.slug == 'camions-lourd');
  }

  bool autoTypeState() {
    return (controller.category.value.slug == 'voiture-doccasion' ||
        controller.category.value.slug == 'location-de-voiture');
  }

  bool autoStateState() {
    return (controller.category.value.slug == 'voiture-doccasion' ||
        controller.category.value.slug == 'scooters-et-minimotos' ||
        controller.category.value.slug == 'routieres' ||
        controller.category.value.slug == 'motos-sport' ||
        controller.category.value.slug == 'motocross' ||
        controller.category.value.slug == 'autres-motos');
  }

  bool kiloState() {
    return (controller.category.value.slug == 'voiture-doccasion' ||
        controller.category.value.slug == 'scooters-et-minimotos' ||
        controller.category.value.slug == 'routieres' ||
        controller.category.value.slug == 'motos-sport' ||
        controller.category.value.slug == 'motocross' ||
        controller.category.value.slug == 'camions-lourd' ||
        controller.category.value.slug == 'autres-motos');
  }

  bool cylindreState() {
    return (controller.category.value.slug == 'scooters-et-minimotos' ||
        controller.category.value.slug == 'routieres' ||
        controller.category.value.slug == 'motos-sport' ||
        controller.category.value.slug == 'motocross' ||
        controller.category.value.slug == 'jet-ski-scooter-des-mers');
  }

  bool boiteVitesseState() {
    return (controller.category.value.slug == 'voiture-doccasion' ||
        controller.category.value.slug == 'location-de-voiture');
  }

  bool transmissionState() {
    return (controller.category.value.slug == 'voiture-doccasion');
  }

  bool colorState() {
    return (controller.category.value.slug == 'voiture-doccasion' ||
        controller.category.value.slug == 'scooters-et-minimotos' ||
        controller.category.value.slug == 'routieres' ||
        controller.category.value.slug == 'pieces-et-accessoires-pour-motos' ||
        controller.category.value.slug == 'motos-sport' ||
        controller.category.value.slug == 'motocross' ||
        controller.category.value.slug == 'location-de-voiture' ||
        controller.category.value.slug == 'jet-ski-scooter-des-mers' ||
        controller.category.value.slug == 'canots-kayaks-et-rameurs' ||
        controller.category.value.slug == 'camions-lourd' ||
        controller.category.value.slug == 'autres-motos');
  }

  bool typeCarburantState() {
    return (controller.category.value.slug == 'voiture-doccasion' ||
        controller.category.value.slug == 'vedettes-et-bateaux-a-moteur' ||
        controller.category.value.slug == 'scooters-et-minimotos' ||
        controller.category.value.slug == 'motocross' ||
        controller.category.value.slug == 'routieres' ||
        controller.category.value.slug == 'location-de-voiture' ||
        controller.category.value.slug == 'jet-ski-scooter-des-mers' ||
        controller.category.value.slug == 'autres-motos');
  }


  bool nombrePorteState() {
    return (controller.category.value.slug == 'voiture-doccasion' ||
        controller.category.value.slug == 'location-de-voiture');
  }

  bool nombrePlaceState() {
    return (controller.category.value.slug == 'voiture-doccasion' ||
        controller.category.value.slug == 'location-de-voiture');
  }

  bool autreInformationState() {
    return (controller.category.value.slug == 'voiture-doccasion' ||
        controller.category.value.slug == 'location-de-voiture');
  }

  bool autoSecurityState() {
    return (controller.category.value.slug == 'scooters-et-minimotos' ||
        controller.category.value.slug == 'routieres' ||
        controller.category.value.slug == 'motos-sport' ||
        controller.category.value.slug == 'motocross' ||
        controller.category.value.slug == 'autres-motos');
  }

  bool informationExtState() {
    return (controller.category.value.slug == 'scooters-et-minimotos' ||
        controller.category.value.slug == 'routieres' ||
        controller.category.value.slug == 'motos-sport' ||
        controller.category.value.slug == 'motocross' ||
        controller.category.value.slug == 'autres-motos');
  }

  // Immobilier
  bool surfaceState() {
    return (controller.category.value.slug == 'appartement-1' ||
        controller.category.value.slug == 'appartement' ||
        controller.category.value.slug == 'autre-1' ||
        controller.category.value.slug == 'autre' ||
        controller.category.value.slug == 'chambre' ||
        controller.category.value.slug == 'colocation' ||
        controller.category.value.slug == 'duplex-triplex-1' ||
        controller.category.value.slug == 'duplex-triplex' ||
        controller.category.value.slug == 'espaces-commerciaux-et-bureaux-1' ||
        controller.category.value.slug == 'espaces-commerciaux-et-bureaux' ||
        controller.category.value.slug == 'maison-1' ||
        controller.category.value.slug == 'maison' ||
        controller.category.value.slug == 'parking-garage' ||
        controller.category.value.slug == 'studio-1' ||
        controller.category.value.slug == 'studio' ||
        controller.category.value.slug == 'studio-americain-1' ||
        controller.category.value.slug == 'studio-americain' ||
        controller.category.value.slug == 'terrain-1' ||
        controller.category.value.slug == 'terrain' ||
        controller.category.value.slug == 'villa-1' ||
        controller.category.value.slug == 'villa');
  }

  bool nombrePieceState() {
    return (controller.category.value.slug == 'appartement-1' ||
        controller.category.value.slug == 'appartement' ||
        controller.category.value.slug == 'colocation' ||
        controller.category.value.slug == 'duplex-triplex-1' ||
        controller.category.value.slug == 'duplex-triplex' ||
        controller.category.value.slug == 'maison-1' ||
        controller.category.value.slug == 'maison' ||
        controller.category.value.slug == 'villa-1' ||
        controller.category.value.slug == 'villa');
  }

  bool nombreChambreState() {
    return (controller.category.value.slug == 'appartement-1' ||
        controller.category.value.slug == 'appartement' ||
        controller.category.value.slug == 'colocation' ||
        controller.category.value.slug == 'duplex-triplex-1' ||
        controller.category.value.slug == 'duplex-triplex' ||
        controller.category.value.slug == 'maison-1' ||
        controller.category.value.slug == 'maison' ||
        controller.category.value.slug == 'villa-1' ||
        controller.category.value.slug == 'villa');
  }

  bool nombreSalleState() {
    return (controller.category.value.slug == 'appartement-1' ||
        controller.category.value.slug == 'appartement' ||
        controller.category.value.slug == 'colocation' ||
        controller.category.value.slug == 'duplex-triplex-1' ||
        controller.category.value.slug == 'duplex-triplex' ||
        controller.category.value.slug == 'maison-1' ||
        controller.category.value.slug == 'maison' ||
        controller.category.value.slug == 'villa-1' ||
        controller.category.value.slug == 'villa');
  }

  bool immoStateState() {
    return (controller.category.value.slug == 'appartement-1' ||
        controller.category.value.slug == 'appartement' ||
        controller.category.value.slug == 'autre-1' ||
        controller.category.value.slug == 'autre' ||
        controller.category.value.slug == 'chambre' ||
        controller.category.value.slug == 'colocation' ||
        controller.category.value.slug == 'duplex-triplex-1' ||
        controller.category.value.slug == 'duplex-triplex' ||
        controller.category.value.slug == 'espaces-commerciaux-et-bureaux-1' ||
        controller.category.value.slug == 'espaces-commerciaux-et-bureaux' ||
        controller.category.value.slug == 'maison-1' ||
        controller.category.value.slug == 'maison' ||
        controller.category.value.slug == 'parking-garage' ||
        controller.category.value.slug == 'studio-1' ||
        controller.category.value.slug == 'studio' ||
        controller.category.value.slug == 'studio-americain-1' ||
        controller.category.value.slug == 'studio-americain' ||
        controller.category.value.slug == 'villa-1' ||
        controller.category.value.slug == 'villa');
  }

  bool surfaceBalconState() {
    return (controller.category.value.slug == 'appartement-1' ||
        controller.category.value.slug == 'appartement' ||
        controller.category.value.slug == 'colocation' ||
        controller.category.value.slug == 'duplex-triplex-1' ||
        controller.category.value.slug == 'duplex-triplex');
  }

  bool nombrePlacardState() {
    return (controller.category.value.slug == 'appartement-1' ||
        controller.category.value.slug == 'appartement' ||
        controller.category.value.slug == 'duplex-triplex-1' ||
        controller.category.value.slug == 'duplex-triplex' ||
        controller.category.value.slug == 'maison-1' ||
        controller.category.value.slug == 'maison' ||
        controller.category.value.slug == 'villa-1' ||
        controller.category.value.slug == 'villa');
  }

  bool dateConstructionState() {
    return (controller.category.value.slug == 'appartement-1' ||
        controller.category.value.slug == 'appartement' ||
        controller.category.value.slug == 'colocation' ||
        controller.category.value.slug == 'duplex-triplex-1' ||
        controller.category.value.slug == 'duplex-triplex' ||
        controller.category.value.slug == 'espaces-commerciaux-et-bureaux-1' ||
        controller.category.value.slug == 'espaces-commerciaux-et-bureaux' ||
        controller.category.value.slug == 'maison-1' ||
        controller.category.value.slug == 'maison' ||
        controller.category.value.slug == 'studio-1' ||
        controller.category.value.slug == 'studio' ||
        controller.category.value.slug == 'studio-americain-1' ||
        controller.category.value.slug == 'studio-americain' ||
        controller.category.value.slug == 'villa-1' ||
        controller.category.value.slug == 'villa');
  }

  bool cuisineState() {
    return (controller.category.value.slug == 'appartement-1' ||
        controller.category.value.slug == 'appartement' ||
        controller.category.value.slug == 'colocation' ||
        controller.category.value.slug == 'duplex-triplex-1' ||
        controller.category.value.slug == 'duplex-triplex' ||
        controller.category.value.slug == 'maison-1' ||
        controller.category.value.slug == 'maison' ||
        controller.category.value.slug == 'studio-1' ||
        controller.category.value.slug == 'studio' ||
        controller.category.value.slug == 'studio-americain-1' ||
        controller.category.value.slug == 'studio-americain' ||
        controller.category.value.slug == 'villa-1' ||
        controller.category.value.slug == 'villa');
  }

  bool standingState() {
    return (controller.category.value.slug == 'appartement-1' ||
        controller.category.value.slug == 'appartement' ||
        controller.category.value.slug == 'chambre' ||
        controller.category.value.slug == 'colocation' ||
        controller.category.value.slug == 'duplex-triplex-1' ||
        controller.category.value.slug == 'duplex-triplex' ||
        controller.category.value.slug == 'espaces-commerciaux-et-bureaux-1' ||
        controller.category.value.slug == 'espaces-commerciaux-et-bureaux' ||
        controller.category.value.slug == 'maison-1' ||
        controller.category.value.slug == 'maison' ||
        controller.category.value.slug == 'studio-1' ||
        controller.category.value.slug == 'studio' ||
        controller.category.value.slug == 'studio-americain-1' ||
        controller.category.value.slug == 'studio-americain' ||
        controller.category.value.slug == 'villa-1' ||
        controller.category.value.slug == 'villa');
  }

  bool situationState() {
    return (controller.category.value.slug == 'appartement-1' ||
        controller.category.value.slug == 'appartement' ||
        controller.category.value.slug == 'duplex-triplex-1' ||
        controller.category.value.slug == 'duplex-triplex' ||
        controller.category.value.slug == 'espaces-commerciaux-et-bureaux-1' ||
        controller.category.value.slug == 'espaces-commerciaux-et-bureaux' ||
        controller.category.value.slug == 'maison-1' ||
        controller.category.value.slug == 'maison' ||
        controller.category.value.slug == 'villa-1' ||
        controller.category.value.slug == 'villa');
  }

  bool salleMangerState() {
    return (controller.category.value.slug == 'appartement-1' ||
        controller.category.value.slug == 'appartement' ||
        controller.category.value.slug == 'colocation' ||
        controller.category.value.slug == 'duplex-triplex-1' ||
        controller.category.value.slug == 'duplex-triplex' ||
        controller.category.value.slug == 'maison-1' ||
        controller.category.value.slug == 'maison' ||
        controller.category.value.slug == 'villa-1' ||
        controller.category.value.slug == 'villa');
  }

  bool etatGeneralState() {
    return (controller.category.value.slug == 'appartement-1' ||
        controller.category.value.slug == 'appartement' ||
        controller.category.value.slug == 'chambre' ||
        controller.category.value.slug == 'colocation' ||
        controller.category.value.slug == 'duplex-triplex-1' ||
        controller.category.value.slug == 'duplex-triplex' ||
        controller.category.value.slug == 'espaces-commerciaux-et-bureaux-1' ||
        controller.category.value.slug == 'espaces-commerciaux-et-bureaux' ||
        controller.category.value.slug == 'maison-1' ||
        controller.category.value.slug == 'maison' ||
        controller.category.value.slug == 'studio-1' ||
        controller.category.value.slug == 'studio' ||
        controller.category.value.slug == 'studio-americain-1' ||
        controller.category.value.slug == 'studio-americain' ||
        controller.category.value.slug == 'villa-1' ||
        controller.category.value.slug == 'villa');
  }

  bool accessState() {
    return (controller.category.value.slug == 'appartement-1' ||
        controller.category.value.slug == 'appartement' ||
        controller.category.value.slug == 'chambre' ||
        controller.category.value.slug == 'colocation' ||
        controller.category.value.slug == 'espaces-commerciaux-et-bureaux-1' ||
        controller.category.value.slug == 'espaces-commerciaux-et-bureaux' ||
        controller.category.value.slug == 'studio-1' ||
        controller.category.value.slug == 'studio' ||
        controller.category.value.slug == 'studio-americain-1' ||
        controller.category.value.slug == 'studio-americain');
  }

  bool exteriorState() {
    return (controller.category.value.slug == 'appartement-1' ||
        controller.category.value.slug == 'appartement' ||
        controller.category.value.slug == 'colocation' ||
        controller.category.value.slug == 'duplex-triplex-1' ||
        controller.category.value.slug == 'duplex-triplex' ||
        controller.category.value.slug == 'espaces-commerciaux-et-bureaux-1' ||
        controller.category.value.slug == 'espaces-commerciaux-et-bureaux' ||
        controller.category.value.slug == 'maison-1' ||
        controller.category.value.slug == 'maison' ||
        controller.category.value.slug == 'studio-1' ||
        controller.category.value.slug == 'studio' ||
        controller.category.value.slug == 'studio-americain-1' ||
        controller.category.value.slug == 'studio-americain' ||
        controller.category.value.slug == 'villa-1' ||
        controller.category.value.slug == 'villa');
  }

  bool interiorState() {
    return (controller.category.value.slug == 'appartement-1' ||
        controller.category.value.slug == 'appartement' ||
        controller.category.value.slug == 'chambre' ||
        controller.category.value.slug == 'colocation' ||
        controller.category.value.slug == 'duplex-triplex-1' ||
        controller.category.value.slug == 'duplex-triplex' ||
        controller.category.value.slug == 'espaces-commerciaux-et-bureaux-1' ||
        controller.category.value.slug == 'espaces-commerciaux-et-bureaux' ||
        controller.category.value.slug == 'maison-1' ||
        controller.category.value.slug == 'maison' ||
        controller.category.value.slug == 'studio-1' ||
        controller.category.value.slug == 'studio' ||
        controller.category.value.slug == 'studio-americain-1' ||
        controller.category.value.slug == 'studio-americain' ||
        controller.category.value.slug == 'villa-1' ||
        controller.category.value.slug == 'villa');
  }

  bool typeSolState() {
    return (controller.category.value.slug == 'appartement-1' ||
        controller.category.value.slug == 'appartement' ||
        controller.category.value.slug == 'chambre' ||
        controller.category.value.slug == 'colocation' ||
        controller.category.value.slug == 'duplex-triplex-1' ||
        controller.category.value.slug == 'duplex-triplex' ||
        controller.category.value.slug == 'espaces-commerciaux-et-bureaux-1' ||
        controller.category.value.slug == 'espaces-commerciaux-et-bureaux' ||
        controller.category.value.slug == 'maison-1' ||
        controller.category.value.slug == 'maison' ||
        controller.category.value.slug == 'studio-1' ||
        controller.category.value.slug == 'studio' ||
        controller.category.value.slug == 'studio-americain-1' ||
        controller.category.value.slug == 'studio-americain' ||
        controller.category.value.slug == 'villa-1' ||
        controller.category.value.slug == 'villa');
  }

  bool serviceInclusState() {
    return (controller.category.value.slug == 'appartement-1' ||
        controller.category.value.slug == 'appartement' ||
        controller.category.value.slug == 'chambre' ||
        controller.category.value.slug == 'colocation' ||
        controller.category.value.slug == 'duplex-triplex-1' ||
        controller.category.value.slug == 'duplex-triplex' ||
        controller.category.value.slug == 'espaces-commerciaux-et-bureaux-1' ||
        controller.category.value.slug == 'espaces-commerciaux-et-bureaux' ||
        controller.category.value.slug == 'maison-1' ||
        controller.category.value.slug == 'maison' ||
        controller.category.value.slug == 'studio-1' ||
        controller.category.value.slug == 'studio' ||
        controller.category.value.slug == 'studio-americain-1' ||
        controller.category.value.slug == 'studio-americain' ||
        controller.category.value.slug == 'villa-1' ||
        controller.category.value.slug == 'villa');
  }

  bool proximiteState() {
    return (controller.category.value.slug == 'appartement-1' ||
        controller.category.value.slug == 'appartement' ||
        controller.category.value.slug == 'chambre' ||
        controller.category.value.slug == 'colocation' ||
        controller.category.value.slug == 'duplex-triplex-1' ||
        controller.category.value.slug == 'duplex-triplex' ||
        controller.category.value.slug == 'espaces-commerciaux-et-bureaux-1' ||
        controller.category.value.slug == 'espaces-commerciaux-et-bureaux' ||
        controller.category.value.slug == 'maison-1' ||
        controller.category.value.slug == 'maison' ||
        controller.category.value.slug == 'studio-1' ||
        controller.category.value.slug == 'studio' ||
        controller.category.value.slug == 'studio-americain-1' ||
        controller.category.value.slug == 'studio-americain' ||
        controller.category.value.slug == 'villa-1' ||
        controller.category.value.slug == 'villa');
  }

  bool facadeState() {
    return (controller.category.value.slug == 'maison-1' ||
        controller.category.value.slug == 'maison' ||
        controller.category.value.slug == 'villa-1' ||
        controller.category.value.slug == 'villa');
  }

  bool toitureState() {
    return (controller.category.value.slug == 'maison-1' ||
        controller.category.value.slug == 'maison' ||
        controller.category.value.slug == 'villa-1' ||
        controller.category.value.slug == 'villa');
  }
}

class AdvertValidateFieldState {
  AdvertValidateFieldState({required this.controller});

  final AdvertCreateController controller;

  bool marqueState() {
    return (controller.category.value.slug == 'voiture-doccasion' ||
        controller.category.value.slug == 'location-de-voiture' ||
        controller.category.value.slug == 'motocross' ||
        controller.category.value.slug == 'scooters-et-minimotos' ||
        controller.category.value.slug == 'motos-sport' ||
        controller.category.value.slug == 'routieres' ||
        controller.category.value.slug == 'vedettes-et-bateaux-a-moteur' ||
        controller.category.value.slug == 'jet-ski-scooter-des-mers'

        /*controller.category.value.slug == 'autres-motos' ||
        controller.category.value.slug == 'pieces-de-carrosserie' ||
        controller.category.value.slug == 'transmission-et-train-roulant' ||
        controller.category.value.slug == 'pieces-et-accessoires-pour-motos' ||
        controller.category.value.slug == 'moteur-pieces-de-moteurs' ||*/
        );
  }

  bool brandState() {
    return (controller.category.value.slug == 'telephones-portables' ||
        controller.category.value.slug == 'ipad-et-tablettes' ||
        controller.category.value.slug == 'ordinateurs-de-bureau' ||
        controller.category.value.slug == 'portables');
  }

  bool modelState() {
    return (controller.category.value.slug == 'voiture-doccasion' ||
        controller.category.value.slug == 'location-de-voiture');
  }

  bool autoYearState() {
    return (controller.category.value.slug == 'voiture-doccasion' ||
        controller.category.value.slug == 'location-de-voiture' ||
        controller.category.value.slug == 'motos-sport' ||
        controller.category.value.slug == 'routieres' ||
        controller.category.value.slug == 'camions-lourd');
  }

  bool autoTypeState() {
    return (controller.category.value.slug == 'voiture-doccasion' ||
        controller.category.value.slug == 'location-de-voiture');
  }

  bool autoStateState() {
    return (controller.category.value.slug == 'voiture-doccasion' ||
        controller.category.value.slug == 'routieres' ||
        controller.category.value.slug == 'motos-sport' ||
        controller.category.value.slug == 'motocross'
    );
  }

  bool kiloState() {
    return (controller.category.value.slug == 'voiture-doccasion' ||
        controller.category.value.slug == 'routieres' ||
        controller.category.value.slug == 'motos-sport' ||
        controller.category.value.slug == 'camions-lourd'
    );
  }

  bool surfaceState() {
    return (controller.category.value.slug == 'appartement-1' ||
        controller.category.value.slug == 'appartement' ||
        controller.category.value.slug == 'autre-1' ||
        controller.category.value.slug == 'autre' ||
        controller.category.value.slug == 'chambre' ||
        controller.category.value.slug == 'colocation' ||
        controller.category.value.slug == 'duplex-triplex-1' ||
        controller.category.value.slug == 'duplex-triplex' ||
        controller.category.value.slug == 'espaces-commerciaux-et-bureaux-1' ||
        controller.category.value.slug == 'espaces-commerciaux-et-bureaux' ||
        controller.category.value.slug == 'maison-1' ||
        controller.category.value.slug == 'maison' ||
        controller.category.value.slug == 'parking-garage' ||
        controller.category.value.slug == 'studio-1' ||
        controller.category.value.slug == 'studio' ||
        controller.category.value.slug == 'studio-americain-1' ||
        controller.category.value.slug == 'studio-americain' ||
        controller.category.value.slug == 'terrain-1' ||
        controller.category.value.slug == 'terrain' ||
        controller.category.value.slug == 'villa-1' ||
        controller.category.value.slug == 'villa');
  }

  bool nombrePieceState() {
    return (controller.category.value.slug == 'appartement-1' ||
        controller.category.value.slug == 'appartement' ||
        controller.category.value.slug == 'duplex-triplex-1' ||
        controller.category.value.slug == 'duplex-triplex' ||
        controller.category.value.slug == 'maison-1' ||
        controller.category.value.slug == 'maison' ||
        controller.category.value.slug == 'villa-1' ||
        controller.category.value.slug == 'villa');
  }

  bool nombreChambreState() {
    return (controller.category.value.slug == 'appartement-1' ||
        controller.category.value.slug == 'appartement' ||
        controller.category.value.slug == 'duplex-triplex-1' ||
        controller.category.value.slug == 'duplex-triplex' ||
        controller.category.value.slug == 'maison-1' ||
        controller.category.value.slug == 'maison' ||
        controller.category.value.slug == 'villa-1' ||
        controller.category.value.slug == 'villa');
  }

  bool nombreSalleState() {
    return (controller.category.value.slug == 'appartement-1' ||
        controller.category.value.slug == 'appartement' ||
        controller.category.value.slug == 'duplex-triplex-1' ||
        controller.category.value.slug == 'duplex-triplex' ||
        controller.category.value.slug == 'maison-1' ||
        controller.category.value.slug == 'maison' ||
        controller.category.value.slug == 'villa-1' ||
        controller.category.value.slug == 'villa');
  }

  bool immoStateState() {
    return (controller.category.value.slug == 'appartement-1' ||
        controller.category.value.slug == 'appartement' ||
        controller.category.value.slug == 'chambre' ||
        controller.category.value.slug == 'colocation' ||
        controller.category.value.slug == 'duplex-triplex-1' ||
        controller.category.value.slug == 'duplex-triplex' ||
        controller.category.value.slug == 'espaces-commerciaux-et-bureaux-1' ||
        controller.category.value.slug == 'espaces-commerciaux-et-bureaux' ||
        controller.category.value.slug == 'maison-1' ||
        controller.category.value.slug == 'maison' ||
        controller.category.value.slug == 'studio-1' ||
        controller.category.value.slug == 'studio' ||
        controller.category.value.slug == 'studio-americain-1' ||
        controller.category.value.slug == 'studio-americain' ||
        controller.category.value.slug == 'villa-1' ||
        controller.category.value.slug == 'villa');
  }

}


class AdvertTitleFieldState {
  AdvertTitleFieldState({required this.controller});

  final AdvertCreateController controller;

  bool marqueState() {
    return (controller.category.value.slug == 'autres-motos' ||
        controller.category.value.slug == 'pieces-de-carrosserie' ||
        controller.category.value.slug == 'transmission-et-train-roulant' ||
        controller.category.value.slug == 'pieces-et-accessoires-pour-motos' ||
        controller.category.value.slug == 'moteur-pieces-de-moteurs');
  }

  bool autoYearState() {
    return (controller.category.value.slug == 'motocross' ||
        controller.category.value.slug == 'scooters-et-minimotos' ||
        controller.category.value.slug == 'autres-motos' ||
        controller.category.value.slug == 'vedettes-et-bateaux-a-moteur' ||
        controller.category.value.slug == 'jet-ski-scooter-des-mers' ||
        controller.category.value.slug == 'equipement-agricole'
    );
  }

  bool autoStateState() {
    return (controller.category.value.slug == 'scooters-et-minimotos' ||
        controller.category.value.slug == 'autres-motos');
  }

  bool kiloState() {
    return (controller.category.value.slug == 'scooters-et-minimotos' ||
        controller.category.value.slug == 'motocross' ||
        controller.category.value.slug == 'autres-motos');
  }

  bool nombrePieceState() {
    return (controller.category.value.slug == 'colocation');
  }

  bool nombreChambreState() {
    return (controller.category.value.slug == 'colocation');
  }

  bool nombreSalleState() {
    return (controller.category.value.slug == 'colocation');
  }

  bool immoStateState() {
    return (controller.category.value.slug == 'autre-1' ||
        controller.category.value.slug == 'autre' ||
        controller.category.value.slug == 'parking-garage');
  }
}
