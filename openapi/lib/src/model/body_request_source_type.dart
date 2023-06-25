//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'body_request_source_type.g.dart';

/// BodyRequestSourceType
///
/// Properties:
/// * [code] 
@BuiltValue()
abstract class BodyRequestSourceType implements Built<BodyRequestSourceType, BodyRequestSourceTypeBuilder> {
  @BuiltValueField(wireName: r'code')
  String get code;

  BodyRequestSourceType._();

  factory BodyRequestSourceType([void updates(BodyRequestSourceTypeBuilder b)]) = _$BodyRequestSourceType;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(BodyRequestSourceTypeBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<BodyRequestSourceType> get serializer => _$BodyRequestSourceTypeSerializer();
}

class _$BodyRequestSourceTypeSerializer implements PrimitiveSerializer<BodyRequestSourceType> {
  @override
  final Iterable<Type> types = const [BodyRequestSourceType, _$BodyRequestSourceType];

  @override
  final String wireName = r'BodyRequestSourceType';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    BodyRequestSourceType object, {
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
    BodyRequestSourceType object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required BodyRequestSourceTypeBuilder result,
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
  BodyRequestSourceType deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = BodyRequestSourceTypeBuilder();
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

