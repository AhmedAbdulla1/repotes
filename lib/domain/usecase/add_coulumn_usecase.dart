import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:reports/data/network/failure.dart';
import 'package:reports/domain/usecase/base_usecase.dart';

class AddColumnUsecase extends BaseUseCase<AddColumnUsecaseInput , String>{
  @override
  Future<Either<Failure, String>> execute(AddColumnUsecaseInput input) {
    // TODO: implement execute
    throw UnimplementedError();
  }


}

class AddColumnUsecaseInput {

  String columnName ;
  List<File> images ;
  String location;
  AddColumnUsecaseInput({
    required this.columnName,
    required this.images,
    required this.location,
  });
}