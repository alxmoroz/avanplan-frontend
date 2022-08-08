//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'person.g.dart';

/// Person
///
/// Properties:
/// * [email] 
/// * [firstname] 
/// * [lastname] 
abstract class Person implements Built<Person, PersonBuilder> {
    @BuiltValueField(wireName: r'email')
    String get email;

    @BuiltValueField(wireName: r'firstname')
    String? get firstname;

    @BuiltValueField(wireName: r'lastname')
    String? get lastname;

    Person._();

    @BuiltValueHook(initializeBuilder: true)
    static void _defaults(PersonBuilder b) => b;

    factory Person([void updates(PersonBuilder b)]) = _$Person;

    @BuiltValueSerializer(custom: true)
    static Serializer<Person> get serializer => _$PersonSerializer();
}

class _$PersonSerializer implements StructuredSerializer<Person> {
    @override
    final Iterable<Type> types = const [Person, _$Person];

    @override
    final String wireName = r'Person';

    @override
    Iterable<Object?> serialize(Serializers serializers, Person object,
        {FullType specifiedType = FullType.unspecified}) {
        final result = <Object?>[];
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
    Person deserialize(Serializers serializers, Iterable<Object?> serialized,
        {FullType specifiedType = FullType.unspecified}) {
        final result = PersonBuilder();

        final iterator = serialized.iterator;
        while (iterator.moveNext()) {
            final key = iterator.current as String;
            iterator.moveNext();
            final Object? value = iterator.current;
            
            switch (key) {
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

