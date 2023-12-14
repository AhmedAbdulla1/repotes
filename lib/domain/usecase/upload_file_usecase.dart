

import 'package:dartz/dartz.dart';
import 'package:reports/app/di.dart';
import 'package:reports/data/network/failure.dart';
import 'package:reports/domain/repository/repository.dart';
import 'package:reports/domain/usecase/base_usecase.dart';

class UploadFileUsecase extends BaseUseCase<String,String>{

  final Repository _repository =instance<Repository>();
  @override
  Future<Either<Failure, String>> execute(String input)async {
    return await _repository.uploadPdf(input);
  }

}
