//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'project_status_get.g.dart';

/// ProjectStatusGet
///
/// Properties:
/// * [id] 
/// * [position] 
/// * [statusId] 
@BuiltValue()
abstract class ProjectStatusGet implements Built<ProjectStatusGet, ProjectStatusGetBuilder> {
  @BuiltValueField(wireName: r'id')
  int get id;

  @BuiltValueField(wireName: r'position')
  int get position;

  @BuiltValueField(wireName: r'status_id')
  int get statusId;

  ProjectStatusGet._();

  factory ProjectStatusGet([void updates(ProjectStatusGetBuilder b)]) = _$ProjectStatusGet;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(ProjectStatusGetBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<ProjectStatusGet> get serializer => _$ProjectStatusGetSerializer();
}

class _$ProjectStatusGetSerializer implements PrimitiveSerializer<ProjectStatusGet> {
  @override
  final Iterable<Type> types = const [ProjectStatusGet, _$ProjectStatusGet];

  @override
  final String wireName = r'ProjectStatusGet';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    ProjectStatusGet object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'id';
    yield serializers.serialize(
      object.id,
      specifiedType: const FullType(int),
    );
    yield r'position';
    yield serializers.serialize(
      object.position,
      specifiedType: const FullType(int),
    );
    yield r'status_id';
    yield serializers.serialize(
      object.statusId,
      specifiedType: const FullType(int),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    ProjectStatusGet object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required ProjectStatusGetBuilder result,
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
        case r'position':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.position = valueDes;
          break;
        case r'status_id':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.statusId = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  ProjectStatusGet deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = ProjectStatusGetBuilder();
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

