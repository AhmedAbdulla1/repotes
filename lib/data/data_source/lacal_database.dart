import 'dart:io';

import 'package:hive/hive.dart';
import 'package:reports/app/constant.dart';

part 'lacal_database.g.dart';

@HiveType(typeId: 1,)
class AddColumnModel extends HiveObject {
  @HiveField(0)
  String columnName;

  @HiveField(1)
  String longitude;
  @HiveField(2)
  String latitude;
  @HiveField(3)
  List<String> images;

  AddColumnModel({
    required this.columnName,
    required this.latitude,
    required this.longitude,
    required this.images,
  });
}
