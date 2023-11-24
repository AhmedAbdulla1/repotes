import 'package:reports/data/data_source/local_data_source.dart';
import 'package:dartz/dartz.dart';
import 'package:reports/data/data_source/remote_data_source.dart';
import 'package:reports/data/mapper/mapper.dart';
import 'package:reports/data/network/error_handler.dart';
import 'package:reports/data/network/failure.dart';
import 'package:reports/data/network/network_info.dart';
import 'package:reports/data/network/requests.dart';
import 'package:reports/data/response/responses.dart';
import 'package:reports/domain/models/models.dart';
import 'package:reports/domain/repository/repository.dart';

class RepositoryImpl implements Repository {
  // final LocalDataSource _localDataSource;
  final RemoteDataSource _remoteDataSource;
  final NetWorkInfo _networkInfo;

  RepositoryImpl(
    // this._localDataSource,
    this._remoteDataSource,
    this._networkInfo,
  );

  @override
  Future<Either<Failure,LoginAuthentication >> login(LoginRequest loginRequest) async {
    if (await _networkInfo.isConnected) {
      try {
        final LoginAuthenticationResponse response = await _remoteDataSource.loginResponse(
          loginRequest,
        );
        // _localDataSource.saveHomeToCache(response);
        return Right(
          response.toDomain(),
        );
      } catch (error) {
        return Left(
          ErrorHandler.handle(error).failure,
        );
      }
    } else {
      return Left(
        DataSource.noInternetConnection.getFailure(),
      );
    }
  }


  @override
  // Future<Either<Failure, void>> sendEmail(String email) async {
  //   if (await _networkInfo.isConnected) {
  //     try {
  //       final void response = await _remoteDataSource.sendEmailResponse(email);
  //       return Right(
  //         response,
  //       );
  //     } catch (error) {
  //       return Left(
  //         ErrorHandler.handle(error).failure,
  //       );
  //     }
  //   } else {
  //     return Left(
  //       DataSource.noInternetConnection.getFailure(),
  //     );
  //   }
  // }

  // @override
  // Future<Either<Failure, String>> restPassword(
  //     RestPasswordRequest restPasswordRequest) async {
  //   if (await _networkInfo.isConnected) {
  //     try {
  //       final RestPasswordResponse response =
  //           await _remoteDataSource.restPasswordResponse(restPasswordRequest);
  //
  //       if (response.status == ApiInternalStatus.success) {
  //         // _localDataSource.saveHomeToCache(response);
  //         return Right(
  //           response.toDomain(),
  //         );
  //       } else {
  //         return Left(
  //           Failure(
  //             code: ApiInternalStatus.failure,
  //             message: response.message ?? ResponseMessage.customDefault,
  //           ),
  //         );
  //       }
  //     } catch (error) {
  //       return Left(
  //         ErrorHandler.handle(error).failure,
  //       );
  //     }
  //   } else {
  //     return Left(
  //       DataSource.noInternetConnection.getFailure(),
  //     );
  //   }
  // }

  // @override
  // Future<Either<Failure, Home>> dashboard() async {
  //   try {
  //     final response = await _localDataSource.homeResponse(true);
  //     return Right(
  //       response.toDomain(),
  //     );
  //   } catch (cacheError) {
  //     if (await _networkInfo.isConnected) {
  //       final DocumentSnapshot response = await _remoteDataSource.dashboardResponse();
  //       try {
  //         if (response.exists) {
  //           // _localDataSource.saveHomeToCache(response);
  //           return Right(
  //             response.toDomain(),
  //           );
  //         } else {
  //           return Left(
  //             Failure(
  //               code: ApiInternalStatus.failure,
  //               message: ResponseMessage.customDefault,
  //             ),
  //           );
  //         }
  //       } catch (error) {
  //         return Left(
  //           ErrorHandler.handle(error).failure,
  //         );
  //       }
  //     } else {
  //       try {
  //         // final response = await _localDataSource.homeResponse(false);
  //         // return Right(
  //         //   response.toDomain(),
  //         // );
  //       } catch (catchError) {
  //         return Left(
  //           DataSource.noInternetConnection.getFailure(),
  //         );
  //       }
  //     }
  //   }
  // }

  @override
  Future<Either<Failure, void>> updateProfile(UpdateProfileRequest updateProfileRequest) async {
    if (await _networkInfo.isConnected) {
      void response;
      try {
        if (true) {
          // _localDataSource.saveHomeToCache(response);
          return Right(
            response,
          );
        } else {
          return Left(
            Failure(
              code: ApiInternalStatus.failure,
              message: ResponseMessage.customDefault,
            ),
          );
        }
      } catch (error) {
        return Left(
          ErrorHandler.handle(error).failure,
        );
      }
    } else {
      return Left(
        DataSource.noInternetConnection.getFailure(),
      );
    }
  }

}

// @override
// Future<Either<Failure, String>> forgotPassword(String email) async {
//   if (await _networkInfo.isConnected) {
//     final ForgotPasswordResponse response =
//         await _remoteDataSource.forgotPasswordResponse(email);
//     try {
//       if (response.status == ApiInternalStatus.success) {
//         return Right(
//           response.toString(),
//         );
//       } else {
//         return Left(
//           Failure(
//             code: ApiInternalStatus.failure,
//             message: response.message ?? ResponseMessage.customDefault,
//           ),
//         );
//       }
//     } catch (error) {
//       return Left(
//         ErrorHandler.handle(error).failure,
//       );
//     }
//   } else {
//     return Left(
//       DataSource.noInternetConnection.getFailure(),
//     );
//   }
// }

// @override
// Future<Either<Failure, Home>> home() async {
//   try {
//     final response = await _localDataSource.homeResponse();
//     return Right(
//       response.toDomain(),
//     );
//   } catch (cacheError) {
//     if (await _networkInfo.isConnected) {
//       final HomeResponse response = await _remoteDataSource.homeResponse();
//       try {
//         if (response.status == ApiInternalStatus.success) {
//           _localDataSource.saveHomeToCache(response);
//           return Right(
//             response.toDomain(),
//           );
//         } else {
//           return Left(
//             Failure(
//               code: ApiInternalStatus.failure,
//               message: response.message ?? ResponseMessage.customDefault,
//             ),
//           );
//         }
//       } catch (error) {
//         return Left(
//           ErrorHandler.handle(error).failure,
//         );
//       }
//     } else {
//       return Left(
//         DataSource.noInternetConnection.getFailure(),
//       );
//     }
//   }
// }
//
// @override
// Future<Either<Failure, StoresDetails>> storeDetails() async {
//   try {
//     final response = await _localDataSource.storeDetailsResponse();
//     return Right(
//       response.toDomain(),
//     );
//   } catch (cacheError) {
//     print(cacheError);
//     if (await _networkInfo.isConnected) {
//       final StoresDetailsResponse response =
//           await _remoteDataSource.storeDetailsResponse();
//       try {
//         if (response.status == ApiInternalStatus.success) {
//           _localDataSource.saveStoreDetailsToCache(response);
//           return Right(
//             response.toDomain(),
//           );
//         } else {
//           return Left(
//             Failure(
//               code: ApiInternalStatus.failure,
//               message: response.message ?? ResponseMessage.customDefault,
//             ),
//           );
//         }
//       } catch (error) {
//         return Left(
//           ErrorHandler.handle(error).failure,
//         );
//       }
//     } else {
//       return Left(
//         DataSource.noInternetConnection.getFailure(),
//       );
//     }
//   }
// }
