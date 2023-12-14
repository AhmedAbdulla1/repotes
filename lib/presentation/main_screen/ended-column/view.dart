import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import 'package:reports/app/constant.dart';

import 'package:reports/presentation/common/reusable/custom_button.dart';
import 'package:reports/presentation/common/state_render/state_renderer_imp.dart';
import 'package:reports/presentation/main_screen/ended-column/view_model.dart';
import 'package:reports/presentation/resources/color_manager.dart';
import 'package:reports/presentation/resources/font_manager.dart';
import 'package:reports/presentation/resources/values_manager.dart';
import 'package:reports/presentation/show_pdf/view.dart';

class EndedColumnView extends StatefulWidget {
  const EndedColumnView({Key? key}) : super(key: key);

  @override
  State<EndedColumnView> createState() => _EndedColumnViewState();
}

class _EndedColumnViewState extends State<EndedColumnView> {
  // final EndedColumnViewModel _viewModel = EndedColumnViewModel();
  final Box box = Hive.box<String>(Constant.pdfName);
  late List<String> allData;
  final EndedColumnViewModel _viewModel = EndedColumnViewModel();

  @override
  void initState() {
    allData = box.values.toList() as List<String>;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<StateFlow>(
      stream: _viewModel.outputState,
      builder: (context, snapshot) =>
          snapshot.data?.getScreenWidget(context, _getContent(), () {
            _viewModel.inputState.add(ContentState());

          }) ??
          _getContent(),
    );
  }

  Widget _getContent() {
    print(allData.length);
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: customElevatedButtonWithoutStream(
            height: AppSize.s65,
            onPressed: () {
              setState(() {
                allData = box.values.toList() as List<String>;
              });
            },
            child: Text(
              "تحديث",
              style: TextStyle(
                  color: Colors.white,
                  fontSize: FontSize.s24,
                  fontWeight: FontWeight.bold),
            ),
          ),
        ),
        Expanded(
          child: allData.isNotEmpty
              ? ListView.separated(
                  separatorBuilder: (context, index) => SizedBox(
                    height: 20.h,
                  ),
                  itemCount: allData.length,
                  padding: EdgeInsets.all(
                    AppPadding.p16.w,
                  ),
                  itemBuilder: (context, index) =>
                      _customItem(context, index, allData[index]),
                )
              : Center(
                  child: Text(
                    'لاتوجد بيانات ',
                    style: Theme.of(context).textTheme.labelLarge,
                  ),
                ),
        ),
      ],
    );
  }

  Widget _customItem(BuildContext context, int index, String pdfPath) {
    String fileName = Uri.file(pdfPath).pathSegments.last;
    print(fileName);
    return Container(
      decoration: BoxDecoration(
          color: ColorManager.white,
          borderRadius: BorderRadius.circular(
            AppSize.s12,
          ),
          boxShadow: [
            BoxShadow(
              color: ColorManager.grey,
              blurRadius: 10,
              offset: const Offset(0, 5),
            )
          ]),
      child: Padding(
        padding: EdgeInsets.all(AppPadding.p8.h),
        child: Row(
          children: [
            const SizedBox(
              width: 4,
            ),
            Expanded(
              flex: 6,
              child: Text(
                fileName,
                style: TextStyle(fontSize: FontSize.s24),
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
              ),
            ),
            Expanded(
              flex: 3,
              child: ElevatedButton(
                onPressed: () {
                  PersistentNavBarNavigator.pushNewScreen(
                    context,
                    withNavBar: false,
                    screen: ShowPDFView(
                      state: false,
                      index: index,
                      filepath: pdfPath,
                    ),
                  );
                },
                child: const Icon(
                  Icons.file_open,
                  color: Colors.white,
                ),
              ),
            ),
            const SizedBox(
              width: AppSize.s8,
            ),
            Expanded(
              flex: 3,
              child: ElevatedButton(
                onPressed: () async {
                  print(index);
                  print(box.getAt(index));

                  await _viewModel.updateStatus(fileName, "1").then((value) {
                    if (value) {
                      setState(() {
                        box.deleteAt(index);
                        allData = box.values.toList() as List<String>;
                      });
                    }
                  });
                },
                child: const Icon(
                  Icons.file_download_done_rounded,
                  color: Colors.white,
                ),
              ),
            ),
            const SizedBox(
              width: AppSize.s8,
            ),
            Expanded(
              flex: 3,
              child: ElevatedButton(
                onPressed: () async {
                  print(index);
                  print(box.getAt(index));
                  await _viewModel.updateStatus(fileName, "0").then((value) {
                    if(value) {
                      setState(() {
                      box.deleteAt(index);
                      allData = box.values.toList() as List<String>;
                      print(allData);
                    });
                    }
                  });
                },
                child: Icon(
                  Icons.delete,
                  color: Colors.white,
                  size: 22.sp,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future action(String fileName, String status) async {
    // Create Dio instance
    Dio dio = Dio();

    // Create FormData
    FormData formData = FormData.fromMap({
      'filename': fileName,
      'staues': status,
    });

    print(formData);

    try {
      // Make the POST request
      Response response = await dio.post(
        'https://roayadesign.com/api_s/tqarer_a3meda_s3udia/button_api',
        data: formData,
      );

      // Handle the response
      if (response.statusCode == 200) {
        // Successful response
        Map<String, dynamic> responseData = response.data;
        String status = responseData['status'];
        String message = responseData['message'];
        print('Status: $status');
        print('Message: $message');
      } else {
        print('Request failed with status: ${response.statusCode}');
      }
    } catch (error) {
      // Handle the error
      print('Error: $error');
    }
  }
}
