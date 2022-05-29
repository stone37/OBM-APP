import 'package:get/get.dart';

class Validator {
  Validator();

  String? notBlank(String? value) {
    if (value == null || value.isEmpty)
      return 'Ce change est obligatoire';
    else
      return null;
  }

  String? email(String? value) {
    String pattern = r'^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+';
    RegExp regex = RegExp(pattern);

    if (!regex.hasMatch(value!))
      return 'Entrer une adresse email valide';
    else
      return null;
  }

  String? password(String? value) {
    String pattern = r'^.{8,}$';
    RegExp regex = RegExp(pattern);

    if (!regex.hasMatch(value!))
      return 'Votre mot de passe doit comporter au moins 8 caractères';
    else
      return null;
  }

  String? name(String? value) {
    String pattern = r"^[a-zA-Z]+(([',. -][a-zA-Z ])?[a-zA-Z]*)*$";
    RegExp regex = RegExp(pattern);

    if (!regex.hasMatch(value!))
      return 'validator.name'.tr;
    else
      return null;
  }

  String? number(String? value) {
    String pattern = r'^\D?(\d{3})\D?\D?(\d{3})\D?(\d{4})$';
    RegExp regex = RegExp(pattern);

    if (!regex.hasMatch(value!))
      return 'validator.number'.tr;
    else
      return null;
  }

  String? amount(String? value) {
    String pattern = r'^\d+$';
    RegExp regex = RegExp(pattern);

    if (!regex.hasMatch(value!))
      return 'validator.amount'.tr;
    else
      return null;
  }

  String? notEmpty(String? value) {
    String pattern = r'^\S+$';
    RegExp regex = RegExp(pattern);

    if (!regex.hasMatch(value!))
      return 'validator.notEmpty'.tr;
    else
      return null;
  }
}

class RegisterValidator {
  RegisterValidator({this.passwordData});

  String? passwordData;

  String? notBlank(String? value) {
    if (value == null || value.isEmpty)
      return 'Ce change est obligatoire';
    else
      return null;
  }

  String? username(String? value) {
    if (value == null || value.isEmpty)
      return 'Entrez un nom d\'utilisateur s\'il vous plait.';
    else
      return null;
  }

  String? lastname(String? value) {
    if (value == null || value.isEmpty)
      return 'Entrez un nom s\'il vous plait.';
    else if (value.length < 2)
      return 'Le nom est trop court.';
    else if (value.length > 180)
      return 'Le nom est trop long.';
    else
      return null;
  }

  String? firstname(String? value) {
    if (value == null || value.isEmpty)
      return 'Entrez un prénom s\'il vous plait.';
    else if (value.length < 2)
      return 'Le prénom est trop court.';
    else if (value.length > 180)
      return 'Le prénom est trop long.';
    else
      return null;
  }

  String? email(String? value) {
    String pattern = r'^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+';
    RegExp regex = RegExp(pattern);

    if (value == null || value.isEmpty)
      return 'Entrez une adresse e-mail s\'il vous plait.';
    else if (!regex.hasMatch(value))
      return 'L\'adresse e-mail est invalide.';
    else
      return null;
  }

  String? phone(String? value) {
    if (value == null || value.isEmpty)
      return 'Entrez un numéro de téléphone s''il vous plait.';
    else if (value.length < 10)
      return 'Le numéro de téléphone est trop court.';
    else if (value.length > 16)
      return 'Le numéro de téléphone est trop long.';
    else
      return null;
  }

  String? password(String? value) {
    String pattern = r'^.{8,}$';
    RegExp regex = RegExp(pattern);

    if (value == null || value.isEmpty)
      return 'Veuillez entrer un mot de passe.';
    else if (!regex.hasMatch(value))
      return 'Votre mot de passe doit comporter au moins 8 caractères.';
    else
      return null;
  }

  String? passwordRepeat(String? value) {
    if (value == null || value.isEmpty)
      return 'Veuillez entrer un mot de passe.';
    else if (value != passwordData)
      return 'Les deux mot de passe sont different.';
    else
      return null;
  }
}

class AdvertValidator {
  AdvertValidator();

  String? title(String? value) {
    if (value == null || value.isEmpty)
      return 'Le titre ne doit pas comporter moins 10 caractères.';
    else if (value.length < 10)
      return 'Le titre ne doit pas comporter moins 10 caractères.';
    else if (value.length > 120)
      return 'Le titre ne doit pas comporter plus 120 caractères.';
    else
      return null;
  }

  String? description(String? value) {
    if (value == null || value.isEmpty)
      return 'La description ne doit pas comporter moins 10 caractères.';
    else if (value.length < 10)
      return 'La description ne doit pas comporter moins 10 caractères.';
    else
      return null;
  }



  String? city(String? value) {
    if (value == null || value.isEmpty)
      return 'Veuillez choisir une ville';
    else
      return null;
  }

  String? notBlank(String? value) {
    if (value == null || value.isEmpty)
      return 'Ce change est obligatoire';
    else
      return null;
  }

  String? username(String? value) {
    if (value == null || value.isEmpty)
      return 'Entrez un nom d\'utilisateur s\'il vous plait.';
    else
      return null;
  }

  String? lastname(String? value) {
    if (value == null || value.isEmpty)
      return 'Entrez un nom s\'il vous plait.';
    else if (value.length < 2)
      return 'Le nom est trop court.';
    else if (value.length > 180)
      return 'Le nom est trop long.';
    else
      return null;
  }

  String? firstname(String? value) {
    if (value == null || value.isEmpty)
      return 'Entrez un prénom s\'il vous plait.';
    else if (value.length < 2)
      return 'Le prénom est trop court.';
    else if (value.length > 180)
      return 'Le prénom est trop long.';
    else
      return null;
  }

  String? email(String? value) {
    String pattern = r'^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+';
    RegExp regex = RegExp(pattern);

    if (value == null || value.isEmpty)
      return 'Entrez une adresse e-mail s\'il vous plait.';
    else if (!regex.hasMatch(value))
      return 'L\'adresse e-mail est invalide.';
    else
      return null;
  }

  String? phone(String? value) {
    if (value == null || value.isEmpty)
      return 'Entrez un numéro de téléphone s''il vous plait.';
    else if (value.length < 10)
      return 'Le numéro de téléphone est trop court.';
    else if (value.length > 16)
      return 'Le numéro de téléphone est trop long.';
    else
      return null;
  }

  String? password(String? value) {
    String pattern = r'^.{8,}$';
    RegExp regex = RegExp(pattern);

    if (value == null || value.isEmpty)
      return 'Veuillez entrer un mot de passe.';
    else if (!regex.hasMatch(value))
      return 'Votre mot de passe doit comporter au moins 8 caractères.';
    else
      return null;
  }
}

