//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:openapi/src/model/ws_tariff_get.dart';
import 'package:built_collection/built_collection.dart';
import 'package:openapi/src/model/user.dart';
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
/// * [tariffs] 
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

  @BuiltValueField(wireName: r'tariffs')
  BuiltList<WSTariffGet> get tariffs;

  WorkspaceGet._();

  factory WorkspaceGet([void updates(WorkspaceGetBuilder b)]) = _$WorkspaceGet;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(WorkspaceGetBuilder b) => b
      ..users = ListBuilder();

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
    yield r'tariffs';
    yield serializers.serialize(
      object.tariffs,
      specifiedType: const FullType(BuiltList, [FullType(WSTariffGet)]),
    );
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
        case r'tariffs':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(BuiltList, [FullType(WSTariffGet)]),
          ) as BuiltList<WSTariffGet>;
          result.tariffs.replace(valueDes);
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

