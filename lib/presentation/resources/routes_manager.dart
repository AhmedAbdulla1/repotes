import 'package:reports/app/di.dart';
import 'package:reports/presentation/edit_screen/view.dart';

import 'package:reports/presentation/login_screen/view/login_view.dart';


import 'package:reports/presentation/resources/string_manager.dart';
import 'package:reports/presentation/splash_screen/splash_view.dart';
import 'package:flutter/material.dart';

import '../main_screen/main_view.dart';

class Routes {
  static const String splashScreen = "/";
  static const String loginScreen = "/login";
  static const String mainScreen = "/main";
  static const String editScreen = '/editScreen';

  static const String profileDetailsScreen = "/profileDetails";
  static const String settingScreen = "/setting";
  static const String wifiSetupScreen = "/wifiSetup";
  static const String exercisesScreen = "/exercises";
  static const String inTrainingScreen ='/inTraining';
}

//
class RouteGenerator {
  static Route<dynamic> getRoute(RouteSettings settings) {
    switch (settings.name) {
      case Routes.splashScreen:
        return MaterialPageRoute(builder: (_) => const SplashView());
      case Routes.loginScreen:
        return MaterialPageRoute(
          builder: (_) {
            initLoginModule();
            return const LoginView();
          },
        );
      case Routes.editScreen :
        return MaterialPageRoute(builder: (_){
          return const EditColumnView();
        });
      case Routes.mainScreen:
        return MaterialPageRoute(builder: (_) {
          initMainModule();
          return  const MainView();
        });
      // case Routes.profileDetailsScreen:
      //   return MaterialPageRoute(builder: (_) {
      //     initProfileDetailsModule();
      //     return const ProfileDetailsView();
      //   });
      // case Routes.wifiSetupScreen:
      //   return MaterialPageRoute(builder: (_) {
      //     return FlutterWifiIoT();
      //   });
      // case Routes.exercisesScreen:
      //   return MaterialPageRoute(
      //     builder: (_) => const ExercisesView(),
      //   );
      // case Routes.settingScreen:
      //   return MaterialPageRoute(builder: (_) => const SettingView());
      // case Routes.storeDetailsScreen:
      //   return MaterialPageRoute(builder: (_) => const StoreDetailsView());
      default:
        return unDefinedRoute();
    }
  }

  static Route unDefinedRoute() {
    return MaterialPageRoute(
      builder: (_) => Scaffold(
        appBar: AppBar(
          title: const Text(
            AppStrings.noRouteFound,
          ),
        ),
        body: const Center(
          child: Text(AppStrings.noRouteFound),
        ),
      ),
    );
  }
}
