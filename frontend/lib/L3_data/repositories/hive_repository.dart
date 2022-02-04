// Copyright (c) 2021. Alexandr Moroz

import 'package:hive/hive.dart';

import '../../../L1_domain/entities/base.dart';
import '../../../L1_domain/repositories/database_repository.dart';
import '../../../L3_data/models/base.dart';

typedef ModelCreator<T> = T Function();

class HiveRepo<E extends BaseEntity, M extends BaseModel> implements DBRepository<E, M> {
  HiveRepo(this.boxName, this.modelCreator);

  late Box<M> box;
  final String boxName;
  ModelCreator<M> modelCreator;

  Future open() async => box = await Hive.openBox<M>(boxName);

  void close() => box.close();

  Future<M> _getOrCreateModel(String? id) async {
    M model;
    try {
      if (!box.isOpen) {
        await open();
      }
      model = box.values.firstWhere((model) => model.id == id);
    } catch (e) {
      model = modelCreator();
      await box.add(model);
    }
    return model;
  }

  @override
  Future<Iterable<E>> getAll([dynamic params]) async {
    if (!box.isOpen) {
      await open();
    }
    return box.values.map((model) => model.toEntity(params));
  }

  @override
  Future<M> save(E entity, M? model) async {
    return await (model ?? await _getOrCreateModel(entity.id)).fromEntity(entity);
  }

  @override
  Future delete(E entity, M? model) async {
    try {
      await (model ?? await _getOrCreateModel(entity.id)).delete();
    } catch (e) {
      print('delete error ${entity.id} $e');
    }
  }

// @override
// Future<E> get(String id, [dynamic params]) async => (await _getOrCreateModel(id)).toEntity(params);
}
