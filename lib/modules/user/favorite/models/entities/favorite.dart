import 'package:equatable/equatable.dart';

import '../../../../advert/models/entities/advert.dart';

class Favorite extends Equatable {
  const Favorite({
    this.id,
    this.user,
    this.advert,
    this.status
  });

  final int? id;
  final Advert? advert;
  final Map<String, dynamic>? user;
  final String? status;

  @override
  List<Object?> get props => [id, user, advert, status];
}


