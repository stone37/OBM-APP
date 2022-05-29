import 'package:equatable/equatable.dart';

class Alert extends Equatable {
  const Alert({
    this.id,
    this.category,
    this.subCategory,
    this.subDivision,
    this.user,
    this.status
  });

  final int? id;
  final Map<String, dynamic>? category;
  final Map<String, dynamic>? subCategory;
  final Map<String, dynamic>? subDivision;
  final Map<String, dynamic>? user;
  final String? status;

  @override
  List<Object?> get props => [id, category, subCategory, subDivision, user, status];
}

class AlertData extends Equatable {
  const AlertData({
    this.status,
    this.message
  });

  final String? status;
  final String? message;

  @override
  List<Object?> get props => [status, message];
}


