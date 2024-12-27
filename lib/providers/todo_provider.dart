import 'dart:developer';

import 'package:flutter/material.dart';

import '../data/models/todo_model.dart';
import '../data/services/todo_hive_service.dart';
import '../utils/helpers/go.dart';

class TodoProvider extends ChangeNotifier {
  late final titleController = TextEditingController();
  late final descriptionController = TextEditingController();

  List<TodoModel> _todos = [];

  Future<List<TodoModel>> getTodos() async {
    log('Reload');
    _todos = await TodoHiveService.getTodos();
    return _todos;
  }

  void addTodo(BuildContext context) async {
    _todos.add(
      TodoModel(
        id: '${DateTime.now()}',
        title: titleController.text,
        description: descriptionController.text,
      ),
    );

    await TodoHiveService.saveTodo(_todos);

    notifyListeners();
    _clearInputsAndCloseSheet(context);
  }

  void updateTodo(
    BuildContext context,
    String id,
  ) async {
    final index = _todos.indexWhere((e) => e.id == id);
    _todos[index] = TodoModel(
      id: id,
      title: titleController.text,
      description: descriptionController.text,
    );

    await TodoHiveService.saveTodo(_todos);

    _clearInputsAndCloseSheet(context);

    notifyListeners();
  }

  void deleteTodo(String id) async {
    _todos.removeWhere((e) => e.id == id);
    await TodoHiveService.saveTodo(_todos);
    notifyListeners();
  }

  void _clearInputsAndCloseSheet(BuildContext context) {
    Go.pop(context);
    titleController.clear();
    descriptionController.clear();
  }

  @override
  void dispose() {
    titleController.dispose();
    descriptionController.dispose();
    super.dispose();
  }
}
