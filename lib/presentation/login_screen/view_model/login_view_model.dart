import 'dart:async';

import 'package:reports/app/di.dart';
import 'package:reports/domain/usecase/login_usecase.dart';
import 'package:reports/presentation/base/base_view_model.dart';
import 'package:reports/presentation/common/freezed/freezed.dart';
import 'package:reports/presentation/common/state_render/state_render.dart';
import 'package:reports/presentation/common/state_render/state_renderer_imp.dart';
import 'package:reports/presentation/resources/string_manager.dart';

import '../../../app/app_prefs.dart';

class LoginViewModel extends LoginViewModelOutput {
  final AppPreferences _appPreferences = instance<AppPreferences>();
  final StreamController _emailController =
      StreamController<String>.broadcast();
  final StreamController _passwordController =
      StreamController<String>.broadcast();
  final StreamController _visibilityController =
      StreamController<bool>.broadcast();
  final StreamController _areInputValidController =
      StreamController<void>.broadcast();
  final StreamController<bool> isUserLoginSuccessfullyStreamController =
      StreamController.broadcast();
  LoginObject _loginObject = LoginObject('', '');
  final LoginUseCase _loginUseCase;

  LoginViewModel(this._loginUseCase);

  bool visible = false;

  @override
  void start() {
    inputState.add(ContentState());
  }

  @override
  Sink get inputAreAllInputValid => _areInputValidController.sink;

  @override
  Sink get inputEmailValid => _emailController.sink;

  @override
  Sink get inputPassword => _passwordController.sink;

  @override
  Sink get inputPasswordVisible => _visibilityController.sink;

  @override
  Stream<bool> get outAreAllInputValid =>
      _areInputValidController.stream.map((_) => _areInputValid());

  @override
  Stream<String?> get outEmailIsValid =>
      _emailController.stream.map((email) => _emailOutError(email));

  @override
  Stream<String?> get outPasswordIsValid =>
      _passwordController.stream.map((password) => _passwordOutError(password));

  @override
  Stream<bool> get outPasswordIsVisible =>
      _visibilityController.stream.map((visible) => visible);

  @override
  login() async {
    inputState.add(
      LoadingState(
        stateRenderType: StateRenderType.popupLoadingState,
      ),
    );
    (await _loginUseCase.execute(
      LoginUseCaseInput(
        email: _loginObject.email,
        password: _loginObject.password,
      ),
    ))
        .fold((failure) {
      inputState.add(
        ErrorState(
          stateRenderType: StateRenderType.popupErrorState,
          message: failure.message,
        ),
      );
    }, (data) async {
      await _appPreferences.setToken(data);
      inputState.add(
        ContentState(),
      );
      isUserLoginSuccessfullyStreamController.add(true);
    });
  }

  @override
  setEmail(String email) {
    _emailController.add(email);
    if (email.isNotEmpty) {
      _loginObject = _loginObject.copyWith(
        email: email,
      );
    } else {
      _loginObject = _loginObject.copyWith(
        email: "",
      );
    }
    _areInputValidController.add(null);
  }

  @override
  setPassword(String password) {
    _passwordController.add(password);
    if (password.isNotEmpty) {
      _loginObject = _loginObject.copyWith(
        password: password,
      );
    } else {
      _loginObject = _loginObject.copyWith(
        password: "",
      );
    }
    _areInputValidController.add(null);
  }

  @override
  setVisibility(bool visible) {
    _visibilityController.add(visible);
  }

  String? _emailOutError(String email) {
    if (email.isEmpty) {
      return AppStrings.emailError;
    } else {
      return null;
    }
  }

  bool _emailIsValid(String email) {
    return email.isNotEmpty;

  }

  String? _passwordOutError(String password) {
    if (password.isEmpty) {
      return AppStrings.passwordError;
    }
    return null;
  }

  bool _areInputValid() {
    return _emailIsValid(_loginObject.email) &&
        _loginObject.password.isNotEmpty;
  }
}

abstract class LoginViewModelInput extends BaseViewModel {
  setEmail(String email);

  setPassword(String password);

  setVisibility(bool visible);

  login();

  Sink get inputEmailValid;

  Sink get inputPassword;

  Sink get inputPasswordVisible;

  Sink get inputAreAllInputValid;
}

abstract class LoginViewModelOutput extends LoginViewModelInput {
  Stream<String?> get outEmailIsValid;

  Stream<String?> get outPasswordIsValid;

  Stream<bool> get outPasswordIsVisible;

  Stream<bool> get outAreAllInputValid;
}
