//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'body_deprecated_update_push_token_v1_my_push_token_post.g.dart';

/// BodyDeprecatedUpdatePushTokenV1MyPushTokenPost
///
/// Properties:
/// * [code] 
/// * [platform] 
/// * [hasPermission] 
@BuiltValue()
abstract class BodyDeprecatedUpdatePushTokenV1MyPushTokenPost implements Built<BodyDeprecatedUpdatePushTokenV1MyPushTokenPost, BodyDeprecatedUpdatePushTokenV1MyPushTokenPostBuilder> {
  @BuiltValueField(wireName: r'code')
  String get code;

  @BuiltValueField(wireName: r'platform')
  String get platform;

  @BuiltValueField(wireName: r'has_permission')
  bool get hasPermission;

  BodyDeprecatedUpdatePushTokenV1MyPushTokenPost._();

  factory BodyDeprecatedUpdatePushTokenV1MyPushTokenPost([void updates(BodyDeprecatedUpdatePushTokenV1MyPushTokenPostBuilder b)]) = _$BodyDeprecatedUpdatePushTokenV1MyPushTokenPost;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(BodyDeprecatedUpdatePushTokenV1MyPushTokenPostBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<BodyDeprecatedUpdatePushTokenV1MyPushTokenPost> get serializer => _$BodyDeprecatedUpdatePushTokenV1MyPushTokenPostSerializer();
}

class _$BodyDeprecatedUpdatePushTokenV1MyPushTokenPostSerializer implements PrimitiveSerializer<BodyDeprecatedUpdatePushTokenV1MyPushTokenPost> {
  @override
  final Iterable<Type> types = const [BodyDeprecatedUpdatePushTokenV1MyPushTokenPost, _$BodyDeprecatedUpdatePushTokenV1MyPushTokenPost];

  @override
  final String wireName = r'BodyDeprecatedUpdatePushTokenV1MyPushTokenPost';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    BodyDeprecatedUpdatePushTokenV1MyPushTokenPost object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'code';
    yield serializers.serialize(
      object.code,
      specifiedType: const FullType(String),
    );
    yield r'platform';
    yield serializers.serialize(
      object.platform,
      specifiedType: const FullType(String),
    );
    yield r'has_permission';
    yield serializers.serialize(
      object.hasPermission,
      specifiedType: const FullType(bool),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    BodyDeprecatedUpdatePushTokenV1MyPushTokenPost object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required BodyDeprecatedUpdatePushTokenV1MyPushTokenPostBuilder result,
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
        case r'platform':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.platform = valueDes;
          break;
        case r'has_permission':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(bool),
          ) as bool;
          result.hasPermission = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  BodyDeprecatedUpdatePushTokenV1MyPushTokenPost deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = BodyDeprecatedUpdatePushTokenV1MyPushTokenPostBuilder();
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

