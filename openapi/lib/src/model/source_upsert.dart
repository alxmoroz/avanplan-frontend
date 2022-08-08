//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

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
/// * [login] 
/// * [description] 
/// * [sourceTypeId] 
/// * [password] 
abstract class SourceUpsert implements Built<SourceUpsert, SourceUpsertBuilder> {
    @BuiltValueField(wireName: r'id')
    int? get id;

    @BuiltValueField(wireName: r'workspace_id')
    int get workspaceId;

    @BuiltValueField(wireName: r'url')
    String get url;

    @BuiltValueField(wireName: r'api_key')
    String? get apiKey;

    @BuiltValueField(wireName: r'login')
    String? get login;

    @BuiltValueField(wireName: r'description')
    String? get description;

    @BuiltValueField(wireName: r'source_type_id')
    int get sourceTypeId;

    @BuiltValueField(wireName: r'password')
    String? get password;

    SourceUpsert._();

    @BuiltValueHook(initializeBuilder: true)
    static void _defaults(SourceUpsertBuilder b) => b;

    factory SourceUpsert([void updates(SourceUpsertBuilder b)]) = _$SourceUpsert;

    @BuiltValueSerializer(custom: true)
    static Serializer<SourceUpsert> get serializer => _$SourceUpsertSerializer();
}

class _$SourceUpsertSerializer implements StructuredSerializer<SourceUpsert> {
    @override
    final Iterable<Type> types = const [SourceUpsert, _$SourceUpsert];

    @override
    final String wireName = r'SourceUpsert';

    @override
    Iterable<Object?> serialize(Serializers serializers, SourceUpsert object,
        {FullType specifiedType = FullType.unspecified}) {
        final result = <Object?>[];
        if (object.id != null) {
            result
                ..add(r'id')
                ..add(serializers.serialize(object.id,
                    specifiedType: const FullType(int)));
        }
        result
            ..add(r'workspace_id')
            ..add(serializers.serialize(object.workspaceId,
                specifiedType: const FullType(int)));
        result
            ..add(r'url')
            ..add(serializers.serialize(object.url,
                specifiedType: const FullType(String)));
        if (object.apiKey != null) {
            result
                ..add(r'api_key')
                ..add(serializers.serialize(object.apiKey,
                    specifiedType: const FullType(String)));
        }
        if (object.login != null) {
            result
                ..add(r'login')
                ..add(serializers.serialize(object.login,
                    specifiedType: const FullType(String)));
        }
        if (object.description != null) {
            result
                ..add(r'description')
                ..add(serializers.serialize(object.description,
                    specifiedType: const FullType(String)));
        }
        result
            ..add(r'source_type_id')
            ..add(serializers.serialize(object.sourceTypeId,
                specifiedType: const FullType(int)));
        if (object.password != null) {
            result
                ..add(r'password')
                ..add(serializers.serialize(object.password,
                    specifiedType: const FullType(String)));
        }
        return result;
    }

    @override
    SourceUpsert deserialize(Serializers serializers, Iterable<Object?> serialized,
        {FullType specifiedType = FullType.unspecified}) {
        final result = SourceUpsertBuilder();

        final iterator = serialized.iterator;
        while (iterator.moveNext()) {
            final key = iterator.current as String;
            iterator.moveNext();
            final Object? value = iterator.current;
            
            switch (key) {
                case r'id':
                    final valueDes = serializers.deserialize(value,
                        specifiedType: const FullType(int)) as int;
                    result.id = valueDes;
                    break;
                case r'workspace_id':
                    final valueDes = serializers.deserialize(value,
                        specifiedType: const FullType(int)) as int;
                    result.workspaceId = valueDes;
                    break;
                case r'url':
                    final valueDes = serializers.deserialize(value,
                        specifiedType: const FullType(String)) as String;
                    result.url = valueDes;
                    break;
                case r'api_key':
                    final valueDes = serializers.deserialize(value,
                        specifiedType: const FullType(String)) as String;
                    result.apiKey = valueDes;
                    break;
                case r'login':
                    final valueDes = serializers.deserialize(value,
                        specifiedType: const FullType(String)) as String;
                    result.login = valueDes;
                    break;
                case r'description':
                    final valueDes = serializers.deserialize(value,
                        specifiedType: const FullType(String)) as String;
                    result.description = valueDes;
                    break;
                case r'source_type_id':
                    final valueDes = serializers.deserialize(value,
                        specifiedType: const FullType(int)) as int;
                    result.sourceTypeId = valueDes;
                    break;
                case r'password':
                    final valueDes = serializers.deserialize(value,
                        specifiedType: const FullType(String)) as String;
                    result.password = valueDes;
                    break;
            }
        }
        return result.build();
    }
}

