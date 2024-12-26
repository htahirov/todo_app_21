import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:provider/provider.dart';
import 'package:todo_app_flutter/utils/constants/app_radiuses.dart';

import '../../../providers/todo_provider.dart';
import '../../../utils/constants/app_colors.dart';
import '../../../utils/constants/app_paddings.dart';
import '../../../utils/extensions/num_extensions.dart';
import '../../widgets/custom_input.dart';
import '../../widgets/custom_tile.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final todoProvider = context.read<TodoProvider>();
    log('Screen rebuilding..');
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.primary,
        title: const Text('Todo Page'),
      ),
      body: Consumer<TodoProvider>(
        builder: (_, __, ___) {
          log('TODO list rebuilding..');
          return ListView.separated(
            itemCount: todoProvider.todos.length,
            padding: AppPaddings.a16,
            separatorBuilder: (_, index) => 16.h,
            itemBuilder: (_, i) {
              final todo = todoProvider.todos[i];
              return Slidable(
                startActionPane: ActionPane(
                  extentRatio: 0.25,
                  motion: const ScrollMotion(),
                  children: [
                    SlidableAction(
                      onPressed: (context) {
                        todoProvider.titleController.text = todo.title;
                        todoProvider.descriptionController.text =
                            todo.description;
                        _showBottomSheet(context, todoProvider, false, i: i);
                      },
                      backgroundColor: Colors.yellow,
                      foregroundColor: Colors.grey,
                      icon: Icons.edit,
                      label: 'Edit',
                      borderRadius: AppRadiuses.a16,
                    ),
                    6.w,
                  ],
                ),
                child: CustomTile(todo: todo),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showBottomSheet(context, todoProvider, true),
        child: const Icon(Icons.add),
      ),
    );
  }
}

void _showBottomSheet(
    BuildContext context, TodoProvider todoProvider, bool isAdd,
    {int? i}) {
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    backgroundColor: AppColors.white,
    builder: (ctx) {
      return Padding(
        padding: AppPaddings.a16,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            CustomInput(
              hintText: 'Title',
              controller: todoProvider.titleController,
            ),
            8.h,
            CustomInput(
              hintText: 'Description',
              controller: todoProvider.descriptionController,
            ),
            16.h,
            FloatingActionButton(
              backgroundColor: AppColors.green,
              onPressed: () => isAdd
                  ? todoProvider.addTodo(ctx)
                  : todoProvider.updateTodo(ctx, i!),
              child: isAdd ? const Text('Add') : const Text('Update'),
            ),
          ],
        ),
      );
    },
  );
}
