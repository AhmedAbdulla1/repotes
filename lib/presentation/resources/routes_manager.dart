import 'package:reports/app/di.dart';

import 'package:reports/presentation/login_screen/view/login_view.dart';


import 'package:reports/presentation/resources/string_manager.dart';
import 'package:reports/presentation/splash_screen/splash_view.dart';
import 'package:flutter/material.dart';

import '../main_screen/main_view.dart';

class Routes {
  static const String splashScreen = "/";
  static const String onBoardingScreen = "/onBoarding";
  static const String loginScreen = "/login";
  static const String registerScreen = "/register";
  static const String privacyScreen = "/privacy";
  static const String recoverPasswordScreen = "/recoverPassword";
  static const String verifyCodeScreen = "/verifyCodeScreen";
  static const String changePasswordScreen = "/changePasswordScreen";
  static const String mainScreen = "/main";
  static const String searchScreen = '/searchScreen';
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

      // case Routes.recoverPasswordScreen:
      //   return MaterialPageRoute(
      //     builder: (_) {
      //       initRecoverPasswordModule();
      //       return const RecoverPasswordView();
      //     },
      //   );
      // case Routes.verifyCodeScreen:
      //   return MaterialPageRoute(
      //     builder: (_) {
      //       initVerifyCodeModule();
      //       return const VerifyCodeView();
      //     },
      //   );
      // case Routes.inTrainingScreen:
      //   return MaterialPageRoute(
      //     builder: (_) {
      //       return const TrainingViewBar();
      //     },
      //   );
      // // case Routes.changePasswordScreen:
      // //   return MaterialPageRoute(
      // //     builder: (_) {
      // //       initChangePasswordModule();
      // //       return const ChangePasswordView();
      // //     },
      // //   );
      case Routes.mainScreen:
        return MaterialPageRoute(builder: (_) {
          initMainModule();
          return  MainView();
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
