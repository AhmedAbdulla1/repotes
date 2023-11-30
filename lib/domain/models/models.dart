import 'dart:io';

// Add Column  model
class AddColumn {
  String columnName ;
  List<File> images ;
  String location;
  AddColumn({
    required this.columnName,
    required this.images,
    required this.location,
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

