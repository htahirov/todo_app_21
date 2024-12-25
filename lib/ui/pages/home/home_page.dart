import 'package:flutter/material.dart';
import 'package:todo_app_flutter/utils/helpers/go.dart';
import '../../../data/models/todo_model.dart';
import '../../widgets/custom_input.dart';
import '../../../utils/constants/app_colors.dart';
import '../../../utils/extensions/context_extensions.dart';

import '../../../utils/constants/app_paddings.dart';
import '../../../utils/extensions/num_extensions.dart';
import '../../widgets/custom_tile.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: const Text('Todo Page'),
      ),
      body: ListView.separated(
        itemCount: TodoModel.todos.length,
        padding: AppPaddings.a16,
        separatorBuilder: (_, index) => 16.h,
        itemBuilder: (_, i) {
          final todo = TodoModel.todos[i];
          return CustomTile(todo: todo);
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showModalBottomSheet(
            context: context,
            isScrollControlled: true,
            backgroundColor: AppColors.white,
            builder: (_) {
              return Padding(
                padding: context.keyboardPadding + AppPaddings.a16,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    CustomInput(
                      hintText: 'Title',
                      controller: _titleController,
                    ),
                    8.h,
                    CustomInput(
                      hintText: 'Description',
                      controller: _descriptionController,
                    ),
                    16.h,
                    FloatingActionButton(
                      backgroundColor: AppColors.green,
                      onPressed: () {
                        TodoModel.todos.add(
                          TodoModel(
                            title: _titleController.text,
                            description: _descriptionController.text,
                          ),
                        );
                        Go.pop(context);
                        _titleController.clear();
                        _descriptionController.clear();
                        setState(() {});
                      },
                      child: const Text('Add'),
                    ),
                  ],
                ),
              );
            },
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
