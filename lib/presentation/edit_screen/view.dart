import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:reports/app/di.dart';
import 'package:reports/presentation/common/reusable/custom_button.dart';
import 'package:reports/presentation/common/reusable/custom_text_form_field.dart';
import 'package:reports/presentation/common/state_render/state_renderer_imp.dart';
import 'package:reports/presentation/edit_screen/view_model.dart';
import 'package:reports/presentation/resources/assets_manager.dart';
import 'package:reports/presentation/resources/color_manager.dart';
import 'package:reports/presentation/resources/string_manager.dart';
import 'package:reports/presentation/resources/values_manager.dart';
import 'package:image_picker/image_picker.dart';



class EditColumnView extends StatefulWidget {
  const EditColumnView({Key? key}) : super(key: key);

  @override
  State<EditColumnView> createState() => _EditColumnViewState();
}

class _EditColumnViewState extends State<EditColumnView> {
  final EditColumnViewModel _viewModel = EditColumnViewModel();
  final TextEditingController _columnNameController = TextEditingController();
  final ImagePicker _imagePicker = ImagePicker();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:AppBar(
        title:Text( "تعديل"),
      ),
      body: StreamBuilder<StateFlow>(
        stream: _viewModel.outputState,
        builder: (context, snapshot) =>
            snapshot.data?.getScreenWidget(
              context,
              _getContent(),
              () {},
            ) ??
            _getContent(),
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
            StreamBuilder<File>(
              stream: _viewModel.beforeImageOutput,
              builder: (context, snapshot) =>
                  _customItem(AppStrings.before, snapshot.data, 0),
            ),
            SizedBox(
              width: AppSize.s20.w,
            ),
            StreamBuilder<File>(
              stream: _viewModel.innerImage1Output,
              builder: (context, snapshot) =>
                  _customItem(AppStrings.inner, snapshot.data, 1),
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
            StreamBuilder<File>(
              stream: _viewModel.innerImage2Output,
              builder: (context, snapshot) =>
                  _customItem(AppStrings.inner, snapshot.data, 2),
            ),
            SizedBox(
              width: AppSize.s20.w,
            ),
            StreamBuilder<File>(
              stream: _viewModel.afterImageOutput,
              builder: (context, snapshot) =>
                  _customItem(AppStrings.after, snapshot.data, 3,),
            ),
          ],
        ),
        SizedBox(
          height: AppSize.s30.h,
        ),
        customElevatedButton(
          stream: _viewModel.allRightOutput,
          onPressed: () {},
          text: AppStrings.save,
        ),
      ],
    );
  }

  Widget _customItem(String title, File? image, int num) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          title,
          style: Theme.of(context).textTheme.headlineLarge,
        ),
        image != null
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
                    _imageFromGallery(num);
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
                    _imageFromCamera(num);
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

  _imageFromGallery(int num) async {
    var image = await _imagePicker.pickImage(source: ImageSource.gallery);
    switch (num) {
      case 0:
        _viewModel.beforeImageInput.add(File(image?.path ?? ""));
        return;
      case 1:
        _viewModel.innerImage1Input.add(File(image?.path ?? ""));
        return;
      case 2:
        _viewModel.innerImage2Input.add(File(image?.path ?? ""));
        return;
      case 3:
        _viewModel.afterImageInput.add(File(image?.path ?? ""));
        return;
      default:
        return;
    }
  }

  _imageFromCamera(int num) async {
    var image = await _imagePicker.pickImage(source: ImageSource.camera);
    switch (num) {
      case 0:
        _viewModel.beforeImageInput.add(File(image?.path ?? ""));
        return;
      case 1:
        _viewModel.innerImage1Input.add(File(image?.path ?? ""));
        return;
      case 2:
        _viewModel.innerImage2Input.add(File(image?.path ?? ""));
        return;
      case 3:
        _viewModel.afterImageInput.add(File(image?.path ?? ""));
        return;
      default:
        return;
    }
  }

  Widget _showImage(File? image) {
    if (image != null && image.path.isNotEmpty) {
      return Image.file(
        image,
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
