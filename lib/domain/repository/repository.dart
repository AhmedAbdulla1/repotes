import 'package:dartz/dartz.dart';
import 'package:reports/data/network/failure.dart';
import 'package:reports/data/network/requests.dart';
import 'package:reports/domain/models/models.dart';

abstract class Repository {
  Future<Either<Failure, String>> login(LoginRequest loginRequest);
  Future<Either<Failure, String>> addColumn (AddColumn addColumn);
  Future<Either<Failure,String>> uploadPdf(String filePath);
  Future<Either<Failure, String>> updateStatus(String fileName, String status);
}
