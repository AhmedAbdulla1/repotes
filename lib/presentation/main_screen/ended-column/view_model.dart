import 'package:hive_flutter/adapters.dart';
import 'package:reports/app/constant.dart';
import 'package:reports/data/data_source/lacal_database.dart';
import 'package:reports/presentation/base/base_view_model.dart';

class EndedColumnViewModel extends EndedColumnViewModelInput {
  // Box box =Hive.box<AddColumnModel>(Constant.pdfName);
  @override
  void start() {
    // TODO: implement start
  }
}
abstract class EndedColumnViewModelInput extends EndedColumnViewModelOutput{}
abstract class EndedColumnViewModelOutput extends BaseViewModel{}