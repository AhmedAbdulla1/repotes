import 'package:reports/app/app_prefs.dart';
import 'package:reports/app/di.dart';
import 'package:reports/presentation/common/reusable/custom_button.dart';
import 'package:reports/presentation/common/reusable/custom_text_form_field.dart';
import 'package:reports/presentation/common/state_render/state_renderer_imp.dart';
import 'package:reports/presentation/login_screen/view_model/login_view_model.dart';
import 'package:reports/presentation/resources/assets_manager.dart';
import 'package:reports/presentation/resources/color_manager.dart';
import 'package:reports/presentation/resources/font_manager.dart';
import 'package:reports/presentation/resources/routes_manager.dart';
import 'package:reports/presentation/resources/string_manager.dart';
import 'package:reports/presentation/resources/values_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class LoginView extends StatefulWidget {
  const LoginView({Key? key}) : super(key: key);

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final AppPreferences _appPreferences = instance<AppPreferences>();
  final LoginViewModel _loginViewModel = instance<LoginViewModel>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final GlobalKey _globalKey = GlobalKey<FormState>();

  bool visible = true;

  void _bind() {
    _loginViewModel.start();
    _emailController.addListener(
      () => _loginViewModel.setEmail(
        _emailController.text,
      ),
    );
    _passwordController.addListener(
      () => _loginViewModel.setPassword(
        _passwordController.text,
      ),
    );
    _loginViewModel.isUserLoginSuccessfullyStreamController.stream
        .listen((isLoading) {
      if (isLoading) {
        SchedulerBinding.instance.addPostFrameCallback((_) {
          _appPreferences.setPressKeyLoginScreen();
          debugPrint(_appPreferences.getToken());
          Navigator.pushReplacementNamed(context, Routes.mainScreen);
        });
      }
    });
  }

  @override
  void initState() {
    _bind();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorManager.white,
      body: Stack(fit: StackFit.expand, children: [
        Image.asset(
          ImageAssets.background,
          fit: BoxFit.cover,
        ),
        StreamBuilder<StateFlow>(
          stream: _loginViewModel.outputState,
          builder: (context, snapshot) =>
              snapshot.data?.getScreenWidget(
                context,
                _getContent(),
                () {
                  _loginViewModel.inputState.add(ContentState());
                },
              ) ??
              _getContent(),
        ),
      ]),
    );
  }

  Widget _getContent() {
    return SizedBox(
      child: Padding(
        padding: EdgeInsets.all(AppPadding.p16.w),
        child: Form(
          key: _globalKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: AppSize.s35.h,
              ),

              Text(
                AppStrings.loginTitle,
                style: Theme.of(context).textTheme.headlineLarge,
              ),

              SizedBox(
                height: AppSize.s35.h,
              ),
              SizedBox(
                height: AppSize.s35.h,
              ),
              customTextFormField(
                stream: _loginViewModel.outEmailIsValid,
                textEditingController: _emailController,
                hintText: AppStrings.email,
              ),
              const SizedBox(height: AppSize.s16),
              customPasswordFormField(
                stream1: _loginViewModel.outPasswordIsValid,
                stream2: _loginViewModel.outPasswordIsVisible,
                textEditingController: _passwordController,
                onPressed: () {
                  visible = !visible;
                  _loginViewModel.setVisibility(visible);
                },
              ),
              const SizedBox(height: AppSize.s20),
              customElevatedButton(
                stream: _loginViewModel.outAreAllInputValid,
                onPressed: () {
                  // _loginViewModel.login();
                  Navigator.pushReplacementNamed(context, Routes.mainScreen);
                },
                text: AppStrings.login,
              ),
              //forgot password
            ],
          ),
        ),
      ),
    );
  }
}
