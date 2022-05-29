import 'package:equatable/equatable.dart';

class CityRequest extends Equatable {
  const CityRequest({this.name});

  final String? name;

  @override
  List<Object?> get props => [name];

  Map<String, dynamic> toMap() {
    final queryParameters = {'name': name};

    return queryParameters;
  }
}