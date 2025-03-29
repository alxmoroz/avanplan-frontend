//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:avanplan_api/src/model/registration.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'body_request_registration.g.dart';

/// BodyRequestRegistration
///
/// Properties:
/// * [registration]
/// * [password]
@BuiltValue()
abstract class BodyRequestRegistration implements Built<BodyRequestRegistration, BodyRequestRegistrationBuilder> {
  @BuiltValueField(wireName: r'registration')
  Registration get registration;

  @BuiltValueField(wireName: r'password')
  String get password;

  BodyRequestRegistration._();

  factory BodyRequestRegistration([void updates(BodyRequestRegistrationBuilder b)]) = _$BodyRequestRegistration;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(BodyRequestRegistrationBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<BodyRequestRegistration> get serializer => _$BodyRequestRegistrationSerializer();
}

class _$BodyRequestRegistrationSerializer implements PrimitiveSerializer<BodyRequestRegistration> {
  @override
  final Iterable<Type> types = const [BodyRequestRegistration, _$BodyRequestRegistration];

  @override
  final String wireName = r'BodyRequestRegistration';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    BodyRequestRegistration object, {
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
    BodyRequestRegistration object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required BodyRequestRegistrationBuilder result,
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
  BodyRequestRegistration deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = BodyRequestRegistrationBuilder();
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
