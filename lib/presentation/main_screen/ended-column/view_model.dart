import 'package:reports/domain/usecase/update_status.dart';
import 'package:reports/presentation/base/base_view_model.dart';
import 'package:reports/presentation/common/state_render/state_render.dart';
import 'package:reports/presentation/common/state_render/state_renderer_imp.dart';

class EndedColumnViewModel extends EndedColumnViewModelInput {
  // Box box =Hive.box<AddColumnModel>(Constant.pdfName);
  final UpdateStatusUsecase _usecase =UpdateStatusUsecase();
  @override
  void start() {
    inputState.add(ContentState());
  }
  @override
  Future<bool> updateStatus(String filePath, String status) async{
    bool state=false;
    (await _usecase.execute(UpdateStatusInput(path: filePath, status: status))).fold((l) {
      inputState.add(ErrorState(stateRenderType: StateRenderType.popupErrorState, message: l.message));
    }, (r)  {
      inputState.add(ContentState());
      state=true;
    });
    return state ;
  }
}
abstract class EndedColumnViewModelInput extends EndedColumnViewModelOutput{
  updateStatus(String filePath, String status);
}
abstract class EndedColumnViewModelOutput extends BaseViewModel{}