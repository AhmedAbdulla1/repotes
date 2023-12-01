import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:reports/app/constant.dart';
import 'package:reports/data/data_source/lacal_database.dart';

import 'app/app.dart';
import 'app/di.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initAppModule();
  await Hive.initFlutter();
  await Hive.openBox(Constant.mainBoxName);
  Hive.registerAdapter(AddColumnModelAdapter());
  runApp(MyApp());
}


