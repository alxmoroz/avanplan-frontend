//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'person_get.g.dart';

/// PersonGet
///
/// Properties:
/// * [id] 
/// * [workspaceId] 
/// * [email] 
/// * [firstname] 
/// * [lastname] 
abstract class PersonGet implements Built<PersonGet, PersonGetBuilder> {
    @BuiltValueField(wireName: r'id')
    int get id;

    @BuiltValueField(wireName: r'workspace_id')
    int get workspaceId;

    @BuiltValueField(wireName: r'email')
    String get email;

    @BuiltValueField(wireName: r'firstname')
    String? get firstname;

    @BuiltValueField(wireName: r'lastname')
    String? get lastname;

    PersonGet._();

    @BuiltValueHook(initializeBuilder: true)
    static void _defaults(PersonGetBuilder b) => b;

    factory PersonGet([void updates(PersonGetBuilder b)]) = _$PersonGet;

    @BuiltValueSerializer(custom: true)
    static Serializer<PersonGet> get serializer => _$PersonGetSerializer();
}

class _$PersonGetSerializer implements StructuredSerializer<PersonGet> {
    @override
    final Iterable<Type> types = const [PersonGet, _$PersonGet];

    @override
    final String wireName = r'PersonGet';

    @override
    Iterable<Object?> serialize(Serializers serializers, PersonGet object,
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
            ..add(r'email')
            ..add(serializers.serialize(object.email,
                specifiedType: const FullType(String)));
        if (object.firstname != null) {
            result
                ..add(r'firstname')
                ..add(serializers.serialize(object.firstname,
                    specifiedType: const FullType(String)));
        }
        if (object.lastname != null) {
            result
                ..add(r'lastname')
                ..add(serializers.serialize(object.lastname,
                    specifiedType: const FullType(String)));
        }
        return result;
    }

    @override
    PersonGet deserialize(Serializers serializers, Iterable<Object?> serialized,
        {FullType specifiedType = FullType.unspecified}) {
        final result = PersonGetBuilder();

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
                case r'email':
                    final valueDes = serializers.deserialize(value,
                        specifiedType: const FullType(String)) as String;
                    result.email = valueDes;
                    break;
                case r'firstname':
                    final valueDes = serializers.deserialize(value,
                        specifiedType: const FullType(String)) as String;
                    result.firstname = valueDes;
                    break;
                case r'lastname':
                    final valueDes = serializers.deserialize(value,
                        specifiedType: const FullType(String)) as String;
                    result.lastname = valueDes;
                    break;
            }
        }
        return result.build();
    }
}

