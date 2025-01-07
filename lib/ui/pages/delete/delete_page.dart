import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:provider/provider.dart';

import '../../../providers/todo_provider.dart';
import '../../../utils/constants/app_paddings.dart';
import '../../../utils/constants/app_radiuses.dart';
import '../../../utils/extensions/num_extensions.dart';
import '../../widgets/custom_app_bar.dart';
import '../../widgets/custom_tile.dart';

class DeletePage extends StatelessWidget {
  const DeletePage({super.key});

  @override
  Widget build(BuildContext context) {
    final todoProvider = context.read<TodoProvider>();
    return Scaffold(
      appBar: const CustomAppBar.delete(),
      body: Consumer<TodoProvider>(
        builder: (_, __, ___) {
          final todos = todoProvider.deletedTodos;
          return ListView.separated(
            itemCount: todos.length,
            padding: AppPaddings.a16,
            separatorBuilder: (_, index) => 16.h,
            itemBuilder: (_, i) {
              final todo = todos[i];
              return Slidable(
                startActionPane: ActionPane(
                  extentRatio: 0.25,
                  motion: const ScrollMotion(),
                  children: [
                    SlidableAction(
                      onPressed: (context) => todoProvider.restoreTodo(todo.id),
                      backgroundColor: Colors.yellow,
                      foregroundColor: Colors.grey,
                      icon: Icons.restore,
                      label: 'Restore',
                      borderRadius: AppRadiuses.a16,
                    ),
                    6.w,
                  ],
                ),
                endActionPane: ActionPane(
                  extentRatio: 0.25,
                  motion: const ScrollMotion(),
                  children: [
                    6.w,
                    SlidableAction(
                      onPressed: (context) =>
                          todoProvider.permanentlyDeleteTodoById(todo.id),
                      backgroundColor: Colors.red,
                      foregroundColor: Colors.white,
                      icon: Icons.delete,
                      label: 'Delete',
                      borderRadius: AppRadiuses.a16,
                    ),
                  ],
                ),
                child: CustomTile(todo: todo),
              );
            },
          );
        },
      ),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            onPressed: () => todoProvider.deleteCheckedTodos(),
            child: const Icon(Icons.clear),
          ),
          10.h,
          FloatingActionButton(
            onPressed: () => todoProvider.permanentlyDeleteAll(),
            child: const Icon(Icons.delete_forever),
          ),
        ],
      ),
    );
  }
}
