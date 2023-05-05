//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'body_activities_v1_my_activities_get.g.dart';

/// BodyActivitiesV1MyActivitiesGet
///
/// Properties:
/// * [code] 
@BuiltValue()
abstract class BodyActivitiesV1MyActivitiesGet implements Built<BodyActivitiesV1MyActivitiesGet, BodyActivitiesV1MyActivitiesGetBuilder> {
  @BuiltValueField(wireName: r'code')
  String get code;

  BodyActivitiesV1MyActivitiesGet._();

  factory BodyActivitiesV1MyActivitiesGet([void updates(BodyActivitiesV1MyActivitiesGetBuilder b)]) = _$BodyActivitiesV1MyActivitiesGet;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(BodyActivitiesV1MyActivitiesGetBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<BodyActivitiesV1MyActivitiesGet> get serializer => _$BodyActivitiesV1MyActivitiesGetSerializer();
}

class _$BodyActivitiesV1MyActivitiesGetSerializer implements PrimitiveSerializer<BodyActivitiesV1MyActivitiesGet> {
  @override
  final Iterable<Type> types = const [BodyActivitiesV1MyActivitiesGet, _$BodyActivitiesV1MyActivitiesGet];

  @override
  final String wireName = r'BodyActivitiesV1MyActivitiesGet';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    BodyActivitiesV1MyActivitiesGet object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'code';
    yield serializers.serialize(
      object.code,
      specifiedType: const FullType(String),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    BodyActivitiesV1MyActivitiesGet object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required BodyActivitiesV1MyActivitiesGetBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'code':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.code = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  BodyActivitiesV1MyActivitiesGet deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = BodyActivitiesV1MyActivitiesGetBuilder();
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

