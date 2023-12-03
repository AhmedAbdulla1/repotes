import 'dart:async';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:reports/app/constant.dart';
import 'package:reports/data/data_source/lacal_database.dart';
import 'package:reports/presentation/base/base_view_model.dart';
import 'package:reports/presentation/common/state_render/state_render.dart';
import 'package:reports/presentation/common/state_render/state_renderer_imp.dart';

class FinishedColumnViewModel extends AddColumnViewModelInput {
  final StreamController<List<AddColumnModel>> dataController =
      StreamController<List<AddColumnModel>>.broadcast();
  Box box = Hive.box<AddColumnModel>(Constant.mainBoxName);

  @override
  void start() {
    inputState
        .add(LoadingState(stateRenderType: StateRenderType.popupLoadingState));
    getData();
    inputState.add(ContentState());
  }

  @override
  deleteDAta(int index) {
    box.deleteAt(index);
  }

  @override
  endProcess() {
    // TODO: implement endProcess
    throw UnimplementedError();
  }

  @override
  getData() {
    inputState
        .add(LoadingState(stateRenderType: StateRenderType.popupLoadingState));
    List<AddColumnModel> list = box.values.toList() as List<AddColumnModel>;
    dataController.add(list);
    print('list of column  $list');
  }

  @override
  Sink<List<AddColumnModel>> get dataInput => dataController.sink;

  @override
  void dispose() {
    dataController.close();
    super.dispose();
  }

  @override
  Stream<List<AddColumnModel>> get dataOutput => dataController.stream;
}

abstract class AddColumnViewModelInput extends AddColumnViewModelOutput {
  endProcess();

  deleteDAta(int index);

  getData();

  Sink<List<AddColumnModel>> get dataInput;
}

abstract class AddColumnViewModelOutput extends BaseViewModel {
  Stream<List<AddColumnModel>> get dataOutput;
}
