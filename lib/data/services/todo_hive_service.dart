import 'dart:convert';

import 'package:hive_flutter/hive_flutter.dart';

import '../models/todo_model.dart';

class TodoHiveService {
  static Future<void> saveTodo(List<TodoModel> todoList) async {
    final box = await Hive.openBox<String>('todoBox');
    final list = todoList.map((e) => e.toJson()).toList();
    final encodedData = jsonEncode(list);
    await box.put('todoKey', encodedData);
  }

  static Future<List<TodoModel>> getTodos() async {
    final box = await Hive.openBox<String>('todoBox');
    final list = box.get('todoKey') ?? '[]';
    final List todos = jsonDecode(list);
    return todos.map((e) => TodoModel.fromJson(e)).toList();
  }
}
