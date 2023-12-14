import 'package:hive/hive.dart';

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
  List<ImageDataHive> images;

  AddColumnModel({
    required this.columnName,
    required this.latitude,
    required this.longitude,
    required this.images,
  });
}

@HiveType(typeId: 2)
class ImageDataHive extends HiveObject {
  @HiveField(0)
  String path;
  @HiveField(1)
  String date;
  @HiveField(2)
  String late;
  @HiveField(3)
  String long;

  ImageDataHive({
    required this.path,
    required this.date,
    required this.late,
    required this.long,
  });

}