//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'body_request_type.g.dart';

/// BodyRequestType
///
/// Properties:
/// * [code] 
@BuiltValue()
abstract class BodyRequestType implements Built<BodyRequestType, BodyRequestTypeBuilder> {
  @BuiltValueField(wireName: r'code')
  String get code;

  BodyRequestType._();

  factory BodyRequestType([void updates(BodyRequestTypeBuilder b)]) = _$BodyRequestType;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(BodyRequestTypeBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<BodyRequestType> get serializer => _$BodyRequestTypeSerializer();
}

class _$BodyRequestTypeSerializer implements PrimitiveSerializer<BodyRequestType> {
  @override
  final Iterable<Type> types = const [BodyRequestType, _$BodyRequestType];

  @override
  final String wireName = r'BodyRequestType';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    BodyRequestType object, {
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
    BodyRequestType object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required BodyRequestTypeBuilder result,
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
  BodyRequestType deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = BodyRequestTypeBuilder();
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

