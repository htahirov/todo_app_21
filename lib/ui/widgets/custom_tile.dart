import 'package:flutter/material.dart';
import 'package:todo_app_flutter/data/models/todo_model.dart';

import '../../utils/constants/app_colors.dart';
import '../../utils/constants/app_radiuses.dart';

class CustomTile extends StatefulWidget {
  const CustomTile({
    super.key,
    required this.todo,
  });

  final TodoModel todo;

  @override
  State<CustomTile> createState() => _CustomTileState();
}

class _CustomTileState extends State<CustomTile> {
  late bool _isChecked;

  TextDecoration? get _textDecoration =>
      _isChecked ? TextDecoration.lineThrough : null;

  @override
  void initState() {
    _isChecked = widget.todo.isChecked;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () {
        _isChecked = !_isChecked;
        setState(() {});
      },
      title: Text(
        widget.todo.title,
        style: TextStyle(decoration: _textDecoration),
      ),
      subtitle: Text(
        widget.todo.description,
        style: TextStyle(decoration: _textDecoration),
      ),
      tileColor: AppColors.tileColor,
      shape: AppRadiuses.aR16,
      trailing: Checkbox.adaptive(
        value: _isChecked,
        onChanged: (v) {
          _isChecked = v!;
          setState(() {});
        },
      ),
    );
  }
}
