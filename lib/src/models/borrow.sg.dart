import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'borrow.sg.g.dart';

abstract class Borrow implements Built<Borrow, BorrowBuilder> {

  String get toId;

  String get fromId;

  double get amount;

  static Serializer<Borrow> get serializer => _$borrowSerializer;

  factory Borrow([void Function(BorrowBuilder) updates]) = _$Borrow;
  Borrow._();
}