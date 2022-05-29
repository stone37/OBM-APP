import 'package:equatable/equatable.dart';
import 'package:obm_market/modules/settings/models/entities/settings.dart';

class SettingsResponse extends Equatable {
  const SettingsResponse({
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
    phone,
    email
  ];

  Settings toEntity() {
    return Settings(
      name: name,
      email: email,
      phone: phone,
      facebook: facebook,
      twitter: twitter,
      instagram: instagram,
      linkedin: linkedin,
      youtube: youtube,
      messageState: messageState,
      favorisState: favorisState,
      alertState: alertState,
      adSimilarState: adSimilarState,
      cardPaymentState: cardPaymentState,
      creditState: creditState,
      vignetteState: vignetteState,
      pubState: pubState,
      parrainageState: parrainageState,
      parrainageCredit: parrainageCredit,
      fioleCredit: fioleCredit,
      parrainageAd: parrainageAd
    );
  }

  factory SettingsResponse.fromMap(Map<String, dynamic> map) {
    return SettingsResponse(
      name: map['name'] ?? '',
      email: map['email'] ?? '',
      phone: map['phone'] ?? '',
      facebook: map['facebookAddress'] ?? '',
      twitter: map['twitterAddress'] ?? '',
      instagram: map['instagramAddress'] ?? '',
      youtube: map['youtubeAddress'] ?? '',
      linkedin: map['linkedinAddress'] ?? '',
      messageState: map['activeMessage'] ?? '',
      favorisState: map['activeAdFavorite'] ?? '',
      alertState: map['activeAlert'] ?? '',
      adSimilarState: map['activeAdSimilar'] ?? '',
      cardPaymentState: map['activeCardPayment'] ?? '',
      creditState: map['activeCredit'] ?? '',
      vignetteState: map['activeVignette'] ?? '',
      pubState: map['activePub'] ?? '',
      parrainageState: map['activeParrainage'] ?? '',
      parrainageCredit: map['parrainCredit'] ?? '',
      fioleCredit: map['fioleCredit'] ?? '',
      parrainageAd: map['parrainageAd'] ?? '',
    );
  }
}

