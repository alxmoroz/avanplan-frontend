//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:openapi/src/model/user.dart';
import 'package:openapi/src/model/contract_get.dart';
import 'package:openapi/src/model/role_get.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'workspace_get.g.dart';

/// WorkspaceGet
///
/// Properties:
/// * [id] 
/// * [title] 
/// * [description] 
/// * [users] 
/// * [roles] 
/// * [contract] 
@BuiltValue()
abstract class WorkspaceGet implements Built<WorkspaceGet, WorkspaceGetBuilder> {
  @BuiltValueField(wireName: r'id')
  int get id;

  @BuiltValueField(wireName: r'title')
  String? get title;

  @BuiltValueField(wireName: r'description')
  String? get description;

  @BuiltValueField(wireName: r'users')
  BuiltList<User>? get users;

  @BuiltValueField(wireName: r'roles')
  BuiltList<RoleGet>? get roles;

  @BuiltValueField(wireName: r'contract')
  ContractGet? get contract;

  WorkspaceGet._();

  factory WorkspaceGet([void updates(WorkspaceGetBuilder b)]) = _$WorkspaceGet;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(WorkspaceGetBuilder b) => b
      ..users = ListBuilder()
      ..roles = ListBuilder();

  @BuiltValueSerializer(custom: true)
  static Serializer<WorkspaceGet> get serializer => _$WorkspaceGetSerializer();
}

class _$WorkspaceGetSerializer implements PrimitiveSerializer<WorkspaceGet> {
  @override
  final Iterable<Type> types = const [WorkspaceGet, _$WorkspaceGet];

  @override
  final String wireName = r'WorkspaceGet';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    WorkspaceGet object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'id';
    yield serializers.serialize(
      object.id,
      specifiedType: const FullType(int),
    );
    if (object.title != null) {
      yield r'title';
      yield serializers.serialize(
        object.title,
        specifiedType: const FullType(String),
      );
    }
    if (object.description != null) {
      yield r'description';
      yield serializers.serialize(
        object.description,
        specifiedType: const FullType(String),
      );
    }
    if (object.users != null) {
      yield r'users';
      yield serializers.serialize(
        object.users,
        specifiedType: const FullType(BuiltList, [FullType(User)]),
      );
    }
    if (object.roles != null) {
      yield r'roles';
      yield serializers.serialize(
        object.roles,
        specifiedType: const FullType(BuiltList, [FullType(RoleGet)]),
      );
    }
    if (object.contract != null) {
      yield r'contract';
      yield serializers.serialize(
        object.contract,
        specifiedType: const FullType(ContractGet),
      );
    }
  }

  @override
  Object serialize(
    Serializers serializers,
    WorkspaceGet object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required WorkspaceGetBuilder result,
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
        case r'title':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.title = valueDes;
          break;
        case r'description':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.description = valueDes;
          break;
        case r'users':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(BuiltList, [FullType(User)]),
          ) as BuiltList<User>;
          result.users.replace(valueDes);
          break;
        case r'roles':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(BuiltList, [FullType(RoleGet)]),
          ) as BuiltList<RoleGet>;
          result.roles.replace(valueDes);
          break;
        case r'contract':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(ContractGet),
          ) as ContractGet;
          result.contract.replace(valueDes);
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  WorkspaceGet deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = WorkspaceGetBuilder();
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

