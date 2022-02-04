// Copyright (c) 2021. Alexandr Moroz

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:mobx/mobx.dart';

import '../../../extra/services.dart';

part 'base_controller.g.dart';

class BaseController = _BaseControllerBase with _$BaseController;

abstract class _BaseControllerBase with Store {
  BuildContext? context;

  late TextEditingController titleController;
  late TextEditingController descriptionController;

  Future init() async => this;

  @mustCallSuper
  void initState(BuildContext _context) {
    context = _context;
    titleController = TextEditingController();
    titleController.addListener(_titleChanged);
    descriptionController = TextEditingController();
  }

  @mustCallSuper
  void dispose() {
    titleController.dispose();
    descriptionController.dispose();
  }

  @observable
  String title = '';

  @action
  void _titleChanged() => title = titleController.text;

  @computed
  bool get isUnique => false;

  @computed
  bool get canSave => title.isNotEmpty && isUnique;

  @observable
  bool editMode = false;

  @action
  void setEditMode(bool mode) => editMode = mode;
}
