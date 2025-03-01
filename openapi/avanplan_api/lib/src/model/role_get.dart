//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:avanplan_api/src/model/permission_role_get.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'role_get.g.dart';

/// RoleGet
///
/// Properties:
/// * [id] 
/// * [code] 
/// * [permissionRoles] 
@BuiltValue()
abstract class RoleGet implements Built<RoleGet, RoleGetBuilder> {
  @BuiltValueField(wireName: r'id')
  int get id;

  @BuiltValueField(wireName: r'code')
  String get code;

  @BuiltValueField(wireName: r'permission_roles')
  BuiltList<PermissionRoleGet> get permissionRoles;

  RoleGet._();

  factory RoleGet([void updates(RoleGetBuilder b)]) = _$RoleGet;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(RoleGetBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<RoleGet> get serializer => _$RoleGetSerializer();
}

class _$RoleGetSerializer implements PrimitiveSerializer<RoleGet> {
  @override
  final Iterable<Type> types = const [RoleGet, _$RoleGet];

  @override
  final String wireName = r'RoleGet';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    RoleGet object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'id';
    yield serializers.serialize(
      object.id,
      specifiedType: const FullType(int),
    );
    yield r'code';
    yield serializers.serialize(
      object.code,
      specifiedType: const FullType(String),
    );
    yield r'permission_roles';
    yield serializers.serialize(
      object.permissionRoles,
      specifiedType: const FullType(BuiltList, [FullType(PermissionRoleGet)]),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    RoleGet object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required RoleGetBuilder result,
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
        case r'code':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.code = valueDes;
          break;
        case r'permission_roles':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(BuiltList, [FullType(PermissionRoleGet)]),
          ) as BuiltList<PermissionRoleGet>;
          result.permissionRoles.replace(valueDes);
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  RoleGet deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = RoleGetBuilder();
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

