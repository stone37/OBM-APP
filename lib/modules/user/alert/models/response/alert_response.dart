import 'package:equatable/equatable.dart';
import 'package:obm_market/modules/user/alert/models/entities/alert.dart';


class AlertResponse extends Equatable {
  const AlertResponse({
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

  Alert toEntity() {
    return Alert(
      id: id,
      category: category,
      subCategory: subCategory,
      subDivision: subDivision,
      user: user,
      status: status
    );
  }

  factory AlertResponse.fromMap(Map<String, dynamic> map) {
    return AlertResponse(
      id: (map['id'] == null) ? null : map['id'],
      status: map['status'] ?? '',
      category: ((map['category']) == null) ? null : Map<String, dynamic>.from(map['category']),
      subCategory: ((map['subCategory']) == null) ? null : Map<String, dynamic>.from(map['subCategory']),
      subDivision: ((map['subDivision']) == null) ? null : Map<String, dynamic>.from(map['subDivision']),
      user: ((map['user']) == null) ? null : Map<String, dynamic>.from(map['user']),
    );
  }
}


class AlertDataResponse extends Equatable {
  const AlertDataResponse({this.status, this.message});

  final String? status;
  final String? message;

  @override
  List<Object?> get props => [status, message];

  AlertData toEntity() {
    return AlertData(
      status: status,
      message: message
    );
  }

  factory AlertDataResponse.fromMap(Map<String, dynamic> map) {
    return AlertDataResponse(
      status: map['status'] ?? '',
      message: map['message'] ?? '',
    );
  }
}





