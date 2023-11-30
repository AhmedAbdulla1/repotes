import 'dart:io';
import 'dart:async';
import 'package:geolocator/geolocator.dart';
import 'package:reports/presentation/base/base_view_model.dart';
import 'package:reports/presentation/common/state_render/state_render.dart';
import 'package:reports/presentation/common/state_render/state_renderer_imp.dart';
import 'package:rxdart/rxdart.dart';

class AddColumnViewModel extends AddColumnViewModelInput {
  final StreamController<String> _columnStreamController =
      StreamController<String>.broadcast();
  final StreamController<bool> _allRightStreamController =
      StreamController<bool>.broadcast();
  final StreamController<File> _afterImageStreamController =
      StreamController<File>.broadcast();
  final StreamController<File> _innerImage1StreamController =
      StreamController<File>.broadcast();
  final StreamController<File> _innerImage2StreamController =
      StreamController<File>.broadcast();
  final StreamController<File> _beforeImageStreamController =
      StreamController<File>.broadcast();

  @override
  void start() {
    inputState.add(ContentState());
  }

  @override
  Sink get columnNameInput => _columnStreamController.sink;

  @override
  Stream<String> get columnNameOutput => _columnStreamController.stream;

  @override
  setColumnName(String name) {
    // TODO: implement setColumnName
    throw UnimplementedError();
  }

  @override
  // TODO: implement allRightInput
  Sink get allRightInput => _allRightStreamController.sink;

  @override
  // TODO: implement allRightOutput
  Stream<bool> get allRightOutput => _allRightStreamController.stream;

  @override
  // TODO: implement afterImageInput
  Sink get afterImageInput => _afterImageStreamController.sink;

  @override
  // TODO: implement afterImageOutput
  Stream<File> get afterImageOutput => _afterImageStreamController.stream;

  @override
  // TODO: implement beforeImageInput
  Sink get beforeImageInput => _beforeImageStreamController.sink;

  @override
  // TODO: implement beforeImageOutput
  Stream<File> get beforeImageOutput => _beforeImageStreamController.stream;

  @override
  // TODO: implement innerImage1Input
  Sink<File> get innerImage1Input => throw _innerImage1StreamController.sink;

  @override
  // TODO: implement innerImage1Output
  Stream<File> get innerImage1Output => _innerImage1StreamController.stream;

  @override
  // TODO: implement innerImage1Input
  Sink<File> get innerImage2Input => throw _innerImage1StreamController.sink;

  @override
  // TODO: implement innerImage2Output
  Stream<File> get innerImage2Output => _innerImage2StreamController.stream;

  @override
  getLocation() async{
      await checkLocationPermission();
      inputState.add(LoadingState(stateRenderType: StateRenderType.popupLoadingState));
      try {
        Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high,
        );

        inputState.add(ContentState());
         String locationMessage =
          "Latitude: ${position.latitude}, Longitude: ${position.longitude}";
          print(locationMessage);
      } catch (e) {
        print(e);
      }
  }
}

abstract class AddColumnViewModelInput extends AddColumnViewModelOutput {
  setColumnName(String name);
  getLocation();
  Sink get columnNameInput;

  Sink get allRightInput;

  Sink get afterImageInput;

  Sink<File> get innerImage1Input;

  Sink<File> get innerImage2Input;

  Sink get beforeImageInput;
}

abstract class AddColumnViewModelOutput extends BaseViewModel {
  Stream<String> get columnNameOutput;

  Stream<bool> get allRightOutput;

  Stream<File> get afterImageOutput;

  Stream<File> get innerImage1Output;

  Stream<File> get innerImage2Output;

  Stream<File> get beforeImageOutput;
}
Future<void> checkLocationPermission() async {
  LocationPermission permission = await Geolocator.checkPermission();

  if (permission == LocationPermission.denied) {
    // Location permission is denied, request permission
    permission = await Geolocator.requestPermission();

    if (permission == LocationPermission.denied) {
      // Permission is still denied, show a dialog to prompt the user to enable it
      await Geolocator
          .openLocationSettings(); // Opens the app settings where the user can manually enable permissions
    }
  } else if (permission == LocationPermission.deniedForever) {
    // Permission is permanently denied, show a dialog to prompt the user to enable it
    await Geolocator
        .openLocationSettings(); // Opens the app settings where the user can manually enable permissions
  }
}