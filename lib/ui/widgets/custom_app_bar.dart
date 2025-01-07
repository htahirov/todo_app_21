import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../providers/todo_provider.dart';
import '../../utils/constants/app_colors.dart';
import '../../utils/constants/app_paddings.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar.all({
    super.key,
    this.onTapAction,
  })  : title = 'All Todos',
        showActions = true;

  const CustomAppBar.delete({
    super.key,
  })  : onTapAction = null,
        title = 'Delete Todos',
        showActions = false;

  final String title;
  final bool showActions;
  final void Function()? onTapAction;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: AppColors.primary,
      title: Text(title),
      actions: [
        if (showActions)
          Stack(
            children: [
              IconButton(
                onPressed: onTapAction,
                icon: const Icon(Icons.delete),
                color: AppColors.red,
                iconSize: 32,
              ),
              Positioned(
                right: 0,
                top: -6,
                child: Consumer<TodoProvider>(
                  builder: (_, provider, __) => provider.deletedTodosCount > 0
                      ? DecoratedBox(
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            color: AppColors.grey,
                          ),
                          child: Padding(
                            padding: AppPaddings.a6,
                            child: Center(
                              child: Text(
                                '${provider.deletedTodosCount}',
                                style: const TextStyle(
                                  color: AppColors.white,
                                  fontSize: 14,
                                ),
                              ),
                            ),
                          ),
                        )
                      : const SizedBox.shrink(),
                ),
              ),
            ],
          ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
