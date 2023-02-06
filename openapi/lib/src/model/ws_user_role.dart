//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:openapi/src/model/w_role_get.dart';
import 'package:openapi/src/model/workspace_get.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'ws_user_role.g.dart';

/// WSUserRole
///
/// Properties:
/// * [id] 
/// * [workspace] 
/// * [role] 
/// * [userId] 
@BuiltValue()
abstract class WSUserRole implements Built<WSUserRole, WSUserRoleBuilder> {
  @BuiltValueField(wireName: r'id')
  int get id;

  @BuiltValueField(wireName: r'workspace')
  WorkspaceGet get workspace;

  @BuiltValueField(wireName: r'role')
  WRoleGet get role;

  @BuiltValueField(wireName: r'user_id')
  int get userId;

  WSUserRole._();

  factory WSUserRole([void updates(WSUserRoleBuilder b)]) = _$WSUserRole;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(WSUserRoleBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<WSUserRole> get serializer => _$WSUserRoleSerializer();
}

class _$WSUserRoleSerializer implements PrimitiveSerializer<WSUserRole> {
  @override
  final Iterable<Type> types = const [WSUserRole, _$WSUserRole];

  @override
  final String wireName = r'WSUserRole';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    WSUserRole object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'id';
    yield serializers.serialize(
      object.id,
      specifiedType: const FullType(int),
    );
    yield r'workspace';
    yield serializers.serialize(
      object.workspace,
      specifiedType: const FullType(WorkspaceGet),
    );
    yield r'role';
    yield serializers.serialize(
      object.role,
      specifiedType: const FullType(WRoleGet),
    );
    yield r'user_id';
    yield serializers.serialize(
      object.userId,
      specifiedType: const FullType(int),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    WSUserRole object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required WSUserRoleBuilder result,
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
        case r'workspace':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(WorkspaceGet),
          ) as WorkspaceGet;
          result.workspace.replace(valueDes);
          break;
        case r'role':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(WRoleGet),
          ) as WRoleGet;
          result.role.replace(valueDes);
          break;
        case r'user_id':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.userId = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  WSUserRole deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = WSUserRoleBuilder();
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

