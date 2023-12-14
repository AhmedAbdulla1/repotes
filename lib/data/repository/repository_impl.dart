import 'package:dio/dio.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:reports/app/app_prefs.dart';
import 'package:reports/app/constant.dart';
import 'package:reports/app/di.dart';
import 'package:reports/data/data_source/lacal_database.dart';
import 'package:dartz/dartz.dart';
import 'package:reports/data/data_source/remote_data_source.dart';
import 'package:reports/data/network/error_handler.dart';
import 'package:reports/data/network/failure.dart';
import 'package:reports/data/network/network_info.dart';
import 'package:reports/data/network/requests.dart';
import 'package:reports/domain/models/models.dart';
import 'package:reports/domain/repository/repository.dart';

class RepositoryImpl implements Repository {
  // final LocalDataSource _localDataSource;
  final AppPreferences _appPreferences = instance<AppPreferences>();
  Box columnBox = Hive.box<AddColumnModel>(Constant.mainBoxName);
  final Dio dio = Dio();
  String url = "${Constant.baseurl}login.php";
  final RemoteDataSource _remoteDataSource;
  final NetWorkInfo _networkInfo;

  RepositoryImpl(
    // this._localDataSource,
    this._remoteDataSource,
    this._networkInfo,
  );

  @override
  Future<Either<Failure, String>> login(LoginRequest loginRequest) async {
    FormData formData = FormData.fromMap({
      'username': loginRequest.email,
      'password': loginRequest.password,
    });
    if (await _networkInfo.isConnected) {
      try {
        Response response = await dio.post(
          "${Constant.baseurl}login.php",
          data: formData,
        );

        if (response.data["status"] == "1") {
          return Right(
            loginRequest.email,
          );
        } else {
          return Left(
            Failure(
              code: 0,
              message: response.data['massage'],
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

  @override
  Future<Either<Failure, String>> addColumn(AddColumn addColumn) async {
    try {
      columnBox.add(
        AddColumnModel(
          columnName: addColumn.columnName,
          latitude: addColumn.latitude,
          longitude: addColumn.longitude,
          images: addColumn.images,
        ),
      );
      print(columnBox.values.toList());
      return const Right('done');
    } catch (error) {
      return Left(Failure(code: 0, message: "فشل الحفظ"));
    }
  }

  @override
  Future<Either<Failure, String>> uploadPdf(String filePath) async {
    if (await _networkInfo.isConnected) {
      try {
        FormData formData = FormData.fromMap({
          'user_name': _appPreferences.getToken(),
          'pdf': await MultipartFile.fromFile(filePath),
        });
        Response response = await dio.post(
          'https://roayadesign.com/api_s/tqarer_a3meda_s3udia/pdf_upload',
          data: formData,
        );

        if (response.data["status"] == "1") {
          print(response.data);
          return const Right("");
        } else {
          return Left(
            Failure(
              code: 0,
              message: response.data['massage'],
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
  @override
  Future<Either<Failure, String>> updateStatus(String fileName, String status) async {

    if (await _networkInfo.isConnected) {
      try {
        FormData formData = FormData.fromMap({
          'filename': fileName,
          'staues': status,
        });
        Response response = await dio.post(
          'https://roayadesign.com/api_s/tqarer_a3meda_s3udia/button_api',
          data: formData,
        );

        if (response.data["status"] == "1") {
          return const Right("");
        } else {
          return Left(
            Failure(
              code: 0,
              message: response.data['massage'],
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
