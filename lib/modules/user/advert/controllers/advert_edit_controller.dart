import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class AdvertEditController extends GetxController {

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

  RxList<File> images = [new File('')].obs;
  late ImagePicker imagePicker;

  @override
  void onInit() {
    super.onInit();

    imagePicker = ImagePicker();
  }

  @override
  void onClose() {
    super.onClose();
  }
}

