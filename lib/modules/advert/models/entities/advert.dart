import 'package:equatable/equatable.dart';

class Advert extends Equatable {
  const Advert({
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
    this.createdAt,
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
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final DateTime? validatedAt;

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
  final DateTime? optionAdHeadEnd;
  final DateTime? optionAdUrgentsEnd;
  final DateTime? optionAdGalleryEnd;
  final DateTime? optionAdVedetteEnd;
  final DateTime? optionAdEncadreEnd;

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

  String photoPrincipale() {
    String data = '';

    images.map((image) {
      if (image['principale']) data = image['webPath'].toString();
    });

    if (data.isEmpty) data = images[0]['webPath'];

    return data;
  }
}

class AdvertData extends Equatable {
  const AdvertData({this.status, this.message, this.data});

  final String? status;
  final String? message;
  final bool? data;

  @override
  List<Object?> get props => [status, message, data];
}

class AdvertList extends Equatable {
  const AdvertList({
    required this.totalItems,
    required this.adverts,
    required this.hydraView,

  });

  final int totalItems;
  final List<Advert> adverts;
  final Map<String, dynamic> hydraView;

  @override
  List<Object?> get props => [totalItems, adverts, hydraView];
}
