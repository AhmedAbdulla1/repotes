import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hive/hive.dart';
import 'package:reports/app/constant.dart';
import 'package:reports/app/di.dart';
import 'package:reports/domain/models/models.dart';
import 'package:reports/presentation/common/reusable/custom_button.dart';
import 'package:reports/presentation/common/reusable/custom_text_form_field.dart';
import 'package:reports/presentation/common/state_render/state_renderer_imp.dart';
import 'package:reports/presentation/edit_screen/view_model.dart';
import 'package:reports/presentation/resources/assets_manager.dart';
import 'package:reports/presentation/resources/color_manager.dart';
import 'package:reports/presentation/resources/font_manager.dart';
import 'package:reports/presentation/resources/string_manager.dart';
import 'package:reports/presentation/resources/values_manager.dart';
import 'package:image_picker/image_picker.dart';
import 'package:reports/data/data_source/lacal_database.dart';

class EditColumnView extends StatefulWidget {
  EditColumnView({Key? key, required this.index, required this.addColumnModel})
      : super(key: key);
  final AddColumnModel addColumnModel;

  final int index;

  @override
  State<EditColumnView> createState() => _EditColumnViewState();
}

class _EditColumnViewState extends State<EditColumnView> {
  final EditColumnViewModel _viewModel = EditColumnViewModel();
  final TextEditingController _columnNameController = TextEditingController();
  final ImagePicker _imagePicker = ImagePicker();
  List<String> images = [
    "",
    "",
    "",
    "",
  ];

  void _bind() {
    _viewModel.start();
    _viewModel.setData(widget.addColumnModel);
    _columnNameController.text = widget.addColumnModel.columnName;
    _columnNameController.addListener(
      () => _viewModel.setColumnName(
        _columnNameController.text,
      ),
    );
    images = widget.addColumnModel.images;
  }

  @override
  void initState() {
    _bind();
    super.initState();
  }

