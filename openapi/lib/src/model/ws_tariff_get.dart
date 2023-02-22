//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:openapi/src/model/tariff_get.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'ws_tariff_get.g.dart';

/// WSTariffGet
///
/// Properties:
/// * [id] 
/// * [expiresOn] 
/// * [tariff] 
@BuiltValue()
abstract class WSTariffGet implements Built<WSTariffGet, WSTariffGetBuilder> {
  @BuiltValueField(wireName: r'id')
  int get id;

  @BuiltValueField(wireName: r'expires_on')
  DateTime? get expiresOn;

  @BuiltValueField(wireName: r'tariff')
  TariffGet get tariff;

  WSTariffGet._();

  factory WSTariffGet([void updates(WSTariffGetBuilder b)]) = _$WSTariffGet;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(WSTariffGetBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<WSTariffGet> get serializer => _$WSTariffGetSerializer();
}

class _$WSTariffGetSerializer implements PrimitiveSerializer<WSTariffGet> {
  @override
  final Iterable<Type> types = const [WSTariffGet, _$WSTariffGet];

  @override
  final String wireName = r'WSTariffGet';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    WSTariffGet object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'id';
    yield serializers.serialize(
      object.id,
      specifiedType: const FullType(int),
    );
    if (object.expiresOn != null) {
      yield r'expires_on';
      yield serializers.serialize(
        object.expiresOn,
        specifiedType: const FullType(DateTime),
      );
    }
    yield r'tariff';
    yield serializers.serialize(
      object.tariff,
      specifiedType: const FullType(TariffGet),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    WSTariffGet object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required WSTariffGetBuilder result,
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
        case r'expires_on':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(DateTime),
          ) as DateTime;
          result.expiresOn = valueDes;
          break;
        case r'tariff':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(TariffGet),
          ) as TariffGet;
          result.tariff.replace(valueDes);
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  WSTariffGet deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = WSTariffGetBuilder();
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

