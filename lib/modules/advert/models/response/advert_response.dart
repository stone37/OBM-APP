import 'package:equatable/equatable.dart';
import 'package:obm_market/modules/advert/models/entities/advert.dart';

class AdvertListResponse extends Equatable {
  const AdvertListResponse({
    required this.totalItems,
    required this.adverts,
    required this.hydraView
  });

  final int totalItems;
  final List<AdvertResponse> adverts;
  final Map<String, dynamic> hydraView;

  @override
  List<Object?> get props => [totalItems, adverts];

  AdvertList toEntity() {
    return AdvertList(
      totalItems: totalItems,
      hydraView: hydraView,
      adverts: adverts.map((e) => e.toEntity()).toList()
    );
  }

  factory AdvertListResponse.fromMap(Map<String, dynamic> map) {

    final results = List<Map<String, dynamic>>.from(map['hydra:member']);

    return AdvertListResponse(
      totalItems: map['hydra:totalItems'],
      adverts: results.map((e) => AdvertResponse.fromMap(e)).toList(),
      hydraView: map['hydra:view']
    );
  }
}

class AdvertResponse extends Equatable {
  const AdvertResponse({
    required this.id,
    required this.title,
    required this.slug,
    required this.description,
    required this.price,
    this.priceStatus,
    required this.type,
    required this.reference,
    required this.category,
    required this.subCategory,
    this.subDivision,
    required this.location,
    required this.images,
    required this.user,
    this.traitement,
    this.messageCount,
    required this.createdAt,
    this.updatedAt,
    this.validatedAt,
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
    this.optionPhoto,
    this.optionAdGalleryEnd,
    this.optionAdEncadreEnd,
    this.optionAdHeadEnd,
    this.optionAdUrgentsEnd,
    this.optionAdVedetteEnd,
    this.status
  });

  final int id;
  final String title;
  final String slug;
  final String description;
  final int price;
  final bool? priceStatus;
  final String type;
  final String reference;
  final Map<String, dynamic> category;
  final Map<String, dynamic> subCategory;
  final Map<String, dynamic>? subDivision;
  final Map<String, dynamic>? location;
  final List<Map<String, dynamic>> images;
  final Map<String, dynamic> user;
  final String? traitement;
  final int? messageCount;
  final String createdAt;
  final String? updatedAt;
  final String? validatedAt;
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
  final bool? optionPhoto;
  final String? optionAdHeadEnd;
  final String? optionAdUrgentsEnd;
  final String? optionAdGalleryEnd;
  final String? optionAdVedetteEnd;
  final String? optionAdEncadreEnd;
  final String? status;

  @override
  List<Object?> get props => [
    id,
    title,
    slug,
    category,
    subCategory,
    subDivision,
    description,
    type,
    price,
    price,
    reference,
    user,
    location,
    images
  ];

  Advert toEntity() {
    return Advert(
      id: id,
      title: title,
      slug: slug,
      description: description,
      price: price,
      priceStatus: priceStatus,
      type: type,
      reference: reference,
      category: category,
      subCategory: subCategory,
      subDivision: subDivision,
      location: location,
      images: images,
      user: user,
      messageCount: messageCount,
      traitement: traitement,
      createdAt: DateTime.parse(createdAt),
      updatedAt: DateTime.parse(updatedAt!),
      validatedAt: (validatedAt!.isNotEmpty) ? DateTime.parse(validatedAt!) : null,
      marque: marque,
      model: model,
      autoYear: autoYear,
      autoType: autoType,
      autoState: autoState,
      kilo: kilo,
      boiteVitesse: boiteVitesse,
      transmission: transmission,
      autoColor: autoColor,
      typeCarburant: typeCarburant,
      nombrePorte: nombrePorte,
      nombrePlace: nombrePlace,
      autreInformation: autreInformation,
      autoSecurity: autoSecurity,
      cylindree: cylindree,
      informationExterieur: informationExterieur,
      surface: surface,
      immobilierState: immobilierState,
      dateConstruction: dateConstruction,
      nombrePiece: nombrePiece,
      nombreChambre: nombreChambre,
      nombreSalleBain: nombreSalleBain,
      surfaceBalcon: surfaceBalcon,
      exterior: exterior,
      situation: situation,
      standing: standing,
      cuisine: cuisine,
      salleManger: salleManger,
      nombrePlacard: nombrePlacard,
      interior: interior,
      serviceInclus: serviceInclus,
      typeSol: typeSol,
      proximite: proximite,
      facade: facade,
      access: access,
      stateGenerale: stateGenerale,
      toiture: toiture,
      state: state,
      aType: aType,
      brand: brand,
      optionPhoto: optionPhoto,
      optionAdEncadreEnd: !(optionAdEncadreEnd == null) ? DateTime.parse(optionAdEncadreEnd!) : null,
      optionAdGalleryEnd: !(optionAdGalleryEnd == null) ? DateTime.parse(optionAdGalleryEnd!) : null,
      optionAdHeadEnd: !(optionAdHeadEnd == null) ? DateTime.parse(optionAdHeadEnd!) : null,
      optionAdUrgentsEnd: !(optionAdUrgentsEnd == null) ? DateTime.parse(optionAdUrgentsEnd!) : null,
      optionAdVedetteEnd: !(optionAdVedetteEnd == null) ? DateTime.parse(optionAdVedetteEnd!) : null,
      status: status
    );
  }

