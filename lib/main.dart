import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

import 'app/app.dart';
import 'app/di.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initAppModule();
  // await Hive.initFlutter();
  runApp(MyApp());
}


