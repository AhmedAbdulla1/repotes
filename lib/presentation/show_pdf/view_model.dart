import 'package:hive_flutter/hive_flutter.dart';
import 'package:flutter/material.dart';
import 'package:reports/app/constant.dart';
import 'package:reports/data/data_source/lacal_database.dart';
import 'package:reports/domain/usecase/upload_file_usecase.dart';
import 'package:reports/presentation/base/base_view_model.dart';
import 'package:reports/presentation/common/state_render/state_render.dart';
import 'package:reports/presentation/common/state_render/state_renderer_imp.dart';

class ShowPdfViewModel extends ShowPdfViewModelInput {
  final UploadFileUsecase _usecase = UploadFileUsecase();
  Box box = Hive.box<AddColumnModel>(Constant.mainBoxName);
  Box boxPdf = Hive.box<String>(Constant.pdfName);

  @override
  void start() {
    inputState.add(ContentState());
  }

  @override
  Future<bool> uploadPdf(String path, BuildContext context, int index) async {
    bool state = false;
    inputState
        .add(LoadingState(stateRenderType: StateRenderType.popupLoadingState));
    (await _usecase.execute(path)).fold((failure) {
      inputState.add(
        ErrorState(
          stateRenderType: StateRenderType.popupErrorState,
          message: failure.message,
        ),
      );
    }, (r) {
      boxPdf.add(path);
      box.deleteAt(index);
      Navigator.pop(context);
      print('after nav');
      state = true;
    });
    return state;
  }
}

abstract class ShowPdfViewModelInput extends ShowPdfViewModelOutput {
  uploadPdf(String path, BuildContext context, int index);
}

abstract class ShowPdfViewModelOutput extends BaseViewModel {}
