import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../providers/todo_provider.dart';
import '../../ui/pages/home/home_page.dart';

class Pager {
  Pager._();

  static Widget get home => ChangeNotifierProvider(
        create: (_) => TodoProvider(),
        child: const HomePage(),
      );
}
