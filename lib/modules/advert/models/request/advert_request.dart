import 'dart:io';
import 'package:path/path.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';

class AdvertRequest extends Equatable {
  const AdvertRequest({
    required this.categoryId,
    required this.token,
    required this.title,
    required this.description,
    required this.price,
    this.priceStatus,
    required this.type,
    required this.locationName,
    this.locationDetail,
    this.traitement,
    this.marque,
    this.model,
    this.autoYear,
    this.autoType,
    this.autoState,
    this.kilo,
    this.boiteVitesse,
    this.transmission,
    this.autoColor,
    this.typeCarburant,
    this.nombrePorte,
    this.nombrePlace,
    this.autreInformation,
    this.cylindree,
    this.autoSecurity,
    this.informationExterieur,
    this.surface,
    this.nombrePiece,
    this.immobilierState,
    this.access,
    this.nombreChambre,
    this.nombrePlacard,
    this.nombreSalleBain,
    this.surfaceBalcon,
    this.serviceInclus,
    this.interior,
    this.dateConstruction,
    this.situation,
    this.standing,
    this.cuisine,
    this.salleManger,
    this.typeSol,
    this.stateGenerale,
    this.facade,
    this.toiture,
    this.proximite,
    this.exterior,
    this.state,
    this.aType,
    this.brand,
  });

  final int categoryId;
  final String title;
  final String description;
  final int price;
  final bool? priceStatus;
  final String type;
  final String token;
  final String locationName;
  final String? locationDetail;
  final String? traitement;
  final String? marque;
  final String? model;
  final String? autoYear;
  final String? autoType;
  final String? autoState;
  final int? kilo;
  final String? boiteVitesse;
  final String? transmission;
  final String? autoColor;
  final String? typeCarburant;
  final String? nombrePorte;
  final String? nombrePlace;
  final List<String>? autreInformation;
  final int? cylindree;
  final List<String>? autoSecurity;
  final List<String>? informationExterieur;
  final int? surface;
  final String? nombrePiece;
  final String? immobilierState;
  final List<String>? access;
  final int? nombreChambre;
  final int? nombreSalleBain;
  final int? surfaceBalcon;
  final List<String>? exterior;
  final String? dateConstruction;
  final String? situation;
  final String? standing;
  final String? cuisine;
  final String? salleManger;
  final int? nombrePlacard;
  final List<String>? interior;
  final List<String>? serviceInclus;
  final List<String>? typeSol;
  final List<String>? proximite;
  final String? stateGenerale;
  final List<String>? facade;
  final List<String>? toiture;
  final String? state;
  final String? aType;
  final String? brand;


  @override
  List<Object?> get props => [
    title,
    description,
    type,
    price,
    price,
    locationName,
    locationDetail
  ];

