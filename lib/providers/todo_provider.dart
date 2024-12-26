import 'package:flutter/material.dart';

import '../data/models/todo_model.dart';
import '../utils/helpers/go.dart';

class TodoProvider extends ChangeNotifier {
  late final titleController = TextEditingController();
  late final descriptionController = TextEditingController();

  final List<TodoModel> _todos = [];

  List<TodoModel> get todos => _todos;

  void addTodo(BuildContext context) {
    _todos.add(
      TodoModel(
        title: titleController.text,
        description: descriptionController.text,
      ),
    );
    notifyListeners();
    _clearInputsAndCloseSheet(context);
  }

  void updateTodo(
    BuildContext context,
    int i,
  ) {
    _todos[i].title = titleController.text;
    _todos[i].description = descriptionController.text;

    _clearInputsAndCloseSheet(context);

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
