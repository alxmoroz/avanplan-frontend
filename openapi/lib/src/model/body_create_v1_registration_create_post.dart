//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:openapi/src/model/registration.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'body_create_v1_registration_create_post.g.dart';

/// BodyCreateV1RegistrationCreatePost
///
/// Properties:
/// * [registration] 
/// * [password] 
@BuiltValue()
abstract class BodyCreateV1RegistrationCreatePost implements Built<BodyCreateV1RegistrationCreatePost, BodyCreateV1RegistrationCreatePostBuilder> {
  @BuiltValueField(wireName: r'registration')
  Registration get registration;

  @BuiltValueField(wireName: r'password')
  String get password;

  BodyCreateV1RegistrationCreatePost._();

  factory BodyCreateV1RegistrationCreatePost([void updates(BodyCreateV1RegistrationCreatePostBuilder b)]) = _$BodyCreateV1RegistrationCreatePost;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(BodyCreateV1RegistrationCreatePostBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<BodyCreateV1RegistrationCreatePost> get serializer => _$BodyCreateV1RegistrationCreatePostSerializer();
}

class _$BodyCreateV1RegistrationCreatePostSerializer implements PrimitiveSerializer<BodyCreateV1RegistrationCreatePost> {
  @override
  final Iterable<Type> types = const [BodyCreateV1RegistrationCreatePost, _$BodyCreateV1RegistrationCreatePost];

  @override
  final String wireName = r'BodyCreateV1RegistrationCreatePost';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    BodyCreateV1RegistrationCreatePost object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'registration';
    yield serializers.serialize(
      object.registration,
      specifiedType: const FullType(Registration),
    );
    yield r'password';
    yield serializers.serialize(
      object.password,
      specifiedType: const FullType(String),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    BodyCreateV1RegistrationCreatePost object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required BodyCreateV1RegistrationCreatePostBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'registration':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(Registration),
          ) as Registration;
          result.registration.replace(valueDes);
          break;
        case r'password':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.password = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  BodyCreateV1RegistrationCreatePost deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = BodyCreateV1RegistrationCreatePostBuilder();
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

