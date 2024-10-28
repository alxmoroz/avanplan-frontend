//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'task_relation_upsert.g.dart';

/// TaskRelationUpsert
///
/// Properties:
/// * [id] 
/// * [srcId] 
/// * [dstId] 
/// * [type] 
@BuiltValue()
abstract class TaskRelationUpsert implements Built<TaskRelationUpsert, TaskRelationUpsertBuilder> {
  @BuiltValueField(wireName: r'id')
  int? get id;

  @BuiltValueField(wireName: r'src_id')
  int get srcId;

  @BuiltValueField(wireName: r'dst_id')
  int get dstId;

  @BuiltValueField(wireName: r'type')
  String get type;

  TaskRelationUpsert._();

  factory TaskRelationUpsert([void updates(TaskRelationUpsertBuilder b)]) = _$TaskRelationUpsert;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(TaskRelationUpsertBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<TaskRelationUpsert> get serializer => _$TaskRelationUpsertSerializer();
}

class _$TaskRelationUpsertSerializer implements PrimitiveSerializer<TaskRelationUpsert> {
  @override
  final Iterable<Type> types = const [TaskRelationUpsert, _$TaskRelationUpsert];

  @override
  final String wireName = r'TaskRelationUpsert';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    TaskRelationUpsert object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    if (object.id != null) {
      yield r'id';
      yield serializers.serialize(
        object.id,
        specifiedType: const FullType(int),
      );
    }
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
    TaskRelationUpsert object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required TaskRelationUpsertBuilder result,
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
  TaskRelationUpsert deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = TaskRelationUpsertBuilder();
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

