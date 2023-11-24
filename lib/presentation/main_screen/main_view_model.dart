

import 'dart:async';

class MainViewModel extends MainViewModelInput {

  StreamController<int> indexStreamController = StreamController<int>.broadcast();

  @override

  Sink<int> get inputIndex => indexStreamController.sink;

  @override

  Stream<int> get outputIndex => indexStreamController.stream;

  @override
  setIndex(int  index) {
    inputIndex.add(index);
  }


}
abstract class  MainViewModelInput extends MainViewModelOutput{
  Sink<int> get inputIndex ;
  setIndex (int index);
}
abstract class MainViewModelOutput{
  Stream<int> get  outputIndex;
}