import 'package:equatable/equatable.dart';

class Settings extends Equatable {
  const Settings({
    required this.name,
    required this.phone,
    required this.email,
    this.facebook,
    this.twitter,
    this.instagram,
    this.youtube,
    this.linkedin,
    this.messageState,
    this.favorisState,
    this.alertState,
    this.adSimilarState,
    this.creditState,
    this.cardPaymentState,
    this.vignetteState,
    this.pubState,
    this.parrainageState,
    this.parrainageCredit,
    this.fioleCredit,
    this.parrainageAd,
  });

  final String name;
  final String email;
  final String phone;
  final String? facebook;
  final String? twitter;
  final String? instagram;
  final String? youtube;
  final String? linkedin;
  final bool? messageState;
  final bool? favorisState;
  final bool? alertState;
  final bool? adSimilarState;
  final bool? creditState;
  final bool? cardPaymentState;
  final bool? vignetteState;
  final bool? pubState;
  final bool? parrainageState;
  final int? parrainageCredit;
  final int? fioleCredit;
  final int? parrainageAd;


  @override
  List<Object?> get props => [
    name,
    email,
    phone
  ];
}



