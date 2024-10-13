//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'task_relation_get.g.dart';

/// TaskRelationGet
///
/// Properties:
/// * [id] 
/// * [srcId] 
/// * [dstId] 
/// * [type] 
@BuiltValue()
abstract class TaskRelationGet implements Built<TaskRelationGet, TaskRelationGetBuilder> {
  @BuiltValueField(wireName: r'id')
  int get id;

  @BuiltValueField(wireName: r'src_id')
  int get srcId;

  @BuiltValueField(wireName: r'dst_id')
  int get dstId;

  @BuiltValueField(wireName: r'type')
  String get type;

  TaskRelationGet._();

  factory TaskRelationGet([void updates(TaskRelationGetBuilder b)]) = _$TaskRelationGet;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(TaskRelationGetBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<TaskRelationGet> get serializer => _$TaskRelationGetSerializer();
}

class _$TaskRelationGetSerializer implements PrimitiveSerializer<TaskRelationGet> {
  @override
  final Iterable<Type> types = const [TaskRelationGet, _$TaskRelationGet];

  @override
  final String wireName = r'TaskRelationGet';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    TaskRelationGet object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'id';
    yield serializers.serialize(
      object.id,
      specifiedType: const FullType(int),
    );
    yield r'src_id';
    yield serializers.serialize(
      object.srcId,
      specifiedType: const FullType(int),
    );
    yield r'dst_id';
    yield serializers.serialize(
      object.dstId,
      specifiedType: const FullType(int),
    );
    yield r'type';
    yield serializers.serialize(
      object.type,
      specifiedType: const FullType(String),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    TaskRelationGet object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required TaskRelationGetBuilder result,
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
        case r'src_id':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.srcId = valueDes;
          break;
        case r'dst_id':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.dstId = valueDes;
          break;
        case r'type':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.type = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  TaskRelationGet deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = TaskRelationGetBuilder();
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

