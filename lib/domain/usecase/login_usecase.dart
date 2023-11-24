import 'package:dartz/dartz.dart';
import 'package:reports/data/network/failure.dart';
import 'package:reports/data/network/requests.dart';
import 'package:reports/domain/models/models.dart';
import 'package:reports/domain/repository/repository.dart';
import 'package:reports/domain/usecase/base_usecase.dart';


class  LoginUseCase extends BaseUseCase <LoginUseCaseInput,LoginAuthentication>{

  final Repository _repository;

  LoginUseCase(this._repository);

  @override
  Future<Either<Failure, LoginAuthentication>> execute(LoginUseCaseInput input) {
    return _repository.login(LoginRequest(email: input.email, password: input.password));

  }

}

class LoginUseCaseInput {
  final String email;
  final String password;

  LoginUseCaseInput({required this.email,required this.password});
}