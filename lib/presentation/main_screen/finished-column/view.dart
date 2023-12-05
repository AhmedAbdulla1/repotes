import 'dart:async';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:pdf/pdf.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import 'package:reports/app/constant.dart';
import 'package:reports/data/data_source/lacal_database.dart';
import 'package:reports/presentation/common/reusable/custom_button.dart';
import 'package:reports/presentation/common/state_render/state_renderer_imp.dart';
import 'package:reports/presentation/edit_screen/view.dart';
import 'package:reports/presentation/main_screen/finished-column/view_model.dart';
import 'package:reports/presentation/resources/color_manager.dart';
import 'package:reports/presentation/resources/font_manager.dart';
import 'package:reports/presentation/resources/string_manager.dart';
import 'package:reports/presentation/resources/values_manager.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:reports/presentation/show_pdf/view.dart';

class FinishedColumnView extends StatefulWidget {
  const FinishedColumnView({Key? key}) : super(key: key);

  @override
  State<FinishedColumnView> createState() => _FinishedColumnViewState();
}

class _FinishedColumnViewState extends State<FinishedColumnView> {
  final FinishedColumnViewModel _viewModel = FinishedColumnViewModel();
  Box box = Hive.box<AddColumnModel>(Constant.mainBoxName);
  Box pdfBox = Hive.box<String>(Constant.pdfName);
  late List<AddColumnModel> allData;

  @override
  void initState() {
    allData = box.values.toList() as List<AddColumnModel>;
    super.initState();
  }

  @override
  void dispose() {
    _viewModel.dispose();
    super.dispose();
  }

