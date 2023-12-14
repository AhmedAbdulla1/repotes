import 'dart:async';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import 'package:reports/app/constant.dart';
import 'package:reports/data/data_source/lacal_database.dart';
import 'package:reports/presentation/common/reusable/custom_button.dart';
import 'package:reports/presentation/common/reusable/custom_text_form_field.dart';
import 'package:reports/presentation/edit_screen/view.dart';
import 'package:reports/presentation/main_screen/finished-column/view_model.dart';
import 'package:reports/presentation/resources/color_manager.dart';
import 'package:reports/presentation/resources/font_manager.dart';
import 'package:reports/presentation/resources/string_manager.dart';
import 'package:reports/presentation/resources/values_manager.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:reports/presentation/show_pdf/view.dart';

class FinishedColumnView extends StatefulWidget {
  const FinishedColumnView({Key? key}) : super(key: key);

  @override
  State<FinishedColumnView> createState() => _FinishedColumnViewState();
}

class _FinishedColumnViewState extends State<FinishedColumnView> {
  final FinishedColumnViewModel _viewModel = FinishedColumnViewModel();
  final TextEditingController _searchEditingController =
      TextEditingController();
  Box box = Hive.box<AddColumnModel>(Constant.mainBoxName);
  Box pdfBox = Hive.box<String>(Constant.pdfName);

  bind() {
    _viewModel.start();
    _searchEditingController.addListener(() {
      _viewModel.setSearch(_searchEditingController.text);
    });
  }

  @override
  void initState() {
    bind();
    super.initState();
  }

  @override
  void dispose() {
    _viewModel.dispose();
    super.dispose();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return _getContent();
  }

