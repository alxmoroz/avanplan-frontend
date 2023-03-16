//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'app_settings_get.g.dart';

/// AppSettingsGet
///
/// Properties:
/// * [id] 
/// * [frontendFlags] 
/// * [wsOwnerRoleId] 
@BuiltValue()
abstract class AppSettingsGet implements Built<AppSettingsGet, AppSettingsGetBuilder> {
  @BuiltValueField(wireName: r'id')
  int get id;

  @BuiltValueField(wireName: r'frontend_flags')
  String get frontendFlags;

  @BuiltValueField(wireName: r'ws_owner_role_id')
  int? get wsOwnerRoleId;

  AppSettingsGet._();

  factory AppSettingsGet([void updates(AppSettingsGetBuilder b)]) = _$AppSettingsGet;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(AppSettingsGetBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<AppSettingsGet> get serializer => _$AppSettingsGetSerializer();
}

class _$AppSettingsGetSerializer implements PrimitiveSerializer<AppSettingsGet> {
  @override
  final Iterable<Type> types = const [AppSettingsGet, _$AppSettingsGet];

  @override
  final String wireName = r'AppSettingsGet';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    AppSettingsGet object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'id';
    yield serializers.serialize(
      object.id,
      specifiedType: const FullType(int),
    );
    yield r'frontend_flags';
    yield serializers.serialize(
      object.frontendFlags,
      specifiedType: const FullType(String),
    );
    if (object.wsOwnerRoleId != null) {
      yield r'ws_owner_role_id';
      yield serializers.serialize(
        object.wsOwnerRoleId,
        specifiedType: const FullType(int),
      );
    }
  }

  @override
  Object serialize(
    Serializers serializers,
    AppSettingsGet object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required AppSettingsGetBuilder result,
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
        case r'frontend_flags':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.frontendFlags = valueDes;
          break;
        case r'ws_owner_role_id':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.wsOwnerRoleId = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  AppSettingsGet deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = AppSettingsGetBuilder();
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

