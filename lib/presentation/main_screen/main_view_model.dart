import 'dart:async';

import 'package:reports/app/app_prefs.dart';
import 'package:reports/app/di.dart';
import 'package:reports/domain/usecase/login_usecase.dart';
import 'package:reports/presentation/base/base_view_model.dart';
import 'package:reports/presentation/common/state_render/state_render.dart';
import 'package:reports/presentation/common/state_render/state_renderer_imp.dart';

class MainViewModel extends MainViewModelInput {
  StreamController<int> indexStreamController =
      StreamController<int>.broadcast();
  final AppPreferences _appPreferences = instance<AppPreferences>();
  final LoginUseCase _usecase;

  MainViewModel(this._usecase);

  @override
  Sink<int> get inputIndex => indexStreamController.sink;

  @override
  Stream<int> get outputIndex => indexStreamController.stream;

  @override
  setIndex(int index) {
    inputIndex.add(index);
  }

  @override
  void start() {
    inputState.add(
        LoadingState(stateRenderType: StateRenderType.fullScreenLoadingState));
    chekUser();
  }

  chekUser() async {
    (await _usecase.execute(
      LoginUseCaseInput(
        email: _appPreferences.getToken(),
        password: _appPreferences.getPassword(),
      ),
    ))
        .fold((l) {
          print(l.message);
      inputState.add(ErrorState(
          stateRenderType: StateRenderType.fullScreenErrorState,
          message: l.message));
    }, (r) {inputState.add(ContentState());});
  }
}

abstract class MainViewModelInput extends MainViewModelOutput {
  Sink<int> get inputIndex;

  setIndex(int index);
}

abstract class MainViewModelOutput extends BaseViewModel {
  Stream<int> get outputIndex;
}
