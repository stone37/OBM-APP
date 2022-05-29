import 'package:equatable/equatable.dart';

class CategoryRequest extends Equatable {
  const CategoryRequest({required this.id});

  final int id;

  @override
  List<Object?> get props => [id];

  Map<String, dynamic> toMap() {
    final queryParameters = {'id': id};

    return queryParameters;
  }
}