import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'ui/app.dart';

void main() async {
  await Hive.initFlutter();
  runApp(const MyApp());
}