  Map<String, dynamic> toMap() {
    final queryParameters = {
      'title': title,
      'description': description,
      'price': price,
      'priceStatus': priceStatus,
      'type': type,
      'location': {
        'name': locationName,
        if (locationDetail != null) 'detail': locationDetail,
      },
      if (traitement != null && traitement!.isNotEmpty) 'traitement': traitement,
      if (marque != null && marque!.isNotEmpty) 'marque': marque,
      if (model != null && model!.isNotEmpty) 'model': model,
      if (autoYear != null && autoYear!.isNotEmpty) 'autoYear': autoYear,
      if (autoType != null && autoType!.isNotEmpty) 'autoType': autoType,
      if (autoState != null && autoState!.isNotEmpty) 'autoState': autoState,
      if (kilo != null) 'kilo': kilo,
      if (boiteVitesse != null && boiteVitesse!.isNotEmpty) 'boiteVitesse': boiteVitesse,
      if (transmission != null && transmission!.isNotEmpty) 'transmission': transmission,
      if (autoColor != null && autoColor!.isNotEmpty) 'autoColor': autoColor,
      if (typeCarburant != null && typeCarburant!.isNotEmpty) 'typeCarburant': typeCarburant,
      if (nombrePorte != null && nombrePorte!.isNotEmpty) 'nombrePorte': nombrePorte,
      if (nombrePlace != null && nombrePlace!.isNotEmpty) 'nombrePlace': nombrePlace,
      if (autreInformation != null && autreInformation!.isNotEmpty) 'autreInformation': autreInformation,
      if (cylindree != null) 'cylindree': cylindree,
      if (autoSecurity != null && autoSecurity!.isNotEmpty) 'autoSecurity': autoSecurity,
      if (informationExterieur != null && informationExterieur!.isNotEmpty) 'informationExterieur': informationExterieur,
      if (surface != null) 'surface': surface,
      if (nombrePiece != null && nombrePiece!.isNotEmpty) 'nombrePiece': nombrePiece,
      if (immobilierState != null && immobilierState!.isNotEmpty) 'immobilierState': immobilierState,
      if (nombreChambre != null) 'nombreChambre': nombreChambre,
      if (nombreSalleBain != null) 'nombreSalleBain': nombreSalleBain,
      if (access != null && access!.isNotEmpty) 'access': access,
      if (surfaceBalcon != null) 'surfaceBalcon': surfaceBalcon,
      if (exterior != null && exterior!.isNotEmpty) 'exterior': exterior,
      if (dateConstruction != null && dateConstruction!.isNotEmpty) 'dateConstruction': dateConstruction,
      if (situation != null && situation!.isNotEmpty) 'situation': situation,
      if (standing != null && standing!.isNotEmpty) 'standing': standing,
      if (cuisine != null && cuisine!.isNotEmpty) 'cuisine': cuisine,
      if (salleManger != null && salleManger!.isNotEmpty) 'salleManger': salleManger,
      if (nombrePlacard != null) 'nombrePlacard': nombrePlacard,
      if (interior != null && interior!.isNotEmpty) 'interior': interior,
      if (serviceInclus != null && serviceInclus!.isNotEmpty) 'serviceInclus': serviceInclus,
      if (typeSol != null && typeSol!.isNotEmpty) 'typeSol': typeSol,
      if (proximite != null && proximite!.isNotEmpty) 'proximite': proximite,
      if (stateGenerale != null && stateGenerale!.isNotEmpty) 'stateGenerale': stateGenerale,
      if (facade != null && facade!.isNotEmpty) 'facade': facade,
      if (toiture != null && toiture!.isNotEmpty) 'toiture': toiture,
      if (state != null && state!.isNotEmpty) 'state': state,
      if (brand != null && brand!.isNotEmpty) 'brand': brand,
    };

    return queryParameters;
  }
}

class AdvertEditRequest extends Equatable {
  const AdvertEditRequest({
    required this.id,
    required this.token,
    required this.title,
    required this.description,
    required this.price,
    this.priceStatus,
    required this.locationName,
    this.locationDetail,
    this.traitement,
    this.marque,
    this.model,
    this.autoYear,
    this.autoType,
    this.autoState,
    this.kilo,
    this.boiteVitesse,
    this.transmission,
    this.autoColor,
    this.typeCarburant,
    this.nombrePorte,
    this.nombrePlace,
    this.autreInformation,
    this.cylindree,
    this.autoSecurity,
    this.informationExterieur,
    this.surface,
    this.nombrePiece,
    this.immobilierState,
    this.access,
    this.nombreChambre,
    this.nombrePlacard,
    this.nombreSalleBain,
    this.surfaceBalcon,
    this.serviceInclus,
    this.interior,
    this.dateConstruction,
    this.situation,
    this.standing,
    this.cuisine,
    this.salleManger,
    this.typeSol,
    this.stateGenerale,
    this.facade,
    this.toiture,
    this.proximite,
    this.exterior,
    this.state,
    this.aType,
    this.brand,
  });