  @override
  void dispose() {
    _viewModel.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("تعديل"),
      ),
      body: Directionality(
        textDirection: TextDirection.rtl,
        child: StreamBuilder<StateFlow>(
          stream: _viewModel.outputState,
          builder: (context, snapshot) =>
              snapshot.data?.getScreenWidget(
                context,
                _getContent(),
                () {},
              ) ??
              _getContent(),
        ),
      ),
    );
  }

  Widget _getContent() {
    return ListView(
      padding: EdgeInsets.all(AppPadding.p16.w),
      children: [
        customTextFormField(
          stream: _viewModel.columnNameOutput,
          textEditingController: _columnNameController,
          hintText: AppStrings.columnName,
        ),
        SizedBox(
          height: AppSize.s16.w,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            StreamBuilder<String>(
              stream: _viewModel.beforeImageOutput,
              builder: (context, snapshot) =>
                  _customItem(AppStrings.before, snapshot.data ?? images[0], 0),
            ),
            SizedBox(
              width: AppSize.s20.w,
            ),
            StreamBuilder<String>(
              stream: _viewModel.innerImage1Output,
              builder: (context, snapshot) =>
                  _customItem(AppStrings.inner, snapshot.data ?? images[1], 1),
            ),
          ],
        ),
        SizedBox(
          height: AppSize.s16.w,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            StreamBuilder<String>(
              stream: _viewModel.innerImage2Output,
              builder: (context, snapshot) =>
                  _customItem(AppStrings.inner, snapshot.data ?? images[2], 2),
            ),
            SizedBox(
              width: AppSize.s20.w,
            ),
            StreamBuilder<String>(
              stream: _viewModel.afterImageOutput,
              builder: (context, snapshot) => _customItem(
                AppStrings.after,
                snapshot.data ?? images[3],
                3,
              ),
            ),
          ],
        ),
        SizedBox(
          height: AppSize.s30.h,
        ),
        customElevatedButtonWithoutStream(
          onPressed: () {
            _viewModel.save(
              widget.index,
            );
            Navigator.pop(context);
          },
          child: Text(
            AppStrings.save,
            style: TextStyle(
                color: ColorManager.white,
                fontFamily: FontConstants.enFontFamily,
                fontSize: FontSize.s24,
                fontWeight: FontWeight.bold),
          ),
        ),
      ],
    );
  }

  Widget _customItem(String title, String? image, int num) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          title,
          style: Theme.of(context).textTheme.headlineLarge,
        ),
        image != null && image.isNotEmpty
            ? Container(
                clipBehavior: Clip.antiAlias,
                width: AppSize.s165.w,
                height: AppSize.s220.h,
                decoration: BoxDecoration(
                  color: ColorManager.white,
                  borderRadius: BorderRadius.circular(AppSize.s12),
                  boxShadow: [
                    BoxShadow(
                        offset: const Offset(4, 4),
                        color: ColorManager.grey,
                        blurRadius: 20),
                  ],
                ),
                child: Stack(fit: StackFit.expand, children: [
                  _showImage(image),
                  Positioned(
                    bottom: 10.w,
                    right: 10.w,
                    child: Container(
                      width: AppSize.s30.w,
                      height: AppSize.s30.w,
                      decoration: BoxDecoration(
                        color: ColorManager.primary,
                        borderRadius: BorderRadius.circular(AppSize.s30),
                      ),
                      child: IconButton(
                        onPressed: () {
                          _showPicker(context, num);
                        },
                        icon: const Icon(
                          Icons.edit,
                          size: 15,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 10.w,
                    right: 50.w,
                    child: Container(
                      width: AppSize.s30.w,
                      height: AppSize.s30.w,
                      decoration: BoxDecoration(
                        color: ColorManager.primary,
                        borderRadius: BorderRadius.circular(AppSize.s30),
                      ),
                      child: IconButton(
                        onPressed: () {
                          switch (num) {
                            case 0:
                              _viewModel.beforeImageInput.add("");
                            case 1:
                              _viewModel.innerImage1Input.add((""));
                            case 2:
                              _viewModel.innerImage2Input.add("");
                            case 3:
                              _viewModel.afterImageInput.add("");
                            default:
                              return;
                          }
                          _viewModel.setImage(num, "");
                        },
                        icon: const Icon(
                          Icons.delete,
                          size: 15,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ]))
            : InkWell(
                onTap: () {
                  _showPicker(context, num);
                },
                child: Container(
                  width: AppSize.s165.w,
                  height: AppSize.s220.h,
                  decoration: BoxDecoration(
                    color: ColorManager.white,
                    borderRadius: BorderRadius.circular(AppSize.s12),
                    boxShadow: [
                      BoxShadow(
                          offset: const Offset(4, 4),
                          color: ColorManager.grey,
                          blurRadius: 20),
                    ],
                  ),
                  child: Center(
                    child: Text(
                      AppStrings.addImage,
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                  ),
                ),
              ),
      ],
    );
  }

  _showPicker(BuildContext context, int num) {
    showModalBottomSheet(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(
            AppSize.s30,
          ),
        ),
      ),
      context: context,
      builder: (BuildContext context) {
        return Directionality(
          textDirection: TextDirection.ltr,
          child: SafeArea(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                ListTile(
                  leading: const Icon(Icons.camera),
                  title: Text(
                    AppStrings.photoGallery,
                    style: TextStyle(color: ColorManager.primary),
                  ),
                  onTap: () {
                    _imageFromGallery(num, ImageSource.gallery);
                    Navigator.of(context).pop();
                  },
                ),
                ListTile(
                  leading: const Icon(
                    Icons.camera_alt_rounded,
                  ),
                  title: Text(
                    AppStrings.photoCamera,
                    style: TextStyle(
                      color: ColorManager.primary,
                    ),
                  ),
                  onTap: () {
                    _imageFromGallery(num, ImageSource.camera);
                    Navigator.of(context).pop();
                  },
                )
              ],
            ),
          ),
        );
      },
    );
  }

  _imageFromGallery(int num, ImageSource imageSource) async {
    var image = await _imagePicker.pickImage(source: imageSource);
    switch (num) {
      case 0:
        print(num);
        _viewModel.beforeImageInput.add((image?.path ?? ""));
      case 1:
        _viewModel.innerImage1Input.add((image?.path ?? ""));
      case 2:
        print(num);
        _viewModel.innerImage2Input.add((image?.path ?? ""));
      case 3:
        print(num);
        _viewModel.afterImageInput.add((image?.path ?? ""));
      default:
        return;
    }
    _viewModel.setImage(num, image?.path ?? '');
    return;
  }

  Widget _showImage(String? image) {
    if (image != null && image.isNotEmpty) {
      return Image.file(
        File(image),
        fit: BoxFit.cover,
      );
    } else {
      return Image.asset(
        ImageAssets.appLogo,
        fit: BoxFit.cover,
      );
    }
  }
}
