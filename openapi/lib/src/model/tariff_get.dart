//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:openapi/src/model/tariff_limit_get.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'tariff_get.g.dart';

/// TariffGet
///
/// Properties:
/// * [id] 
/// * [code] 
/// * [price] 
/// * [hidden] 
/// * [limits] 
@BuiltValue()
abstract class TariffGet implements Built<TariffGet, TariffGetBuilder> {
  @BuiltValueField(wireName: r'id')
  int get id;

  @BuiltValueField(wireName: r'code')
  String get code;

  @BuiltValueField(wireName: r'price')
  int get price;

  @BuiltValueField(wireName: r'hidden')
  bool get hidden;

  @BuiltValueField(wireName: r'limits')
  BuiltList<TariffLimitGet> get limits;

  TariffGet._();

  factory TariffGet([void updates(TariffGetBuilder b)]) = _$TariffGet;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(TariffGetBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<TariffGet> get serializer => _$TariffGetSerializer();
}

class _$TariffGetSerializer implements PrimitiveSerializer<TariffGet> {
  @override
  final Iterable<Type> types = const [TariffGet, _$TariffGet];

  @override
  final String wireName = r'TariffGet';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    TariffGet object, {
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
    yield r'price';
    yield serializers.serialize(
      object.price,
      specifiedType: const FullType(int),
    );
    yield r'hidden';
    yield serializers.serialize(
      object.hidden,
      specifiedType: const FullType(bool),
    );
    yield r'limits';
    yield serializers.serialize(
      object.limits,
      specifiedType: const FullType(BuiltList, [FullType(TariffLimitGet)]),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    TariffGet object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required TariffGetBuilder result,
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
            specifiedType: const FullType(int),
          ) as int;
          result.price = valueDes;
          break;
        case r'hidden':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(bool),
          ) as bool;
          result.hidden = valueDes;
          break;
        case r'limits':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(BuiltList, [FullType(TariffLimitGet)]),
          ) as BuiltList<TariffLimitGet>;
          result.limits.replace(valueDes);
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  TariffGet deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = TariffGetBuilder();
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