  @override
  void didChangeDependencies() {
    allData = box.values.toList() as List<AddColumnModel>;
    setState(() {});
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _getContent(),
    );
  }

  Widget _getContent() {
    print(allData);
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: customElevatedButtonWithoutStream(
            height: AppSize.s65,
              onPressed: () {
                setState(() {
                  allData = box.values.toList() as List<AddColumnModel>;
                });
              },
              child:  Text("تحديث",style: TextStyle(
                color: Colors.white,
                fontSize: FontSize.s24,
                fontWeight: FontWeight.bold
              ),),),
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

  Widget _customItem(BuildContext context, int i, AddColumnModel data) {
    List<String> nonEmptyStrings = data.images.where((element) => element.isNotEmpty).toList();
    return Container(
      clipBehavior: Clip.hardEdge,
      decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
                color: ColorManager.grey,
                offset: const Offset(2, 4),
                blurRadius: 20),
          ],
          borderRadius: BorderRadius.circular(AppSize.s12),
          color: ColorManager.white),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "${AppStrings.columnName} : ${data.columnName}",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: FontSize.s22,
            ),
          ),
          SizedBox(
            height: AppSize.s100.h,
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: AppPadding.p13.w,
              ),
              child: ListView.separated(
                // padding: EdgeInsets.symmetric(horizontal:AppPadding.p13.w,),
                separatorBuilder: (context, index) => SizedBox(
                  width: MediaQuery.of(context).size.width * 0.03,
                ),
                scrollDirection: Axis.horizontal,
                itemCount: nonEmptyStrings.length,
                itemBuilder: (context, index) =>
                    _customContainer(nonEmptyStrings[index]),
              ),
            ),
          ),
          const SizedBox(height: AppSize.s10),
          SizedBox(
            height: AppSize.s55.h,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Expanded(
                    child: customElevatedButtonWithoutStream(
                  onPressed: () {
                    setState(() {
                      box.deleteAt(i);
                      allData = box.values.toList() as List<AddColumnModel>;
                    });
                  },
                  child: const Text(AppStrings.delete,style: TextStyle(
                    color: Colors.white,
                  )),
                )),
                Expanded(
                    child: customElevatedButtonWithoutStream(
                  onPressed: () {
                    PersistentNavBarNavigator.pushNewScreen(
                      context,
                      withNavBar: false,
                      screen: EditColumnView(
                        index: i,
                        addColumnModel: data,
                      ),
                    ).then((value) {
                      setState(() {
                        allData = box.values.toList() as List<AddColumnModel>;
                      });
                    });
                  },
                  child: const Text(AppStrings.edit,style: TextStyle(
                    color: Colors.white,
                  ),),
                )),
                Expanded(
                  child: customElevatedButtonWithoutStream(
                    onPressed: () async {
                      String pdf = await _generatePdf(data, nonEmptyStrings);
                      PersistentNavBarNavigator.pushNewScreen(
                        context,
                        withNavBar: false,
                        screen: ShowPDFView(
                          index: i,
                          filepath: pdf,
                          // addColumnModel: data[i],
                        ),
                      ).then((value) {
                        pdfBox.add(pdf);
                        setState(() {
                          allData = box.values.toList() as List<AddColumnModel>;
                        });
                      });
                    },
                    child:  Text(AppStrings.end,style: TextStyle(
                      color: Colors.white,
                    ),),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _customContainer(String image) {
    return Builder(builder: (context) {
      return Container(
        width: MediaQuery.sizeOf(context).width * 0.19,
        height: double.infinity,
        clipBehavior: Clip.hardEdge,
        decoration: BoxDecoration(
            color: ColorManager.lightGreen,
            borderRadius: BorderRadius.circular(
              AppSize.s12,
            ),
            boxShadow: [
              BoxShadow(
                color: ColorManager.grey,
                blurRadius: 3,
                offset: const Offset(4, 6),
              )
            ]),
        child: Image.file(
          File(image),
          fit: BoxFit.cover,
        ),
      );
    });
  }

  Future<String> _generatePdf(
      AddColumnModel addColumnModel, List<String> listImages) async {
    print("Start genrate pdf ");
    final pdf = pw.Document();
    List images = [];
    for (var i in listImages) {
      File imageFile = File(i);
      final bytes = await imageFile.readAsBytes();
      final image = pw.MemoryImage(bytes);
      images.add(image);
    }
    ByteData byteData = await rootBundle.load('assets/fonts/Cairo-Light.ttf');
    pdf.addPage(
      pw.Page(
        build: (pw.Context context) {
          return pw.Directionality(
            textDirection: pw.TextDirection.rtl,
            child: pw.Column(
              mainAxisAlignment: pw.MainAxisAlignment.center,
              children: [
                pw.Text(
                  ' اسم العمود: ${addColumnModel.columnName}',
                  style: pw.TextStyle(
                    fontSize: 40,
                    fontWeight: pw.FontWeight.bold,
                    font: pw.Font.ttf(byteData),
                  ),
                ),
                pw.SizedBox(height: 30),
                pw.Text(
                  "الاحداثيات: ${addColumnModel.latitude} , ${addColumnModel.longitude}",
                  style: pw.TextStyle(
                    fontSize: 30,
                    fontWeight: pw.FontWeight.bold,
                    font: pw.Font.ttf(byteData),
                  ),
                ),
                pw.SizedBox(height: 20),
                pw.SizedBox(
                  height: 200.h,
                  child: pw.Row(
                    children: [
                      pw.Expanded(
                        child: pw.Image(images[0], fit: pw.BoxFit.fill),
                      ),
                      pw.SizedBox(width: 20),
                      pw.Expanded(
                        child: pw.Image(images[1], fit: pw.BoxFit.fill),
                      ),
                    ],
                  ),
                ),
                pw.SizedBox(height: 20),
                pw.SizedBox(
                  height: 200.h,
                  child: pw.Row(
                    children: [
                      pw.Expanded(
                        child: pw.Image(images[2], fit: pw.BoxFit.fill),
                      ),
                      pw.SizedBox(width: 20),
                      pw.Expanded(
                        child: pw.Image(images[3], fit: pw.BoxFit.fill),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
    File file = File(
        "/data/user/0/com.example.reports/cache/${addColumnModel.columnName}.pdf");

    await file.writeAsBytes(await pdf.save());

    print(file.path);
    print("end generate pdf ");
    return file.path;
  }
}