  Widget _getContent() {
    return StreamBuilder<List<AddColumnModel>>(
        stream: _viewModel.dataOutput,
        builder: (context, snapshot) {
          print(snapshot.data);
          return Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: AppPadding.p8, vertical: AppPadding.p8),
                child: customTextFormField(
                  stream: _viewModel.searchOutput,
                  textEditingController: _searchEditingController,
                  hintText: AppStrings.search,
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: AppPadding.p8),
                child: customElevatedButtonWithoutStream(
                  onPressed: () {
                    _viewModel.getData();
                  },
                  child: Text(
                    "تحديث",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: FontSize.s18,
                        fontWeight: FontWeight.normal),
                  ),
                ),
              ),
              Expanded(
                child: snapshot.data != null && snapshot.data!.isNotEmpty
                    ? ListView.separated(
                        separatorBuilder: (context, index) => SizedBox(
                          height: 20.h,
                        ),
                        itemCount: snapshot.data!.length,
                        padding: EdgeInsets.all(
                          AppPadding.p16.w,
                        ),
                        itemBuilder: (context, index) =>
                            _customItem(context, index, snapshot.data![index]),
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
        });
  }

  Widget _customItem(BuildContext context, int i, AddColumnModel data) {
    List<ImageDataHive> nonEmptyStrings =
        data.images.where((element) => element.path.isNotEmpty).toList();
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
                    box.deleteAt(i);
                    _viewModel.getData();
                  },
                  child: const Text(AppStrings.delete,
                      style: TextStyle(
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
                      _viewModel.getData();
                    });
                  },
                  child: const Text(
                    AppStrings.edit,
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
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
                        ),
                      ).then((value) {
                        _viewModel.getData();
                      });
                    },
                    child: const Text(
                      AppStrings.end,
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _customContainer(ImageDataHive image) {
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
          File(image.path),
          fit: BoxFit.cover,
        ),
      );
    });
  }

  pw.Widget customText(String text, double fontSize, ByteData byteData) {
    return pw.Expanded(
      child: pw.Padding(
        child: pw.Text(
          text,
          textAlign: pw.TextAlign.center,
          style: pw.TextStyle(
            fontSize: fontSize,
            font: pw.Font.ttf(byteData),
          ),
        ),
        padding: pw.EdgeInsets.all(2.h),
      ),
    );
  }

  pw.Widget customItem({
    required pw.MemoryImage imagePath,
    required String date,
    required String location,
    required ByteData byteData,
  }) {
    return pw.Padding(
      padding: pw.EdgeInsets.all(3.h),
      child: pw.Column(
        children: [
          pw.SizedBox(
            height: 230.h,
            width: MediaQuery.sizeOf(context).width * 0.5,
            child: pw.Image(
              imagePath,
              fit: pw.BoxFit.fitWidth,
            ),
          ),
          pw.Padding(
            child: pw.Text(
              date,
              textAlign: pw.TextAlign.center,
              style: pw.TextStyle(
                fontSize: 10,
                font: pw.Font.ttf(byteData),
              ),
            ),
            padding: pw.EdgeInsets.zero,
          ),
          pw.Padding(
            child: pw.Text(
              location,
              textAlign: pw.TextAlign.center,
              style: pw.TextStyle(
                fontSize: 10,
                font: pw.Font.ttf(byteData),
              ),
            ),
            padding: pw.EdgeInsets.only(bottom: 1.h),
          ),
        ],
      ),
    );
  }

  Future<String> _generatePdf(
      AddColumnModel addColumnModel, List<ImageDataHive> listImages) async {
    final pdf = pw.Document();
    List<pw.MemoryImage> images = [];
    for (var i in listImages) {
      File imageFile = File(i.path);
      final bytes = await imageFile.readAsBytes();
      final image = pw.MemoryImage(bytes);
      images.add(image);
    }
    ByteData byteData = await rootBundle.load('assets/fonts/Cairo-Regular.ttf');
    pdf.addPage(
      pw.Page(
        build: (pw.Context context) {
          return pw.Directionality(
            textDirection: pw.TextDirection.rtl,
            child: pw.Column(
              mainAxisAlignment: pw.MainAxisAlignment.end,
              children: [
                pw.Table(
                  border: pw.TableBorder.all(),
                  children: [
                    pw.TableRow(
                      children: [
                        customText('الاحداثيات', 12, byteData),
                        customText('رقم العمود', 12, byteData),
                      ],
                    ),
                    pw.TableRow(
                      children: [
                        customText(
                          '${addColumnModel.latitude} , ${addColumnModel.longitude}',
                          12,
                          byteData,
                        ),
                        customText(addColumnModel.columnName, 12, byteData),
                      ],
                    ),
                  ],
                ),
                pw.SizedBox(height: 10.h),
                pw.Padding(
                  padding: const pw.EdgeInsets.symmetric(horizontal: AppPadding.p65),
                  child: pw.Table(
                    border: pw.TableBorder.all(),
                    children: [
                      pw.TableRow(
                        verticalAlignment: pw.TableCellVerticalAlignment.middle,
                        children: [
                          customItem(
                            imagePath: images[1],
                            date: addColumnModel.images[1].date,
                            location:
                                "${addColumnModel.images[1].late} , ${addColumnModel.images[1].long}",
                            byteData: byteData,
                          ),
                          customItem(
                            imagePath: images[0],
                            date: addColumnModel.images[0].date,
                            location:
                                "${addColumnModel.images[0].late} , ${addColumnModel.images[0].long}",
                            byteData: byteData,
                          ),
                        ],
                      ),
                      pw.TableRow(
                        verticalAlignment: pw.TableCellVerticalAlignment.middle,
                        children: [
                          customItem(
                            imagePath: images[3],
                            date: addColumnModel.images[3].date,
                            location:
                                "${addColumnModel.images[3].late} , ${addColumnModel.images[3].long}",
                            byteData: byteData,
                          ),
                          customItem(
                            imagePath: images[2],
                            date: addColumnModel.images[2].date,
                            location:
                                "${addColumnModel.images[2].late} , ${addColumnModel.images[2].long}",
                            byteData: byteData,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                pw.SizedBox(height: 10.h),
              ],
            ),
          );
        },
      ),
    );
    File file = File(
        "/data/user/0/com.example.reports/cache/${addColumnModel.columnName}.pdf");
    await file.writeAsBytes(await pdf.save());
    print("end generate pdf ");
    return file.path;
  }
}
