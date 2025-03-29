//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:avanplan_api/src/model/estimate_unit_get.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'settings_get.g.dart';

/// SettingsGet
///
/// Properties:
/// * [id]
/// * [estimateUnit]
@BuiltValue()
abstract class SettingsGet implements Built<SettingsGet, SettingsGetBuilder> {
  @BuiltValueField(wireName: r'id')
  int get id;

  @BuiltValueField(wireName: r'estimate_unit')
  EstimateUnitGet? get estimateUnit;

  SettingsGet._();

  factory SettingsGet([void updates(SettingsGetBuilder b)]) = _$SettingsGet;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(SettingsGetBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<SettingsGet> get serializer => _$SettingsGetSerializer();
}

class _$SettingsGetSerializer implements PrimitiveSerializer<SettingsGet> {
  @override
  final Iterable<Type> types = const [SettingsGet, _$SettingsGet];

  @override
  final String wireName = r'SettingsGet';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    SettingsGet object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'id';
    yield serializers.serialize(
      object.id,
      specifiedType: const FullType(int),
    );
    if (object.estimateUnit != null) {
      yield r'estimate_unit';
      yield serializers.serialize(
        object.estimateUnit,
        specifiedType: const FullType(EstimateUnitGet),
      );
    }
  }

  @override
  Object serialize(
    Serializers serializers,
    SettingsGet object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required SettingsGetBuilder result,
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
        case r'estimate_unit':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(EstimateUnitGet),
          ) as EstimateUnitGet;
          result.estimateUnit.replace(valueDes);
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  SettingsGet deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = SettingsGetBuilder();
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
