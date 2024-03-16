// Copyright (c) 2024. Alexandr Moroz

//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'body_my_calendar_update_google_accounts.g.dart';

/// BodyMyCalendarUpdateGoogleAccounts
///
/// Properties:
/// * [email] 
/// * [accessToken] 
@BuiltValue()
abstract class BodyMyCalendarUpdateGoogleAccounts implements Built<BodyMyCalendarUpdateGoogleAccounts, BodyMyCalendarUpdateGoogleAccountsBuilder> {
  @BuiltValueField(wireName: r'email')
  String get email;

  @BuiltValueField(wireName: r'access_token')
  String get accessToken;

  BodyMyCalendarUpdateGoogleAccounts._();

  factory BodyMyCalendarUpdateGoogleAccounts([void updates(BodyMyCalendarUpdateGoogleAccountsBuilder b)]) = _$BodyMyCalendarUpdateGoogleAccounts;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(BodyMyCalendarUpdateGoogleAccountsBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<BodyMyCalendarUpdateGoogleAccounts> get serializer => _$BodyMyCalendarUpdateGoogleAccountsSerializer();
}

class _$BodyMyCalendarUpdateGoogleAccountsSerializer implements PrimitiveSerializer<BodyMyCalendarUpdateGoogleAccounts> {
  @override
  final Iterable<Type> types = const [BodyMyCalendarUpdateGoogleAccounts, _$BodyMyCalendarUpdateGoogleAccounts];

  @override
  final String wireName = r'BodyMyCalendarUpdateGoogleAccounts';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    BodyMyCalendarUpdateGoogleAccounts object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'email';
    yield serializers.serialize(
      object.email,
      specifiedType: const FullType(String),
    );
    yield r'access_token';
    yield serializers.serialize(
      object.accessToken,
      specifiedType: const FullType(String),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    BodyMyCalendarUpdateGoogleAccounts object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required BodyMyCalendarUpdateGoogleAccountsBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'email':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.email = valueDes;
          break;
        case r'access_token':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.accessToken = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  BodyMyCalendarUpdateGoogleAccounts deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = BodyMyCalendarUpdateGoogleAccountsBuilder();
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

