//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:openapi/src/model/limit_get.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'limit_tariff_get.g.dart';

/// LimitTariffGet
///
/// Properties:
/// * [id] 
/// * [value] 
/// * [limit] 
@BuiltValue()
abstract class LimitTariffGet implements Built<LimitTariffGet, LimitTariffGetBuilder> {
  @BuiltValueField(wireName: r'id')
  int get id;

  @BuiltValueField(wireName: r'value')
  int get value;

  @BuiltValueField(wireName: r'limit')
  LimitGet get limit;

  LimitTariffGet._();

  factory LimitTariffGet([void updates(LimitTariffGetBuilder b)]) = _$LimitTariffGet;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(LimitTariffGetBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<LimitTariffGet> get serializer => _$LimitTariffGetSerializer();
}

class _$LimitTariffGetSerializer implements PrimitiveSerializer<LimitTariffGet> {
  @override
  final Iterable<Type> types = const [LimitTariffGet, _$LimitTariffGet];

  @override
  final String wireName = r'LimitTariffGet';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    LimitTariffGet object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'id';
    yield serializers.serialize(
      object.id,
      specifiedType: const FullType(int),
    );
    yield r'value';
    yield serializers.serialize(
      object.value,
      specifiedType: const FullType(int),
    );
    yield r'limit';
    yield serializers.serialize(
      object.limit,
      specifiedType: const FullType(LimitGet),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    LimitTariffGet object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required LimitTariffGetBuilder result,
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
        case r'value':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.value = valueDes;
          break;
        case r'limit':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(LimitGet),
          ) as LimitGet;
          result.limit.replace(valueDes);
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  LimitTariffGet deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = LimitTariffGetBuilder();
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

