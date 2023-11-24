


import 'package:freezed_annotation/freezed_annotation.dart';
part 'freezed.freezed.dart';
@freezed
class SignupObject with _$SignupObject{
  factory SignupObject(
      String name,
      String email,
      String password,
      String boydWeight,
      String height,
      String age,
      String gender,
      )=_SignupObject;
}


@freezed
class LoginObject with _$LoginObject{
  factory LoginObject(
      String email,
      String password,
      )=_LoginObject;
}
@freezed
class ForgotPasswordObject with _$ForgotPasswordObject{
  factory ForgotPasswordObject(
      String email,
      String otp,
      String password,
      )=_ForgotPasswordObject;
}

@freezed
class TrainingObject with _$TrainingObject{
  factory TrainingObject(
  String exercises,
  String image,
  int large ,
  int smale,
bool autoStart,
int idleTime,
)=_TrainingObject;
}