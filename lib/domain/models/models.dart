
import 'package:reports/data/data_source/lacal_database.dart';

// Add Column  model
class AddColumn {
  String columnName;

  List<ImageDataHive> images;

  String latitude;
  String longitude;

  AddColumn(
      {required this.columnName,
      required this.images,
      required this.latitude,
      required this.longitude});
}
//
// class ImageDataModel {
//   String path;
//   String date;
//   String late;
//   String long;
//
//   ImageDataModel({
//     required this.path,
//     required this.date,
//     required this.late,
//     required this.long,
//   });
// }

class Authentication {
  UserData? userData;
  String token;

  Authentication({
    required this.userData,
    required this.token,
  });
}

class UserData {
  String username;

  UserData({
    required this.username,
  });
}

class LoginAuthentication {
  int id;
  String token;

  LoginAuthentication({
    required this.id,
    required this.token,
  });
}