  final int id;
  final String title;
  final String description;
  final int price;
  final bool? priceStatus;
  final String token;
  final String locationName;
  final String? locationDetail;
  final String? traitement;
  final String? marque;
  final String? model;
  final String? autoYear;
  final String? autoType;
  final String? autoState;
  final int? kilo;
  final String? boiteVitesse;
  final String? transmission;
  final String? autoColor;
  final String? typeCarburant;
  final String? nombrePorte;
  final String? nombrePlace;
  final List<String>? autreInformation;
  final int? cylindree;
  final List<String>? autoSecurity;
  final List<String>? informationExterieur;
  final int? surface;
  final String? nombrePiece;
  final String? immobilierState;
  final List<String>? access;
  final int? nombreChambre;
  final int? nombreSalleBain;
  final int? surfaceBalcon;
  final List<String>? exterior;
  final String? dateConstruction;
  final String? situation;
  final String? standing;
  final String? cuisine;
  final String? salleManger;
  final int? nombrePlacard;
  final List<String>? interior;
  final List<String>? serviceInclus;
  final List<String>? typeSol;
  final List<String>? proximite;
  final String? stateGenerale;
  final List<String>? facade;
  final List<String>? toiture;
  final String? state;
  final String? aType;
  final String? brand;


  @override
  List<Object?> get props => [
    id,
    title,
    description,
    price,
    price,
    locationName,
    locationDetail
  ];

  Map<String, dynamic> toMap() {
    final queryParameters = {
      'title': title,
      'description': description,
      'price': price,
      'priceStatus': priceStatus,
      'location': {
        'name': locationName,
        if (locationDetail != null) 'detail': locationDetail,
      },
      if (traitement != null && traitement!.isNotEmpty) 'traitement': traitement,
      if (marque != null && marque!.isNotEmpty) 'marque': marque,
      if (model != null && model!.isNotEmpty) 'model': model,
      if (autoYear != null && autoYear!.isNotEmpty) 'autoYear': autoYear,
      if (autoType != null && autoType!.isNotEmpty) 'autoType': autoType,
      if (autoState != null && autoState!.isNotEmpty) 'autoState': autoState,
      if (kilo != null) 'kilo': kilo,
      if (boiteVitesse != null && boiteVitesse!.isNotEmpty) 'boiteVitesse': boiteVitesse,
      if (transmission != null && transmission!.isNotEmpty) 'transmission': transmission,
      if (autoColor != null && autoColor!.isNotEmpty) 'autoColor': autoColor,
      if (typeCarburant != null && typeCarburant!.isNotEmpty) 'typeCarburant': typeCarburant,
      if (nombrePorte != null && nombrePorte!.isNotEmpty) 'nombrePorte': nombrePorte,
      if (nombrePlace != null && nombrePlace!.isNotEmpty) 'nombrePlace': nombrePlace,
      if (autreInformation != null && autreInformation!.isNotEmpty) 'autreInformation': autreInformation,
      if (cylindree != null) 'cylindree': cylindree,
      if (autoSecurity != null && autoSecurity!.isNotEmpty) 'autoSecurity': autoSecurity,
      if (informationExterieur != null && informationExterieur!.isNotEmpty) 'informationExterieur': informationExterieur,
      if (surface != null) 'surface': surface,
      if (nombrePiece != null && nombrePiece!.isNotEmpty) 'nombrePiece': nombrePiece,
      if (immobilierState != null && immobilierState!.isNotEmpty) 'immobilierState': immobilierState,
      if (nombreChambre != null) 'nombreChambre': nombreChambre,
      if (nombreSalleBain != null) 'nombreSalleBain': nombreSalleBain,
      if (access != null && access!.isNotEmpty) 'access': access,
      if (surfaceBalcon != null) 'surfaceBalcon': surfaceBalcon,
      if (exterior != null && exterior!.isNotEmpty) 'exterior': exterior,
      if (dateConstruction != null && dateConstruction!.isNotEmpty) 'dateConstruction': dateConstruction,
      if (situation != null && situation!.isNotEmpty) 'situation': situation,
      if (standing != null && standing!.isNotEmpty) 'standing': standing,
      if (cuisine != null && cuisine!.isNotEmpty) 'cuisine': cuisine,
      if (salleManger != null && salleManger!.isNotEmpty) 'salleManger': salleManger,
      if (nombrePlacard != null) 'nombrePlacard': nombrePlacard,
      if (interior != null && interior!.isNotEmpty) 'interior': interior,
      if (serviceInclus != null && serviceInclus!.isNotEmpty) 'serviceInclus': serviceInclus,
      if (typeSol != null && typeSol!.isNotEmpty) 'typeSol': typeSol,
      if (proximite != null && proximite!.isNotEmpty) 'proximite': proximite,
      if (stateGenerale != null && stateGenerale!.isNotEmpty) 'stateGenerale': stateGenerale,
      if (facade != null && facade!.isNotEmpty) 'facade': facade,
      if (toiture != null && toiture!.isNotEmpty) 'toiture': toiture,
      if (state != null && state!.isNotEmpty) 'state': state,
      //if (aType != null && autreInformation!.isNotEmpty) 'aType': aType,
      if (brand != null && brand!.isNotEmpty) 'brand': brand,
    };

    //print('Req => $queryParameters');

    return queryParameters;
  }
}

