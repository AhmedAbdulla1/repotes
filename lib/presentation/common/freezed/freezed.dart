import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:reports/data/data_source/lacal_database.dart';
part 'freezed.freezed.dart';

@freezed
class SignupObject with _$SignupObject {
  factory SignupObject(
    String name,
    String email,
    String password,
    String boydWeight,
    String height,
    String age,
    String gender,
  ) = _SignupObject;
}

@freezed
class LoginObject with _$LoginObject {
  factory LoginObject(
    String email,
    String password,
  ) = _LoginObject;
}

@freezed
class AddColumnObject with _$AddColumnObject {
  factory AddColumnObject(
    String columnName,
    String latitude,
    String longitude,
    List<ImageDataHive> image,
  ) = _AddColumnObject;
}

// @freezed
// class TrainingObject with _$TrainingObject {
//   factory TrainingObject(
//     String exercises,
//     String image,
//     int large,
//     int smale,
//     bool autoStart,
//     int idleTime,
//   ) = _TrainingObject;
// }
