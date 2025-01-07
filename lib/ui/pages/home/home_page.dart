import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:provider/provider.dart';
import 'package:todo_app_flutter/utils/helpers/go.dart';
import 'package:todo_app_flutter/utils/helpers/pager.dart';

import '../../../providers/todo_provider.dart';
import '../../../utils/constants/app_colors.dart';
import '../../../utils/constants/app_paddings.dart';
import '../../../utils/constants/app_radiuses.dart';
import '../../../utils/enums/button_type.dart';
import '../../../utils/extensions/num_extensions.dart';
import '../../widgets/custom_input.dart';
import '../../widgets/custom_tile.dart';
import 'widgets/add_or_update_button.dart';
import '../../widgets/custom_app_bar.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final todoProvider = context.read<TodoProvider>();
    log('Screen rebuilding..');
    return Scaffold(
      appBar: CustomAppBar.all(
        onTapAction: () => Go.to(context, Pager.delete(context)),
      ),
      body: Consumer<TodoProvider>(
        builder: (_, __, ___) {
          log('TODO list rebuilding..');
          return FutureBuilder(
              future: todoProvider.getTodos(),
              builder: (_, snapshot) {
                final todos = snapshot.data ?? [];
                return RefreshIndicator.adaptive(
                  onRefresh: () async => todoProvider.getTodos(),
                  child: ListView.separated(
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
                              onPressed: (context) {
                                todoProvider.titleController.text = todo.title;
                                todoProvider.descriptionController.text =
                                    todo.description;
                                _showBottomSheet(
                                  context,
                                  todoProvider,
                                  ButtonType.update,
                                  id: todo.id,
                                );
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
                        endActionPane: ActionPane(
                          extentRatio: 0.25,
                          motion: const ScrollMotion(),
                          children: [
                            6.w,
                            SlidableAction(
                              onPressed: (context) =>
                                  todoProvider.deleteTodo(todo.id),
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
                  ),
                );
              });
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showBottomSheet(
          context,
          todoProvider,
          ButtonType.add,
        ),
        child: const Icon(Icons.add),
      ),
    );
  }
}

void _showBottomSheet(
  BuildContext context,
  TodoProvider todoProvider,
  ButtonType buttonType, {
  String? id,
}) {
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    backgroundColor: AppColors.white,
    builder: (ctx) {
      return ChangeNotifierProvider.value(
        value: todoProvider,
        child: Padding(
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
              AddOrUpdateButton(
                id: id,
                buttonType: buttonType,
              ),
            ],
          ),
        ),
      );
    },
  );
}
