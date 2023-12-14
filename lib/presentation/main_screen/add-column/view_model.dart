import 'dart:async';
import 'package:geolocator/geolocator.dart';

import 'package:reports/app/di.dart';
import 'package:reports/data/data_source/lacal_database.dart';
import 'package:reports/domain/repository/repository.dart';
import 'package:reports/domain/usecase/add_coulumn_usecase.dart';
import 'package:reports/presentation/base/base_view_model.dart';
import 'package:reports/presentation/common/freezed/freezed.dart';
import 'package:reports/presentation/common/state_render/state_render.dart';
import 'package:reports/presentation/common/state_render/state_renderer_imp.dart';
import 'package:intl/intl.dart';

class AddColumnViewModel extends AddColumnViewModelInput {
  final StreamController<String> _columnStreamController =
      StreamController<String>.broadcast();
  final StreamController<void> _allRightStreamController =
      StreamController<void>.broadcast();
  final StreamController<String?> _afterImageStreamController =
      StreamController<String?>.broadcast();
  final StreamController<String?> _innerImage1StreamController =
      StreamController<String?>.broadcast();
  final StreamController<String?> _innerImage2StreamController =
      StreamController<String?>.broadcast();
  final StreamController<String?> _beforeImageStreamController =
      StreamController<String?>.broadcast();
  final AddColumnUsecase _usecase = AddColumnUsecase(instance<Repository>());
  List<ImageDataHive> images = [
    ImageDataHive(path: "", date: "", late: "", long: ""),
    ImageDataHive(path: "", date: "", late: "", long: ""),
    ImageDataHive(path: "", date: "", late: "", long: ""),
    ImageDataHive(path: "", date: "", late: "", long: ""),
  ];

  @override
  void start() async {
    inputState.add(ContentState());
  }

  @override
  Sink get columnNameInput => _columnStreamController.sink;

  @override
  Stream<String> get columnNameOutput => _columnStreamController.stream;

  @override
  setColumnName(String name) {
    addColumnObject = addColumnObject.copyWith(columnName: name);
    _allRightStreamController.add(null);
  }

  @override
  Sink get allRightInput => _allRightStreamController.sink;

  @override
  Stream<bool> get allRightOutput =>
      _allRightStreamController.stream.map((event) => _areInputValid());

  @override
  Sink get afterImageInput => _afterImageStreamController.sink;

  @override
  Stream<String?> get afterImageOutput => _afterImageStreamController.stream;

  @override
  Sink get beforeImageInput => _beforeImageStreamController.sink;

  @override
  Stream<String?> get beforeImageOutput => _beforeImageStreamController.stream;

  @override
  Sink get innerImage1Input => _innerImage1StreamController.sink;

  @override
  Stream<String?> get innerImage1Output => _innerImage1StreamController.stream;

  @override
  Sink get innerImage2Input => _innerImage2StreamController.sink;

  @override
  Stream<String?> get innerImage2Output => _innerImage2StreamController.stream;
  AddColumnObject addColumnObject = AddColumnObject("", "", "", []);

  @override
  Future<void> getLocation() async {
    try {
      await checkLocationPermission();
      Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );
      addColumnObject = addColumnObject.copyWith(
        longitude: position.longitude.toString(),
        latitude: position.latitude.toString(),
      );

      _allRightStreamController.add(null);
      // inputState.add(ContentState());
      print("Latitude: ${position.latitude}, Longitude: ${position.longitude}");
    } catch (e) {
      print(e);
    }
  }

  Future<void> setImage(int index, String image) async {
    try {
      await checkLocationPermission();
      Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );
      DateTime now = DateTime.now();
      String date = DateFormat('yyyy/MM/d HH:mm').format(now);
      images[index] = ImageDataHive(
        path: image,
        date: date,
        long: position.longitude.toString(),
        late: position.latitude.toString(),
      );
      addColumnObject = addColumnObject.copyWith(image: images);
      _allRightStreamController.add(null);
    } catch (e) {}
  }

  @override
  void dispose() {
    _allRightStreamController.close();
    _beforeImageStreamController.close();
    _innerImage2StreamController.close();
    _innerImage1StreamController.close();
    _afterImageStreamController.close();
    _columnStreamController.close();
    super.dispose();
  }

  @override
  addToDatBase() async {
    (await _usecase.execute(
      AddColumnUsecaseInput(
        columnName: addColumnObject.columnName,
        images: addColumnObject.image,
        latitude: addColumnObject.latitude,
        longitude: addColumnObject.longitude,
      ),
    ))
        .fold((l) {
      inputState.add(
        ErrorState(
          stateRenderType: StateRenderType.popupErrorState,
          message: "فشل الحفظ",
        ),
      );
    }, (r) {
      print('000000000000000000 end 0000000000000000000000000');
      print(inputState.toString());
    });
    images = [
      ImageDataHive(path: "", date: "", late: "", long: ""),
      ImageDataHive(path: "", date: "", late: "", long: ""),
      ImageDataHive(path: "", date: "", late: "", long: ""),
      ImageDataHive(path: "", date: "", late: "", long: ""),
    ];
    _afterImageStreamController.sink.add(null);
    _innerImage1StreamController.sink.add(null);
    _innerImage2StreamController.sink.add(null);
    _beforeImageStreamController.sink.add(null);
    _allRightStreamController.add(null);
    addColumnObject = addColumnObject
        .copyWith(columnName: '', latitude: '', longitude: '', image: []);
  }

  bool _areInputValid() {
    print("=== column name ${addColumnObject.columnName.isNotEmpty}====");
    print("=== long ${addColumnObject.longitude.isNotEmpty}=====");
    print(
        "=== image  ${addColumnObject.image[0].path.isNotEmpty || addColumnObject.image[1].path.isNotEmpty || addColumnObject.image[2].path.isNotEmpty || addColumnObject.image[3].path.isNotEmpty} ======");
    return addColumnObject.columnName.isNotEmpty &&
        addColumnObject.longitude.isNotEmpty &&
        (addColumnObject.image[0].path.isNotEmpty ||
            addColumnObject.image[1].path.isNotEmpty ||
            addColumnObject.image[2].path.isNotEmpty ||
            addColumnObject.image[3].path.isNotEmpty);
  }
}

abstract class AddColumnViewModelInput extends AddColumnViewModelOutput {
  setColumnName(String name);

  getLocation();

  addToDatBase();

  Sink get columnNameInput;

  Sink get allRightInput;

  Sink get afterImageInput;

  Sink get innerImage1Input;

  Sink get innerImage2Input;

  Sink get beforeImageInput;
}

abstract class AddColumnViewModelOutput extends BaseViewModel {
  Stream<String> get columnNameOutput;

  Stream<bool> get allRightOutput;

  Stream<String?> get afterImageOutput;

  Stream<String?> get innerImage1Output;

  Stream<String?> get innerImage2Output;

  Stream<String?> get beforeImageOutput;
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
