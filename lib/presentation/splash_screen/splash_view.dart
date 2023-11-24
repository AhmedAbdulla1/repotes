import 'dart:async';

import 'package:flutter/material.dart';
import 'package:reports/presentation/resources/font_manager.dart';

import '../../app/app_prefs.dart';
import '../../app/di.dart';
import '../resources/constant.dart';
import '../resources/routes_manager.dart';
import '../resources/string_manager.dart';
import 'package:reports/presentation/resources/assets_manager.dart';

class SplashView extends StatefulWidget {
  const SplashView({Key? key}) : super(key: key);

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  final AppPreferences _appPreferences = instance<AppPreferences>();
  Timer? _timer;

  _startTimer() {
    _timer = Timer(
      const Duration(
        seconds: AppConstant.timer,
      ),
      () async {
        if (await _appPreferences.isPressKeyLoginScreen()) {
          Navigator.pushReplacementNamed(context, Routes.mainScreen);
        } else {
          Navigator.pushReplacementNamed(context, Routes.mainScreen);
        }
      },
    );
  }

  @override
  void initState() {
    super.initState();
    _startTimer();
  }

  @override
  void dispose() {
    super.dispose();
    _timer!.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          Image.asset(ImageAssets.background,fit: BoxFit.cover,),
          Center(

          child: Text(
            AppStrings.splashTitle,
            style: TextStyle(
              color:Colors.black,
              fontFamily: FontConstants.arFontFamily,
              fontSize: FontSize.s48
            ),
          ),
        ),
        ]
      ),
    );
  }
}
