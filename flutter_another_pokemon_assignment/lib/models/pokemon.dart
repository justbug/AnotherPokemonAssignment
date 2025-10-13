import 'package:equatable/equatable.dart';

/// Pokemon 模型
/// 對應 iOS 的 Pokemon struct
class Pokemon extends Equatable {
  final String name;
  final String id;

  const Pokemon({
    required this.name,
    required this.id,
  });

  @override
  List<Object> get props => [name, id];

  @override
  String toString() => 'Pokemon(name: $name, id: $id)';
}
