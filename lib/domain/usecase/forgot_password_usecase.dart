// import 'package:dartz/dartz.dart';
// import 'package:FireBox/data/network/failure.dart';
// import 'package:FireBox/data/network/requests.dart';
// import 'package:FireBox/domain/models/models.dart';
// import 'package:FireBox/domain/repository/repository.dart';
// import 'package:FireBox/domain/usecase/base_usecase.dart';
//
// class RecoverPasswordUseCase implements BaseUseCase<String, void> {
//   final Repository _repository;
//
//   RecoverPasswordUseCase(this._repository);
//
//   @override
//   Future<Either<Failure, void>> execute(String input) async {
//     return await _repository.sendEmail(input);
//   }
// }
//
// class VerifyCodeUseCase implements BaseUseCase<String , void>{
//   final Repository _repository;
//
//   VerifyCodeUseCase(this._repository);
//
//   @override
//   Future<Either<Failure, void>> execute(String input) {
//     throw UnimplementedError();
//   }
//
// }
//
// // class ChangePasswordUseCase
// //     implements BaseUseCase<ChangePasswordUseCaseInput, String> {
// //   final Repository _repository;
// //
// //   ChangePasswordUseCase(this._repository);
// //
// //   @override
// //   Future<Either<Failure, String>> execute(ChangePasswordUseCaseInput input) {
// //     return _repository.restPassword(RestPasswordRequest(
// //       otp: input.otp,
// //       password: input.password,
// //     ));
// //   }
// // }
//
// class ChangePasswordUseCaseInput {
//   String otp;
//   String password;
//
//   ChangePasswordUseCaseInput({
//     required this.otp,
//     required this.password,
//   });
// }
