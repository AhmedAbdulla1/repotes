import 'package:dartz/dartz.dart';
import 'package:reports/data/network/failure.dart';
import 'package:reports/data/network/requests.dart';
import 'package:reports/domain/models/models.dart';

abstract class Repository {
  Future<Either<Failure, LoginAuthentication>> login(LoginRequest loginRequest);


  // Forgot password
  // Future<Either<Failure, void>> sendEmail(String email);
  // Future<Either<Failure, String>> restPassword(RestPasswordRequest restPasswordRequest);

  // home
  // Future<Either<Failure, Home>> dashboard();

  // update profile
Future<Either<Failure,void>> updateProfile(UpdateProfileRequest updateProfileRequest );

}
