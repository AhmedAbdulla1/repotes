import 'dart:io';
import 'dart:async';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:reports/app/constant.dart';
import 'package:reports/data/data_source/lacal_database.dart';
import 'package:reports/presentation/base/base_view_model.dart';
import 'package:reports/presentation/common/freezed/freezed.dart';
import 'package:reports/presentation/common/state_render/state_renderer_imp.dart';
import 'package:reports/presentation/resources/string_manager.dart';

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
  final StreamController<List<AddColumnModel>> _dataController =
      StreamController<List<AddColumnModel>>();

  Box box = Hive.box<AddColumnModel>(Constant.mainBoxName);
  AddColumnObject addColumnObject = AddColumnObject("", "", "", []);
  List<String> images = [
    "",
    "",
    "",
    "",
  ];
  @override
  void start() {
    inputState.add(ContentState());

    // List<AddColumnModel> list = box.values.toList() as List<AddColumnModel>;
    // _dataController.add(list);
  }
  setImage(int index,String image) {
    print(index);
    print(image);
    print(list);
    list[index] = image ?? "";
    addColumnObject = addColumnObject.copyWith(image: list);
    print(addColumnObject.image);
    print(list);
  }
  List<String> list=[];
  setData(AddColumnModel addColumnModel) {
    print("Start");
    list= List.from(addColumnModel.images);
    addColumnObject = addColumnObject.copyWith(
        columnName: addColumnModel.columnName,
        latitude: addColumnModel.latitude,
        longitude: addColumnModel.longitude,
        image: list,
    );

    print('ahmed');
    print(addColumnObject.image);
  }

  save(int index) {
    print(index);
    print(addColumnObject.image);
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
