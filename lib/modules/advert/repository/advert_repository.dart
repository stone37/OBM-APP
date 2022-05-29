import 'dart:io';
import 'package:obm_market/modules/advert/models/entities/advert.dart';
import 'package:obm_market/modules/advert/models/request/advert_request.dart';
import 'package:obm_market/modules/advert/services/remote_advert_api.dart';

class AdvertRepository {

  Future<AdvertList> getAdvertList({
    required int page,
    required int itemsPerPage,
    String? category,
    int? levelDepth,
    String? positionOrder,
    String? priceOrder,
    String? type,
    String? city,
    String? zone,
    int? priceMin,
    int? priceMax,
    String? marque,
    String? model,
    String? typeCarburant,
    int? kiloMin,
    int? kiloMax,
    String? autoYearMin,
    String? autoYearMax,

    int? surfaceMin,
    int? surfaceMax,
    String? immoState,
    String? nombrePiece,
    int? nombreChambre,
    int? nombreSalleBain,
    String? access,
    String? proximite,
    String? interior,
    String? exterior,
    String? state,
    String? brand,
  }) {
    return RemoteAdvertApi
      .getAdvertList(AdvertFilterRequest(
        page: page,
        itemsPerPage: itemsPerPage,
        category: category,
        categoryLevel: levelDepth,
        positionOrder: positionOrder,
        priceOrder: priceOrder,
        type: type,
        locationName: city,
        locationDetail: zone,
        priceMin: priceMin,
        priceMax: priceMax,
        marque: marque,
        model: model,
        typeCarburant: typeCarburant,
        kiloMin: kiloMin,
        kiloMax: kiloMax,
        autoYearMin: autoYearMin,
        autoYearMax: autoYearMax,
        surfaceMin: surfaceMin,
        surfaceMax: surfaceMax,
        immobilierState: immoState,
        nombrePiece: nombrePiece,
        nombreChambre: nombreChambre,
        nombreSalleBain: nombreSalleBain,
        access: access,
        proximite: proximite,
        interior: interior,
        exterior: exterior,
        brand: brand,
        state: state,
      ))
      .then((value) => value!.toEntity());
  }

  Future<List<Advert>> getCounts({
    String? category,
    int? levelDepth,
    String? city,
  }) {
    return RemoteAdvertApi
        .getCounts(AdvertCountFilterRequest(
        category: category,
        categoryLevel: levelDepth,
        locationName: city))
        .then((value) => value.map((e) => e.toEntity()).toList());
  }

  Future<List<Advert>> getSimilar({required int page, required int itemsPerPage, required int id}) {
    return RemoteAdvertApi.getSimilar(AdvertSimilarRequest(id: id, page: page, itemsPerPage: itemsPerPage))
      .then((value) => value.map((e) => e.toEntity()).toList());
  }

  Future<Advert> create({
    required int categoryId, required String token, required String title, required String description,
    required int price, required String type, required String city, String? zone, String? traitement,
    String? marque, String? model, String? autoYear, String? autoType, String? autoState, int? kilo,
    String? boiteVitesse, String? transmission, String? autoColor, String? typeCarburant, String? nombrePorte,
    String? nombrePlace, List<String>? autreInformation, int? cylindree, List<String>? autoSecurity,
    List<String>? informationExterieur, int? surface, String? nombrePiece, String? immobilierState,
    List<String>? access, int? nombreChambre, int? nombreSalleBain, int? surfaceBalcon, List<String>? exterior,
    String? dateConstruction, String? situation, String? standing, String? cuisine, String? salleManger,
    int? nombrePlacard, List<String>? interior, List<String>? serviceInclus, List<String>? typeSol,
    List<String>? proximite, String? stateGenerale, List<String>? facade, List<String>? toiture,
    String? state, String? aType, String? brand
  }) {
    return RemoteAdvertApi
        .create(AdvertRequest(
          categoryId: categoryId, token: token, title: title, description: description, price: price,
          type: type, locationName: city, locationDetail: zone, traitement: traitement, marque: marque,
          model: model, autoYear: autoYear, autoType: autoType, autoState: autoState, kilo: kilo,
          boiteVitesse: boiteVitesse, transmission: transmission, autoColor: autoColor,
          typeCarburant: typeCarburant, nombrePorte: nombrePorte, nombrePlace: nombrePlace,
          autreInformation: autreInformation, cylindree: cylindree, autoSecurity: autoSecurity,
          informationExterieur: informationExterieur, surface: surface, nombrePiece: nombrePiece,
          immobilierState: immobilierState, access: access, nombreChambre: nombreChambre,
          nombreSalleBain: nombreSalleBain, surfaceBalcon: surfaceBalcon, exterior: exterior,
          nombrePlacard: nombrePlacard, interior: interior, dateConstruction: dateConstruction,
          situation: situation, standing: standing, cuisine: cuisine, salleManger: salleManger,
          serviceInclus: serviceInclus, typeSol: typeSol, proximite: proximite, facade: facade,
          toiture: toiture, stateGenerale: stateGenerale, state: state, brand: brand, aType: aType
        ))
        .then((value) => value.toEntity());
  }