class AdvertFilterRequest extends Equatable {
  const AdvertFilterRequest({
    required this.page,
    required this.itemsPerPage,
    this.category,
    this.categoryLevel,
    this.priceMin,
    this.priceMax,
    this.locationName,
    this.locationDetail,
    this.type,
    this.marque,
    this.model,
    this.typeCarburant,
    this.nombrePiece,
    this.nombreChambre,
    this.nombreSalleBain,
    this.access,
    this.proximite,
    this.interior,
    this.exterior,
    this.immobilierState,
    this.state,
    this.brand,
    this.kiloMin,
    this.kiloMax,
    this.autoYearMin,
    this.autoYearMax,
    this.surfaceMin,
    this.surfaceMax,
    this.priceOrder,
    this.autoYearOrder,
    this.validatedAtOrder,
    this.positionOrder,
    this.optionAdUrgentsEnd
  });

  final int page;
  final int itemsPerPage;
  final String? category;
  /*final String? subcategory;
  final String? subdivision;*/
  final int? categoryLevel;
  final int? priceMin;
  final int? priceMax;
  final String? locationName;
  final String? locationDetail;
  final String? type;
  final String? marque;
  final String? model;
  final String? typeCarburant;
  final String? nombrePiece;
  final int? nombreChambre;
  final int? nombreSalleBain;
  final String? access;
  final String? proximite;
  final String? interior;
  final String? exterior;
  final String? immobilierState;
  final String? state;
  final String? brand;
  final int? kiloMin;
  final int? kiloMax;
  final String? autoYearMin;
  final String? autoYearMax;
  final int? surfaceMin;
  final int? surfaceMax;
  final String? priceOrder;
  final String? autoYearOrder;
  final String? validatedAtOrder;
  final String? positionOrder;
  final bool? optionAdUrgentsEnd;

  @override
  List<Object?> get props => [
    page,
    category,
    /*subcategory,
    subdivision,*/
    priceMin,
    priceMax,
    locationName,
    locationDetail
  ];

