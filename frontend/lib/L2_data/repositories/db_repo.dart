// Copyright (c) 2022. Alexandr Moroz

import 'package:hive/hive.dart';

import '../../../L1_domain/entities/base.dart';
import '../../../L1_domain/repositories/abstract_db_repo.dart';
import '../../../L2_data/models/base.dart';

typedef ModelCreator<T> = T Function();

abstract class DBRepo<M extends BaseModel, E extends BaseEntity> extends AbstractDBRepo<M, E> {
  DBRepo(this.boxName, this.modelCreator);

  final String boxName;
  ModelCreator<M> modelCreator;

  Box<M>? _box;

  Future<Box<M>> get box async {
    _box ??= await Hive.openBox<M>(boxName);
    return _box!;
  }

  Future close() async => (await box).close();

  Future<M> _getOrCreateModel(String? id) async {
    M model;
    try {
      model = (await box).values.firstWhere((model) => model.id == id);
    } catch (e) {
      model = modelCreator();
      await (await box).add(model);
    }
    return model;
  }

  @override
  Future<Iterable<E>> get([Filter<E>? filter]) async {
    var entities = (await box).values.map((model) => model.toEntity() as E);
    if (filter != null) {
      entities = entities.where((e) => filter(e));
    }
    return entities;
  }

  @override
  Future<E?> getOne([Filter<E>? filter]) async {
    final entities = await get(filter);
    return entities.isNotEmpty ? entities.first : null;
  }

  @override
  Future update(E entity) async {
    try {
      final model = await _getOrCreateModel(entity.id);
      await model.update(entity);
    } catch (e) {
      print('update error ${entity.id} $e');
    }
  }

  @override
  Future delete(E entity) async {
    try {
      final model = await _getOrCreateModel(entity.id);
      await model.delete();
    } catch (e) {
      print('delete error ${entity.id} $e');
    }
  }

// @override
// Future<E> get(String id, [dynamic params]) async => (await _getOrCreateModel(id)).toEntity(params);
}
