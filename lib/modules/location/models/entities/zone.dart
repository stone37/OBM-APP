import 'package:equatable/equatable.dart';

class Zone extends Equatable {
  const Zone({
    required this.name
  });

  final String name;

  @override
  List<Object?> get props => [name];
}


