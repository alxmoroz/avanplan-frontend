//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

import 'package:openapi/src/model/source_type_get.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'source_get.g.dart';

/// SourceGet
///
/// Properties:
/// * [id] 
/// * [workspaceId] 
/// * [url] 
/// * [apiKey] 
/// * [login] 
/// * [description] 
/// * [type] 
abstract class SourceGet implements Built<SourceGet, SourceGetBuilder> {
    @BuiltValueField(wireName: r'id')
    int get id;

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

    @BuiltValueField(wireName: r'type')
    SourceTypeGet get type;

    SourceGet._();

    @BuiltValueHook(initializeBuilder: true)
    static void _defaults(SourceGetBuilder b) => b;

    factory SourceGet([void updates(SourceGetBuilder b)]) = _$SourceGet;

    @BuiltValueSerializer(custom: true)
    static Serializer<SourceGet> get serializer => _$SourceGetSerializer();
}

class _$SourceGetSerializer implements StructuredSerializer<SourceGet> {
    @override
    final Iterable<Type> types = const [SourceGet, _$SourceGet];

    @override
    final String wireName = r'SourceGet';

    @override
    Iterable<Object?> serialize(Serializers serializers, SourceGet object,
        {FullType specifiedType = FullType.unspecified}) {
        final result = <Object?>[];
        result
            ..add(r'id')
            ..add(serializers.serialize(object.id,
                specifiedType: const FullType(int)));
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
            ..add(r'type')
            ..add(serializers.serialize(object.type,
                specifiedType: const FullType(SourceTypeGet)));
        return result;
    }

    @override
    SourceGet deserialize(Serializers serializers, Iterable<Object?> serialized,
        {FullType specifiedType = FullType.unspecified}) {
        final result = SourceGetBuilder();

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
                case r'type':
                    final valueDes = serializers.deserialize(value,
                        specifiedType: const FullType(SourceTypeGet)) as SourceTypeGet;
                    result.type.replace(valueDes);
                    break;
            }
        }
        return result.build();
    }
}

