//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'source_upsert.g.dart';

/// SourceUpsert
///
/// Properties:
/// * [id] 
/// * [workspaceId] 
/// * [url] 
/// * [apiKey] 
/// * [username] 
/// * [description] 
/// * [sourceTypeId] 
/// * [password] 
@BuiltValue()
abstract class SourceUpsert implements Built<SourceUpsert, SourceUpsertBuilder> {
  @BuiltValueField(wireName: r'id')
  int? get id;

  @BuiltValueField(wireName: r'workspace_id')
  int get workspaceId;

  @BuiltValueField(wireName: r'url')
  String get url;

  @BuiltValueField(wireName: r'api_key')
  String? get apiKey;

  @BuiltValueField(wireName: r'username')
  String? get username;

  @BuiltValueField(wireName: r'description')
  String? get description;

  @BuiltValueField(wireName: r'source_type_id')
  int get sourceTypeId;

  @BuiltValueField(wireName: r'password')
  String? get password;

  SourceUpsert._();

  factory SourceUpsert([void updates(SourceUpsertBuilder b)]) = _$SourceUpsert;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(SourceUpsertBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<SourceUpsert> get serializer => _$SourceUpsertSerializer();
}

class _$SourceUpsertSerializer implements PrimitiveSerializer<SourceUpsert> {
  @override
  final Iterable<Type> types = const [SourceUpsert, _$SourceUpsert];

  @override
  final String wireName = r'SourceUpsert';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    SourceUpsert object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    if (object.id != null) {
      yield r'id';
      yield serializers.serialize(
        object.id,
        specifiedType: const FullType(int),
      );
    }
    yield r'workspace_id';
    yield serializers.serialize(
      object.workspaceId,
      specifiedType: const FullType(int),
    );
    yield r'url';
    yield serializers.serialize(
      object.url,
      specifiedType: const FullType(String),
    );
    if (object.apiKey != null) {
      yield r'api_key';
      yield serializers.serialize(
        object.apiKey,
        specifiedType: const FullType(String),
      );
    }
    if (object.username != null) {
      yield r'username';
      yield serializers.serialize(
        object.username,
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
    yield r'source_type_id';
    yield serializers.serialize(
      object.sourceTypeId,
      specifiedType: const FullType(int),
    );
    if (object.password != null) {
      yield r'password';
      yield serializers.serialize(
        object.password,
        specifiedType: const FullType(String),
      );
    }
  }

  @override
  Object serialize(
    Serializers serializers,
    SourceUpsert object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required SourceUpsertBuilder result,
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
        case r'workspace_id':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.workspaceId = valueDes;
          break;
        case r'url':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.url = valueDes;
          break;
        case r'api_key':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.apiKey = valueDes;
          break;
        case r'username':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.username = valueDes;
          break;
        case r'description':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.description = valueDes;
          break;
        case r'source_type_id':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.sourceTypeId = valueDes;
          break;
        case r'password':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.password = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  SourceUpsert deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = SourceUpsertBuilder();
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

