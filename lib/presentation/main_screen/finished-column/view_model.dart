import 'dart:async';
import 'dart:ffi';
import 'dart:io';
import 'package:flutter/services.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:reports/app/constant.dart';
import 'package:reports/data/data_source/lacal_database.dart';
import 'package:reports/presentation/base/base_view_model.dart';
import 'package:reports/presentation/common/state_render/state_render.dart';
import 'package:reports/presentation/common/state_render/state_renderer_imp.dart';


class FinishedColumnViewModel extends AddColumnViewModelInput {
  final StreamController<List<AddColumnModel>> dataController =
      StreamController<List<AddColumnModel>>.broadcast();
  final StreamController<void>_imageIsFullController =
  StreamController<void>.broadcast();
  Box box = Hive.box<AddColumnModel>(Constant.mainBoxName);

  @override
  void start() {
    getData();
  }


  @override
  endProcess() {
    // TODO: implement endProcess
    throw UnimplementedError();
  }

  getData() {

    List<AddColumnModel> list = box.values.toList() as List<AddColumnModel>;
    inputState.add(ContentState());

  }

  @override
  Sink<List<AddColumnModel>> get dataInput => dataController.sink;

  @override
  void dispose() {

    _imageIsFullController.close();
    dataController.close();
    super.dispose();
  }
  int numOfImage =0;
  setImages(int i ){
    // print(i);
    numOfImage=i;
    i== 4 ?imageIsFullInput.add(true):imageIsFullInput.add(false);
  }
  @override
  Stream<List<AddColumnModel>> get dataOutput => dataController.stream;

  @override
  Sink get imageIsFullInput => _imageIsFullController.sink;

  @override
  Stream<bool> get imageIsFullOutput => _imageIsFullController.stream.map((event) => _isInputValid());
  bool _isInputValid(){
    print("isValid");
    print(numOfImage);
    return numOfImage==4;
  }

}

abstract class AddColumnViewModelInput extends AddColumnViewModelOutput {
  endProcess();

  Sink get imageIsFullInput;
  Sink<List<AddColumnModel>> get dataInput;
}

abstract class AddColumnViewModelOutput extends BaseViewModel {
  Stream<List<AddColumnModel>> get dataOutput;
  Stream<bool> get imageIsFullOutput;
}
