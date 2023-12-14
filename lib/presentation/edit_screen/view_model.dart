import 'dart:async';
import 'package:geolocator/geolocator.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:intl/intl.dart';
import 'package:reports/app/constant.dart';
import 'package:reports/data/data_source/lacal_database.dart';
import 'package:reports/presentation/base/base_view_model.dart';
import 'package:reports/presentation/common/freezed/freezed.dart';
import 'package:reports/presentation/common/state_render/state_renderer_imp.dart';
import 'package:reports/presentation/main_screen/add-column/view_model.dart';

class EditColumnViewModel extends EditColumnViewModelInput {
  final StreamController<String> _columnStreamController =
      StreamController<String>.broadcast();
  final StreamController<String> _afterImageStreamController =
      StreamController<String>.broadcast();
  final StreamController<String> _innerImage1StreamController =
      StreamController<String>.broadcast();
  final StreamController<String> _innerImage2StreamController =
      StreamController<String>.broadcast();
  final StreamController<String> _beforeImageStreamController =
      StreamController<String>.broadcast();
  // final StreamController<List<AddColumnModel>> _dataController =
  //     StreamController<List<AddColumnModel>>();

  Box box = Hive.box<AddColumnModel>(Constant.mainBoxName);
  AddColumnObject addColumnObject = AddColumnObject("", "", "", []);
  List<ImageDataHive> images = [
    ImageDataHive(
      path: "",
      date: "",
      long: "",
      late: "",
    ),
    ImageDataHive(
      path: "",
      date: "",
      long: "",
      late: "",
    ),
    ImageDataHive(
      path: "",
      date: "",
      long: "",
      late: "",
    ),
    ImageDataHive(
      path: "",
      date: "",
      long: "",
      late: "",
    ),
  ];

  @override
  void start() {
    inputState.add(ContentState());

    // List<AddColumnModel> list = box.values.toList() as List<AddColumnModel>;
    // _dataController.add(list);
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
      // _allRightStreamController.add(null);
    } catch (e) {}

    // _allRightStreamController.add(null);
    print(addColumnObject.image);
  }

  List<ImageDataHive> list = [];

  setData(AddColumnModel addColumnModel) {
    print("Start");
    list = List.from(addColumnModel.images);
    images = list;
    print(
        "${list[0].path} ,${list[1].path} ,${list[2].path} ,${list[3].path} ");
    addColumnObject = addColumnObject.copyWith(
      columnName: addColumnModel.columnName,
      latitude: addColumnModel.latitude,
      longitude: addColumnModel.longitude,
      image: list,
    );
  }

  save(int index) {
    print(index);
    print(
        "${addColumnObject.image[0].path},${addColumnObject.image[1].path}, ${addColumnObject.image[2].path},${addColumnObject.image[3].path}");
    print(addColumnObject.columnName);
    box.putAt(
        index,
        AddColumnModel(
          columnName: addColumnObject.columnName,
          images: addColumnObject.image,
          latitude: addColumnObject.latitude,
          longitude: addColumnObject.longitude,
        ));
  }

  @override
  Sink get columnNameInput => _columnStreamController.sink;

  @override
  Stream<String> get columnNameOutput => _columnStreamController.stream;

  @override
  setColumnName(String name) {
    addColumnObject = addColumnObject.copyWith(columnName: name);
  }

  @override
  // TODO: implement afterImageInput
  Sink get afterImageInput => _afterImageStreamController.sink;

  @override
  // TODO: implement afterImageOutput
  Stream<String> get afterImageOutput => _afterImageStreamController.stream;

  @override
  // TODO: implement beforeImageInput
  Sink get beforeImageInput => _beforeImageStreamController.sink;

  @override
  // TODO: implement beforeImageOutput
  Stream<String> get beforeImageOutput => _beforeImageStreamController.stream;

  @override
  // TODO: implement innerImage1Input
  Sink<String> get innerImage1Input => _innerImage1StreamController.sink;

  @override
  // TODO: implement innerImage1Output
  Stream<String> get innerImage1Output => _innerImage1StreamController.stream;

  @override
  // TODO: implement innerImage1Input
  Sink<String> get innerImage2Input => _innerImage2StreamController.sink;

  @override
  // TODO: implement innerImage2Output
  Stream<String> get innerImage2Output => _innerImage2StreamController.stream;
}

abstract class EditColumnViewModelInput extends EditColumnViewModelOutput {
  setColumnName(String name);

  Sink get columnNameInput;

  Sink get afterImageInput;

  Sink<String> get innerImage1Input;

  Sink<String> get innerImage2Input;

  Sink get beforeImageInput;
}

abstract class EditColumnViewModelOutput extends BaseViewModel {
  Stream<String> get columnNameOutput;

  Stream<String> get afterImageOutput;

  Stream<String> get innerImage1Output;

  Stream<String> get innerImage2Output;

  Stream<String> get beforeImageOutput;
}
