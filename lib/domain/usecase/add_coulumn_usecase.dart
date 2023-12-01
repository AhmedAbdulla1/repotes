import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:reports/data/network/failure.dart';
import 'package:reports/domain/models/models.dart';
import 'package:reports/domain/repository/repository.dart';
import 'package:reports/domain/usecase/base_usecase.dart';

class AddColumnUsecase extends BaseUseCase<AddColumnUsecaseInput, String> {
  final Repository _repository;

  AddColumnUsecase(this._repository);

  @override
  Future<Either<Failure, String>> execute(AddColumnUsecaseInput input) {
    return _repository.addColumn(
      AddColumn(
          columnName: input.columnName,
          latitude: input.latitude,
          longitude: input.longitude,
          images: input.images),
    );
  }
}

class AddColumnUsecaseInput {
  String columnName;

  List<String> images;

  String longitude;
  String latitude;

  AddColumnUsecaseInput(
      {required this.columnName,
      required this.images,
      required this.latitude,
      required this.longitude});
}
