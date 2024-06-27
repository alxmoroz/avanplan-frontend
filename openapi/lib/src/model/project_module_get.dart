//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'project_module_get.g.dart';

/// ProjectModuleGet
///
/// Properties:
/// * [id] 
/// * [tariffOptionCode] 
@BuiltValue()
abstract class ProjectModuleGet implements Built<ProjectModuleGet, ProjectModuleGetBuilder> {
  @BuiltValueField(wireName: r'id')
  int get id;

  @BuiltValueField(wireName: r'tariff_option_code')
  String get tariffOptionCode;

  ProjectModuleGet._();

  factory ProjectModuleGet([void updates(ProjectModuleGetBuilder b)]) = _$ProjectModuleGet;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(ProjectModuleGetBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<ProjectModuleGet> get serializer => _$ProjectModuleGetSerializer();
}

class _$ProjectModuleGetSerializer implements PrimitiveSerializer<ProjectModuleGet> {
  @override
  final Iterable<Type> types = const [ProjectModuleGet, _$ProjectModuleGet];

  @override
  final String wireName = r'ProjectModuleGet';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    ProjectModuleGet object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'id';
    yield serializers.serialize(
      object.id,
      specifiedType: const FullType(int),
    );
    yield r'tariff_option_code';
    yield serializers.serialize(
      object.tariffOptionCode,
      specifiedType: const FullType(String),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    ProjectModuleGet object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required ProjectModuleGetBuilder result,
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
        case r'tariff_option_code':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.tariffOptionCode = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  ProjectModuleGet deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = ProjectModuleGetBuilder();
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