  Map<String, dynamic> toMap() {
    final queryParameters = {
      'page': page,
      'itemsPerPage': itemsPerPage,
      if (categoryLevel == 0) 'category.slug': category,
      if (categoryLevel == 1) 'subCategory.slug': category,
      if (categoryLevel == 2) 'subDivision.slug': category,
      if (locationName != null && locationName!.isNotEmpty) 'location.name': locationName,
      if (locationDetail != null && locationDetail!.isNotEmpty) 'location.detail': locationDetail,
      if (type != null && type!.isNotEmpty) 'type': type,
      if (marque != null && marque!.isNotEmpty) 'marque': marque,
      if (model != null && model!.isNotEmpty) 'model': model,
      if (typeCarburant != null && typeCarburant!.isNotEmpty) 'typeCarburant': typeCarburant,
      if (nombrePiece != null && nombrePiece!.isNotEmpty) 'nombrePiece': nombrePiece,
      if (immobilierState != null && immobilierState!.isNotEmpty) 'immobilierState': immobilierState,
      if (state != null && state!.isNotEmpty) 'state': state,
      if (brand != null && brand!.isNotEmpty) 'brand': brand,
      if (nombreChambre != null && !nombreChambre!.isNaN) 'nombreChambre': nombreChambre,
      if (nombreSalleBain != null && !nombreSalleBain!.isNaN) 'nombreSalleBain': nombreSalleBain,
      if (access != null && access!.isNotEmpty) 'access': access,
      if (proximite != null && proximite!.isNotEmpty) 'proximite': proximite,
      if (interior != null && interior!.isNotEmpty) 'interior': interior,
      if (exterior != null && exterior!.isNotEmpty) 'exterior': exterior,
      if (priceMin != null && !priceMin!.isNaN) 'price[gte]': priceMin,
      if (priceMax != null && !priceMax!.isNaN) 'price[lte]': priceMax,
      if (kiloMin != null && !kiloMin!.isNaN) 'kilo[gte]': kiloMin,
      if (kiloMax != null && !kiloMax!.isNaN) 'kilo[lte]': kiloMax,
      if (autoYearMin != null && autoYearMin!.isNotEmpty) 'autoYear[gte]': autoYearMin,
      if (autoYearMax != null && autoYearMax!.isNotEmpty) 'autoYear[lte]': autoYearMax,
      if (surfaceMin != null && !surfaceMin!.isNaN) 'surface[gte]': surfaceMin,
      if (surfaceMax != null && !surfaceMax!.isNaN) 'surface[lte]': surfaceMax,
      if (priceOrder != null) 'order[price]': priceOrder,
      if (autoYearOrder != null) 'order[autoYear]': autoYearOrder,
      if (validatedAtOrder != null) 'order[validatedAt]': validatedAtOrder,
      if (positionOrder != null) 'order[position]': positionOrder,
      if (optionAdUrgentsEnd == true) 'optionAdUrgentsEnd[after]': DateTime.now().toString(),
    };

    print('Req => $queryParameters');

    return queryParameters;
  }
}

class AdvertSimpleRequest extends Equatable {
  const AdvertSimpleRequest({required this.id});

  final int id;

  @override
  List<Object?> get props => [id];

  Map<String, dynamic> toMap() {
    final queryParameters = {'id': id};

    return queryParameters;
  }
}

class AdvertSimilarRequest extends Equatable {
  const AdvertSimilarRequest({required this.id, required this.page, required this.itemsPerPage});

  final int id;
  final int page;
  final int itemsPerPage;

  @override
  List<Object?> get props => [id, page, itemsPerPage];

  Map<String, dynamic> toMap() {
    final queryParameters = {
      'page': page,
      'itemsPerPage': itemsPerPage
    };

    return queryParameters;
  }
}


class AdvertImageRequest extends Equatable {
  const AdvertImageRequest({required this.id, required this.images, required this.token});

  final int id;
  final List<File> images;
  final String token;

  @override
  List<Object?> get props => [id, images, token];

  FormData toMap() {
    Map<String, dynamic> fileMap = {};

    for (int i = 0; i < images.length; i++) {

      if (images[i].path.isNotEmpty) {

        fileMap["file$i"] = MultipartFile(
          images[i].openRead(),
          images[i].readAsBytesSync().lengthInBytes,
          filename: basename(images[i].path)
        );
      }
    }

    return FormData.fromMap(fileMap);
  }
}

class AdvertImageDataRequest extends Equatable {
  const AdvertImageDataRequest({this.position, required this.token});

  final int? position;
  final String token;

  @override
  List<Object?> get props => [position, token];
}

class AdvertUserRequest extends Equatable {
  const AdvertUserRequest({required this.id, required this.token});

  final int id;
  final String token;

  @override
  List<Object?> get props => [id, token];

  Map<String, dynamic> toMap() {
    final queryParameters = {'id': id};

    return queryParameters;
  }
}


class AdvertCountFilterRequest extends Equatable {
  const AdvertCountFilterRequest({
    this.category,
    this.categoryLevel,
    this.locationName,
  });

  final String? category;
  final int? categoryLevel;
  final String? locationName;

  @override
  List<Object?> get props => [category, categoryLevel, locationName,];

  Map<String, dynamic> toMap() {
    final queryParameters = {
      if (categoryLevel == 0) 'category.slug': category,
      if (categoryLevel == 1) 'subCategory.slug': category,
      if (categoryLevel == 2) 'subDivision.slug': category,
      if (locationName != null) 'location.name': locationName,
    };

    return queryParameters;
  }

}