  Future<Advert> edit({
    required int id, required String token, required String title, required String description,
    required int price, required String city, String? zone, String? traitement,
    String? marque, String? model, String? autoYear, String? autoType, String? autoState, int? kilo,
    String? boiteVitesse, String? transmission, String? autoColor, String? typeCarburant, String? nombrePorte,
    String? nombrePlace, List<String>? autreInformation, int? cylindree, List<String>? autoSecurity,
    List<String>? informationExterieur, int? surface, String? nombrePiece, String? immobilierState,
    List<String>? access, int? nombreChambre, int? nombreSalleBain, int? surfaceBalcon, List<String>? exterior,
    String? dateConstruction, String? situation, String? standing, String? cuisine, String? salleManger,
    int? nombrePlacard, List<String>? interior, List<String>? serviceInclus, List<String>? typeSol,
    List<String>? proximite, String? stateGenerale, List<String>? facade, List<String>? toiture,
    String? state, String? aType, String? brand
  }) {
    return RemoteAdvertApi
        .edit(AdvertEditRequest(
        id: id, token: token, title: title, description: description, price: price,
        locationName: city, locationDetail: zone, traitement: traitement, marque: marque,
        model: model, autoYear: autoYear, autoType: autoType, autoState: autoState, kilo: kilo,
        boiteVitesse: boiteVitesse, transmission: transmission, autoColor: autoColor,
        typeCarburant: typeCarburant, nombrePorte: nombrePorte, nombrePlace: nombrePlace,
        autreInformation: autreInformation, cylindree: cylindree, autoSecurity: autoSecurity,
        informationExterieur: informationExterieur, surface: surface, nombrePiece: nombrePiece,
        immobilierState: immobilierState, access: access, nombreChambre: nombreChambre,
        nombreSalleBain: nombreSalleBain, surfaceBalcon: surfaceBalcon, exterior: exterior,
        nombrePlacard: nombrePlacard, interior: interior, dateConstruction: dateConstruction,
        situation: situation, standing: standing, cuisine: cuisine, salleManger: salleManger,
        serviceInclus: serviceInclus, typeSol: typeSol, proximite: proximite, facade: facade,
        toiture: toiture, stateGenerale: stateGenerale, state: state, brand: brand, aType: aType
    ))
        .then((value) => value.toEntity());
  }

  Future<AdvertData> upload({required id, required List<File> files, required String token}) {
    return RemoteAdvertApi.upload(AdvertImageRequest(id: id, images: files, token: token))
        .then((value) => value.toEntity());
  }

  Future<AdvertData> initClear({required String token}) {
    return RemoteAdvertApi.initClear(AdvertImageDataRequest(token: token))
        .then((value) => value.toEntity());
  }

  Future<List<Advert>> getUserAdvert({required int id, required String token}) {
    return RemoteAdvertApi
        .getUserAdvert(AdvertUserRequest(id: id, token: token))
        .then((value) => value.map((e) => e.toEntity()).toList());
  }

  Future<List<Advert>> getUserAdvertEnabled({required int id, required String token}) {
    return RemoteAdvertApi
        .getUserAdvertEnabled(AdvertUserRequest(id: id, token: token))
        .then((value) => value.map((e) => e.toEntity()).toList());
  }

  Future<AdvertData> delete({required int id, required String token}) {
    return RemoteAdvertApi.deleteAdvert(AdvertUserRequest(id: id, token: token))
        .then((value) => value!.toEntity());
  }

  Future<AdvertData> check({required int id, required String token}) {
    return RemoteAdvertApi.checkAdvert(AdvertUserRequest(id: id, token: token))
        .then((value) => value!.toEntity());
  }

  Future<AdvertData> checkThread({required int id, required String token}) {
    return RemoteAdvertApi.checkAdvert(AdvertUserRequest(id: id, token: token))
        .then((value) => value!.toEntity());
  }

  Future<AdvertData> deletePicture({required int id, required String token}) {
    return RemoteAdvertApi.deletePicture(AdvertUserRequest(id: id, token: token))
        .then((value) => value!.toEntity());
  }
}

