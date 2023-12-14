import 'dart:async';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:reports/app/constant.dart';
import 'package:reports/data/data_source/lacal_database.dart';
import 'package:reports/presentation/base/base_view_model.dart';
import 'package:reports/presentation/common/state_render/state_renderer_imp.dart';


class FinishedColumnViewModel extends AddColumnViewModelInput {
  final StreamController<List<AddColumnModel>> dataController =
      StreamController<List<AddColumnModel>>.broadcast();
  final StreamController<void>_imageIsFullController =
  StreamController<void>.broadcast();
  final StreamController<String>_searchStreamController =
  StreamController<String>.broadcast();
  Box box = Hive.box<AddColumnModel>(Constant.mainBoxName);
  List<AddColumnModel> list = [];
  List<AddColumnModel> filteredList = [];
  int numOfImage =0;
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
    list= box.values.toList() as List<AddColumnModel>;
    filteredList= list;
    dataInput.add(filteredList);
    inputState.add(ContentState());
  }

  @override
  Sink<List<AddColumnModel>> get dataInput => dataController.sink;

  @override
  void dispose() {
    _searchStreamController.close();
    _imageIsFullController.close();
    dataController.close();
    super.dispose();
  }
  setImages(int i ){
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
    return numOfImage==4;
  }
  @override
  setSearch(String text) {
    if (text.isNotEmpty) {
      filteredList = list
          .where((column) => column.columnName.toLowerCase().contains(text.toLowerCase()))
          .toList();

    } else {
      filteredList = list;
    }
    print(filteredList);
    dataInput.add(filteredList);
  }

  @override
  Sink get searchInput => _searchStreamController.sink;

  @override
  Stream<String> get searchOutput => _searchStreamController.stream;

}

abstract class AddColumnViewModelInput extends AddColumnViewModelOutput {
  endProcess ();
  setSearch(String text );

  Sink get imageIsFullInput;
  Sink<List<AddColumnModel>> get dataInput;
  Sink get searchInput;
}

abstract class AddColumnViewModelOutput extends BaseViewModel {
  Stream<List<AddColumnModel>> get dataOutput;
  Stream<String> get searchOutput;
  Stream<bool> get imageIsFullOutput;
}
