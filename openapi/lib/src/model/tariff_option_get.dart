//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'tariff_option_get.g.dart';

/// TariffOptionGet
///
/// Properties:
/// * [id] 
/// * [code] 
/// * [price] 
/// * [tariffQuantity] 
/// * [freeLimit] 
@BuiltValue()
abstract class TariffOptionGet implements Built<TariffOptionGet, TariffOptionGetBuilder> {
  @BuiltValueField(wireName: r'id')
  int get id;

  @BuiltValueField(wireName: r'code')
  String get code;

  @BuiltValueField(wireName: r'price')
  num? get price;

  @BuiltValueField(wireName: r'tariff_quantity')
  num? get tariffQuantity;

  @BuiltValueField(wireName: r'free_limit')
  num? get freeLimit;

  TariffOptionGet._();

  factory TariffOptionGet([void updates(TariffOptionGetBuilder b)]) = _$TariffOptionGet;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(TariffOptionGetBuilder b) => b
      ..price = 0
      ..tariffQuantity = 1
      ..freeLimit = 0;

  @BuiltValueSerializer(custom: true)
  static Serializer<TariffOptionGet> get serializer => _$TariffOptionGetSerializer();
}

class _$TariffOptionGetSerializer implements PrimitiveSerializer<TariffOptionGet> {
  @override
  final Iterable<Type> types = const [TariffOptionGet, _$TariffOptionGet];

  @override
  final String wireName = r'TariffOptionGet';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    TariffOptionGet object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'id';
    yield serializers.serialize(
      object.id,
      specifiedType: const FullType(int),
    );
    yield r'code';
    yield serializers.serialize(
      object.code,
      specifiedType: const FullType(String),
    );
    if (object.price != null) {
      yield r'price';
      yield serializers.serialize(
        object.price,
        specifiedType: const FullType(num),
      );
    }
    if (object.tariffQuantity != null) {
      yield r'tariff_quantity';
      yield serializers.serialize(
        object.tariffQuantity,
        specifiedType: const FullType(num),
      );
    }
    if (object.freeLimit != null) {
      yield r'free_limit';
      yield serializers.serialize(
        object.freeLimit,
        specifiedType: const FullType(num),
      );
    }
  }

  @override
  Object serialize(
    Serializers serializers,
    TariffOptionGet object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required TariffOptionGetBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'id':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.id = valueDes;
          break;
        case r'code':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.code = valueDes;
          break;
        case r'price':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(num),
          ) as num;
          result.price = valueDes;
          break;
        case r'tariff_quantity':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(num),
          ) as num;
          result.tariffQuantity = valueDes;
          break;
        case r'free_limit':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(num),
          ) as num;
          result.freeLimit = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  TariffOptionGet deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = TariffOptionGetBuilder();
    final serializedList = (serialized as Iterable<Object?>).toList();
    final unhandled = <Object?>[];
    _deserializeProperties(
      serializers,
      serialized,
      specifiedType: specifiedType,
      serializedList: serializedList,
      unhandled: unhandled,
      result: result,
    );
    return result.build();
  }
}

