//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'project_feature_set_get.g.dart';

/// ProjectFeatureSetGet
///
/// Properties:
/// * [id] 
/// * [featureSetId] 
@BuiltValue()
abstract class ProjectFeatureSetGet implements Built<ProjectFeatureSetGet, ProjectFeatureSetGetBuilder> {
  @BuiltValueField(wireName: r'id')
  int get id;

  @BuiltValueField(wireName: r'feature_set_id')
  int get featureSetId;

  ProjectFeatureSetGet._();

  factory ProjectFeatureSetGet([void updates(ProjectFeatureSetGetBuilder b)]) = _$ProjectFeatureSetGet;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(ProjectFeatureSetGetBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<ProjectFeatureSetGet> get serializer => _$ProjectFeatureSetGetSerializer();
}

class _$ProjectFeatureSetGetSerializer implements PrimitiveSerializer<ProjectFeatureSetGet> {
  @override
  final Iterable<Type> types = const [ProjectFeatureSetGet, _$ProjectFeatureSetGet];

  @override
  final String wireName = r'ProjectFeatureSetGet';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    ProjectFeatureSetGet object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'id';
    yield serializers.serialize(
      object.id,
      specifiedType: const FullType(int),
    );
    yield r'feature_set_id';
    yield serializers.serialize(
      object.featureSetId,
      specifiedType: const FullType(int),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    ProjectFeatureSetGet object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required ProjectFeatureSetGetBuilder result,
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
        case r'feature_set_id':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.featureSetId = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  ProjectFeatureSetGet deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = ProjectFeatureSetGetBuilder();
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

