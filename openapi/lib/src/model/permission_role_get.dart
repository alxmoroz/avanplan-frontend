//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:openapi/src/model/permission_get.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'permission_role_get.g.dart';

/// PermissionRoleGet
///
/// Properties:
/// * [id] 
/// * [permission] 
@BuiltValue()
abstract class PermissionRoleGet implements Built<PermissionRoleGet, PermissionRoleGetBuilder> {
  @BuiltValueField(wireName: r'id')
  int get id;

  @BuiltValueField(wireName: r'permission')
  PermissionGet get permission;

  PermissionRoleGet._();

  factory PermissionRoleGet([void updates(PermissionRoleGetBuilder b)]) = _$PermissionRoleGet;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(PermissionRoleGetBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<PermissionRoleGet> get serializer => _$PermissionRoleGetSerializer();
}

class _$PermissionRoleGetSerializer implements PrimitiveSerializer<PermissionRoleGet> {
  @override
  final Iterable<Type> types = const [PermissionRoleGet, _$PermissionRoleGet];

  @override
  final String wireName = r'PermissionRoleGet';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    PermissionRoleGet object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'id';
    yield serializers.serialize(
      object.id,
      specifiedType: const FullType(int),
    );
    yield r'permission';
    yield serializers.serialize(
      object.permission,
      specifiedType: const FullType(PermissionGet),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    PermissionRoleGet object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required PermissionRoleGetBuilder result,
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
        case r'permission':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(PermissionGet),
          ) as PermissionGet;
          result.permission.replace(valueDes);
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  PermissionRoleGet deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = PermissionRoleGetBuilder();
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

