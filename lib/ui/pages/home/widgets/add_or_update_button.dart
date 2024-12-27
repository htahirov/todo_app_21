import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app_flutter/utils/extensions/context_extensions.dart';

import '../../../../providers/todo_provider.dart';
import '../../../../utils/constants/app_colors.dart';
import '../../../../utils/enums/button_type.dart';

class AddOrUpdateButton extends StatelessWidget {
  const AddOrUpdateButton({
    super.key,
    this.id,
    this.buttonType = ButtonType.add,
  });

  final String? id;
  final ButtonType buttonType;

  @override
  Widget build(BuildContext context) {
    final todoProvider = context.read<TodoProvider>();
    return Padding(
      padding: context.keyboardPadding,
      child: FloatingActionButton(
        backgroundColor: AppColors.green,
        onPressed: () => buttonType == ButtonType.add
            ? todoProvider.addTodo(context)
            : todoProvider.updateTodo(context, id!),
        child: buttonType == ButtonType.add
            ? const Text('Add')
            : const Text('Update'),
      ),
    );
  }
}
