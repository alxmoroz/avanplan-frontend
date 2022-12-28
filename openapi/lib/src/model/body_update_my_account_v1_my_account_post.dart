//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'body_update_my_account_v1_my_account_post.g.dart';

/// BodyUpdateMyAccountV1MyAccountPost
///
/// Properties:
/// * [password] 
/// * [fullName] 
@BuiltValue()
abstract class BodyUpdateMyAccountV1MyAccountPost implements Built<BodyUpdateMyAccountV1MyAccountPost, BodyUpdateMyAccountV1MyAccountPostBuilder> {
  @BuiltValueField(wireName: r'password')
  String? get password;

  @BuiltValueField(wireName: r'full_name')
  String? get fullName;

  BodyUpdateMyAccountV1MyAccountPost._();

  factory BodyUpdateMyAccountV1MyAccountPost([void updates(BodyUpdateMyAccountV1MyAccountPostBuilder b)]) = _$BodyUpdateMyAccountV1MyAccountPost;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(BodyUpdateMyAccountV1MyAccountPostBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<BodyUpdateMyAccountV1MyAccountPost> get serializer => _$BodyUpdateMyAccountV1MyAccountPostSerializer();
}

class _$BodyUpdateMyAccountV1MyAccountPostSerializer implements PrimitiveSerializer<BodyUpdateMyAccountV1MyAccountPost> {
  @override
  final Iterable<Type> types = const [BodyUpdateMyAccountV1MyAccountPost, _$BodyUpdateMyAccountV1MyAccountPost];

  @override
  final String wireName = r'BodyUpdateMyAccountV1MyAccountPost';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    BodyUpdateMyAccountV1MyAccountPost object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    if (object.password != null) {
      yield r'password';
      yield serializers.serialize(
        object.password,
        specifiedType: const FullType(String),
      );
    }
    if (object.fullName != null) {
      yield r'full_name';
      yield serializers.serialize(
        object.fullName,
        specifiedType: const FullType(String),
      );
    }
  }

  @override
  Object serialize(
    Serializers serializers,
    BodyUpdateMyAccountV1MyAccountPost object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required BodyUpdateMyAccountV1MyAccountPostBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'password':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.password = valueDes;
          break;
        case r'full_name':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.fullName = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  BodyUpdateMyAccountV1MyAccountPost deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = BodyUpdateMyAccountV1MyAccountPostBuilder();
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

