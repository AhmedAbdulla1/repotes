import 'dart:io';

// Add Column  model
class AddColumn {
  String columnName ;
  List<String> images ;
  String latitude;
  String longitude;
  AddColumn({
    required this.columnName,
    required this.images,
    required this.latitude,
    required this.longitude
  });
}

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

