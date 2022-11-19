//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:openapi/src/model/workspace_get.dart';
import 'package:openapi/src/model/ws_role_get.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'ws_user_role_get.g.dart';

/// WSUserRoleGet
///
/// Properties:
/// * [id] 
/// * [workspace] 
/// * [wsRole] 
/// * [userId] 
@BuiltValue()
abstract class WSUserRoleGet implements Built<WSUserRoleGet, WSUserRoleGetBuilder> {
  @BuiltValueField(wireName: r'id')
  int get id;

  @BuiltValueField(wireName: r'workspace')
  WorkspaceGet get workspace;

  @BuiltValueField(wireName: r'ws_role')
  WSRoleGet get wsRole;

  @BuiltValueField(wireName: r'user_id')
  int get userId;

  WSUserRoleGet._();

  factory WSUserRoleGet([void updates(WSUserRoleGetBuilder b)]) = _$WSUserRoleGet;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(WSUserRoleGetBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<WSUserRoleGet> get serializer => _$WSUserRoleGetSerializer();
}

class _$WSUserRoleGetSerializer implements PrimitiveSerializer<WSUserRoleGet> {
  @override
  final Iterable<Type> types = const [WSUserRoleGet, _$WSUserRoleGet];

  @override
  final String wireName = r'WSUserRoleGet';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    WSUserRoleGet object, {
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
    yield r'ws_role';
    yield serializers.serialize(
      object.wsRole,
      specifiedType: const FullType(WSRoleGet),
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
    WSUserRoleGet object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required WSUserRoleGetBuilder result,
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
        case r'ws_role':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(WSRoleGet),
          ) as WSRoleGet;
          result.wsRole.replace(valueDes);
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
  WSUserRoleGet deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = WSUserRoleGetBuilder();
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

