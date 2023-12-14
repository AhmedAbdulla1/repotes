import 'package:reports/presentation/login_screen/view_model/login_view_model.dart';

// import 'package:reports/presentation/main_screen/main_view_model.dart';
// import 'package:reports/presentation/main_screen/screens/dashboard/view_model.dart';
// import 'package:reports/presentation/main_screen/screens/profile/view.dart';
// import 'package:reports/presentation/main_screen/screens/profile/view_model.dart';
// import 'package:reports/presentation/profile_details_screen/view_model.dart';
// import 'package:reports/presentation/reset_password_screen/view_model/change_password_view_model.dart';
// import 'package:reports/presentation/reset_password_screen/view_model/recover_password_view_model.dart';
// import 'package:reports/presentation/reset_password_screen/view_model/verify_code_view_model.dart';
// import 'package:reports/presentation/signup_screen/view_model/signup_view_model.dart';
import 'package:dio/dio.dart';
import 'package:reports/app/app_prefs.dart';
import 'package:reports/data/data_source/remote_data_source.dart';
import 'package:reports/data/network/dio_factory.dart';
import 'package:reports/data/network/network_info.dart';
import 'package:reports/data/repository/repository_impl.dart';
import 'package:reports/domain/repository/repository.dart';
import 'package:reports/domain/usecase/login_usecase.dart';
import 'package:get_it/get_it.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:reports/presentation/main_screen/add-column/view_model.dart';
import 'package:reports/presentation/main_screen/finished-column/view_model.dart';
import 'package:reports/presentation/main_screen/main_view_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../data/network/app_api.dart';

final instance = GetIt.instance;

Future<void> initAppModule() async {
  final shardPref = await SharedPreferences.getInstance();
  // instance for shared pref
  instance.registerLazySingleton(() => shardPref);
  // instant for AppPreferences
  instance.registerLazySingleton(
    () => AppPreferences(
      instance<SharedPreferences>(),
    ),
  );

  // instant for network info
  instance.registerLazySingleton<NetWorkInfo>(
    () => NetworkInfoImpl(
      InternetConnectionChecker(),
    ),
  );

  // instant for dioFactory
  instance.registerLazySingleton<DioFactory>(
    () => DioFactory(
      instance<AppPreferences>(),
    ),
  );
  Dio dio = await instance<DioFactory>().getDio();
  //instant for AppServicesClient
  instance.registerLazySingleton<AppServicesClient>(
    () => AppServicesClient(dio),
  );
//
  // instant for remoteDataSource
  instance.registerLazySingleton<RemoteDataSource>(
    () => RemoteDataSourceImpl(
      instance<AppServicesClient>(),
    ),
  );
  // instance for local data source
  // instance.registerLazySingleton<LocalDataSource>(
  //   () => LocalDataSourceImpl(),
  // );
//   //instant for repository

  instance.registerLazySingleton<Repository>(
    () => RepositoryImpl(
      // instance<LocalDataSource>(),
      instance<RemoteDataSource>(),
      instance<NetWorkInfo>(),
    ),
  );
}

initLoginModule() {
  if (!GetIt.I.isRegistered<LoginViewModel>()) {
    if(!GetIt.I.isRegistered<LoginUseCase>()){
      instance.registerFactory<LoginUseCase>(
        () => LoginUseCase(
          instance<Repository>(),
        ),
      );
    }
    instance.registerFactory<LoginViewModel>(
      () => LoginViewModel(
        instance<LoginUseCase>(),
      ),
    );
  }
}

//

// initFinishedColumnModule() {
//   if (!GetIt.I.isRegistered<FinishedColumnViewModel>()) {
//     instance.registerFactory<FinishedColumnViewModel>(
//       () => FinishedColumnViewModel(),
//     );
//   }
// }
//
// initVerifyCodeModule() {
//   if (!GetIt.I.isRegistered<VerifyCodeUseCase>()) {
//     instance.registerFactory<VerifyCodeUseCase>(
//       () => VerifyCodeUseCase(
//         instance<Repository>(),
//       ),
//     );
//     instance.registerFactory<VerifyCodeViewModel>(
//       () => VerifyCodeViewModel(
//         instance<VerifyCodeUseCase>(),
//       ),
//     );
//   }
// }

// initChangePasswordModule() {
//   if (!GetIt.I.isRegistered<ChangePasswordUseCase>()) {
//     instance.registerFactory<ChangePasswordUseCase>(
//       () => ChangePasswordUseCase(
//         instance<Repository>(),
//       ),
//     );
//     instance.registerFactory<ChangePasswordViewModel>(
//       () => ChangePasswordViewModel(
//         instance<ChangePasswordUseCase>(),
//       ),
//     );
//   }
// }
initMainModule() {
  if (!GetIt.I.isRegistered<MainViewModel>()) {
    if(!GetIt.I.isRegistered<LoginUseCase>()){
    instance.registerFactory<LoginUseCase>(
          () => LoginUseCase(
        instance<Repository>(),
      ),
    );}
    instance.registerFactory<MainViewModel>(() => MainViewModel(
      instance<LoginUseCase>(),
    ));
  }
  if (!GetIt.I.isRegistered<AddColumnViewModel>()) {
    instance.registerFactory<AddColumnViewModel>(
      () => AddColumnViewModel(),
    );
  }
  if (!GetIt.I.isRegistered<FinishedColumnViewModel>()) {
    instance.registerFactory<FinishedColumnViewModel>(
          () => FinishedColumnViewModel(),
    );
  }
}
//   if (!GetIt.I.isRegistered<ProfileViewModel>()) {
//     instance.registerFactory<ProfileViewModel>(
//       () => ProfileViewModel(
//         instance<DashboardUseCase>(),
//       ),
//     );
//   }
//   if(!GetIt.I.isRegistered<DashboardViewModel>()){
//     instance.registerFactory<DashboardViewModel>(
//       () => DashboardViewModel(
//         instance<DashboardUseCase>(),
//       ),
//     );
//   }
// }

// initProfileDetailsModule() {
//   if (!GetIt.I.isRegistered<UpdateProfileUseCase>()) {
//     instance.registerFactory<UpdateProfileUseCase>(
//       () => UpdateProfileUseCase(
//         instance<Repository>(),
//       ),
//     );
//     instance.registerFactory<ProfileDetailsViewModel>(
//       () => ProfileDetailsViewModel(
//         instance<UpdateProfileUseCase>(),
//         instance<DashboardUseCase>(),
//       ),
//     );
//   }
// }
// initHomeModule() {
//   if (!GetIt.I.isRegistered<HomeUseCase>()) {
//     instance.registerFactory<HomeUseCase>(
//         () => HomeUseCase(instance<Repository>()));
//     instance.registerFactory<HomeViewModel>(
//         () => HomeViewModel(instance<HomeUseCase>()));
//   }
// }

// initHomeModule() {
//   if (!GetIt.I.isRegistered<HomeUseCase>()) {
//     instance.registerFactory<HomeUseCase>(
//         () => HomeUseCase(instance<Repository>()));
//     instance.registerFactory<HomeViewModel>(
//         () => HomeViewModel(instance<HomeUseCase>()));
//   }
// }
//
// initSearchModule() {
//   if (!GetIt.I.isRegistered<SearchUseCase>()) {
//     instance.registerFactory<SearchUseCase>(
//         () => SearchUseCase(instance<Repository>()));
//     instance.registerFactory<SearchViewModel>(() => SearchViewModel());
//   }
// }