  factory AdvertResponse.fromMap(Map<String, dynamic> map) {

    return AdvertResponse(
      id: map['id'] ?? '',
      title: map['title'] ?? '',
      slug: map['slug'] ?? '',
      description: map['description'] ?? '',
      price: map['price'] ?? '',
      priceStatus: map['priceStatus'] ?? null,
      type: map['type'] ?? '',
      reference: map['reference'] ?? '',
      category: Map<String, dynamic>.from(map['category'] ?? []),
      subCategory: Map<String, dynamic>.from(map['subCategory'] ?? []),
      subDivision: ((map['subDivision']) == null) ? null : Map<String, dynamic>.from(map['subDivision']),
      location: Map<String, dynamic>.from(map['location'] ?? []),
      images: List<Map<String, dynamic>>.from(map['images'] ?? []),
      user: Map<String, dynamic>.from(map['user'] ?? []),
      messageCount: map['messageCount'] ?? null,
      traitement: map['traitement'] ?? '',
      createdAt: map['createdAt'] ?? '',
      updatedAt: map['updatedAt'] ?? '',
      validatedAt: map['validatedAt'] ?? '',
      marque: map['marque'] ?? '',
      model: map['model'] ?? '',
      autoYear: map['autoYear'] ?? '',
      autoType: map['autoType'] ?? '',
      autoState: map['autoState'] ?? '',
      kilo: map['kilo'] ?? null,
      boiteVitesse: map['boiteVitesse'] ?? '',
      transmission: map['transmission'] ?? '',
      autoColor: map['autoColor'] ?? '',
      typeCarburant: map['typeCarburant'] ?? '',
      nombrePorte: map['nombrePorte'] ?? '',
      nombrePlace: map['nombrePlace'] ?? '',
      autreInformation: List<String>.from(map['autreInformation']?? []),
      cylindree: map['cylindree'] ?? null,
      autoSecurity: List<String>.from(map['autoSecurity']?? []),
      informationExterieur: List<String>.from(map['informationExterieur']?? []),
      surface: map['surface'] ?? null,
      nombrePiece: map['nombrePiece'] ?? '',
      immobilierState: map['immobilierState'] ?? '',
      access: List<String>.from(map['access']?? []),
      nombreChambre: map['nombreChambre'] ?? null,
      nombreSalleBain: map['nombreSalleBain'] ?? null,
      surfaceBalcon: map['surfaceBalcon'] ?? null,
      exterior: List<String>.from(map['exterior'] ?? []),
      dateConstruction: map['dateConstruction'] ?? '',
      situation: map['situation'] ?? '',
      standing: map['standing'] ?? '',
      cuisine: map['cuisine'] ?? '',
      salleManger: map['salleManger'] ?? '',
      nombrePlacard: map['nombrePlacard'] ?? null,
      interior: List<String>.from(map['interior'] ?? []),
      serviceInclus: List<String>.from(map['serviceInclus'] ?? []),
      typeSol: List<String>.from(map['typeSol'] ?? []),
      proximite: List<String>.from(map['proximite'] ?? []),
      stateGenerale: map['stateGenerale'] ?? '',
      toiture: List<String>.from(map['toiture'] ?? []),
      facade:  List<String>.from(map['facade'] ?? []),
      state: map['state'] ?? '',
      aType: map['aType'] ?? '',
      brand: map['brand'] ?? '',
      optionPhoto: map['optionPhoto'] ?? null,
      optionAdHeadEnd: map['optionAdHeadEnd'] ?? null,
      optionAdUrgentsEnd: map['optionAdUrgentsEnd'] ?? null,
      optionAdGalleryEnd: map['optionAdGalleryEnd'] ?? null,
      optionAdVedetteEnd: map['optionAdVedetteEnd'] ?? null,
      optionAdEncadreEnd: map['optionAdEncadreEnd'] ?? null,
      status: map['status'] ?? '',
    );
  }
}

class AdvertDataResponse extends Equatable {
  const AdvertDataResponse({this.status, this.message, this.data});

  final String? status;
  final String? message;
  final bool? data;

  @override
  List<Object?> get props => [status, message, data];

  AdvertData toEntity() {
    return AdvertData(status: status, message: message, data: data);
  }

  factory AdvertDataResponse.fromMap(Map<String, dynamic> map) {
    return AdvertDataResponse(
      status: map['status'] ?? '',
      message: map['message'] ?? '',
      data: map['data'] ?? null
    );
  }
}

class AdvertImageDeleteResponse extends Equatable {
  const AdvertImageDeleteResponse({this.status});

  final String? status;

  @override
  List<Object?> get props => [status];

  AdvertData toEntity() {
    return AdvertData(status: status);
  }

  factory AdvertImageDeleteResponse.fromMap(Map<String, dynamic> map) {
    return AdvertImageDeleteResponse(
        status: map['status'] ?? '',
    );
  }
}


