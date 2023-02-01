//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'task_role_get.g.dart';

/// TaskRoleGet
///
/// Properties:
/// * [id] 
/// * [code] 
@BuiltValue()
abstract class TaskRoleGet implements Built<TaskRoleGet, TaskRoleGetBuilder> {
  @BuiltValueField(wireName: r'id')
  int get id;

  @BuiltValueField(wireName: r'code')
  String get code;

  TaskRoleGet._();

  factory TaskRoleGet([void updates(TaskRoleGetBuilder b)]) = _$TaskRoleGet;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(TaskRoleGetBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<TaskRoleGet> get serializer => _$TaskRoleGetSerializer();
}

class _$TaskRoleGetSerializer implements PrimitiveSerializer<TaskRoleGet> {
  @override
  final Iterable<Type> types = const [TaskRoleGet, _$TaskRoleGet];

  @override
  final String wireName = r'TaskRoleGet';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    TaskRoleGet object, {
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
  }

  @override
  Object serialize(
    Serializers serializers,
    TaskRoleGet object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required TaskRoleGetBuilder result,
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
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  TaskRoleGet deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = TaskRoleGetBuilder();
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

