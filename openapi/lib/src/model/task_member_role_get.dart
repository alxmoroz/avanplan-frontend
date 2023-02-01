//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:openapi/src/model/member_get.dart';
import 'package:openapi/src/model/task_role_get.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'task_member_role_get.g.dart';

/// TaskMemberRoleGet
///
/// Properties:
/// * [id] 
/// * [member] 
/// * [role] 
@BuiltValue()
abstract class TaskMemberRoleGet implements Built<TaskMemberRoleGet, TaskMemberRoleGetBuilder> {
  @BuiltValueField(wireName: r'id')
  int get id;

  @BuiltValueField(wireName: r'member')
  MemberGet get member;

  @BuiltValueField(wireName: r'role')
  TaskRoleGet get role;

  TaskMemberRoleGet._();

  factory TaskMemberRoleGet([void updates(TaskMemberRoleGetBuilder b)]) = _$TaskMemberRoleGet;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(TaskMemberRoleGetBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<TaskMemberRoleGet> get serializer => _$TaskMemberRoleGetSerializer();
}

class _$TaskMemberRoleGetSerializer implements PrimitiveSerializer<TaskMemberRoleGet> {
  @override
  final Iterable<Type> types = const [TaskMemberRoleGet, _$TaskMemberRoleGet];

  @override
  final String wireName = r'TaskMemberRoleGet';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    TaskMemberRoleGet object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'id';
    yield serializers.serialize(
      object.id,
      specifiedType: const FullType(int),
    );
    yield r'member';
    yield serializers.serialize(
      object.member,
      specifiedType: const FullType(MemberGet),
    );
    yield r'role';
    yield serializers.serialize(
      object.role,
      specifiedType: const FullType(TaskRoleGet),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    TaskMemberRoleGet object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required TaskMemberRoleGetBuilder result,
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
        case r'member':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(MemberGet),
          ) as MemberGet;
          result.member.replace(valueDes);
          break;
        case r'role':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(TaskRoleGet),
          ) as TaskRoleGet;
          result.role.replace(valueDes);
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  TaskMemberRoleGet deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = TaskMemberRoleGetBuilder();
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

