import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';

import 'package:reports/presentation/common/reusable/custom_button.dart';
import 'package:reports/presentation/common/state_render/state_renderer_imp.dart';
import 'package:reports/presentation/main_screen/ended-column/view_model.dart';
import 'package:reports/presentation/resources/color_manager.dart';
import 'package:reports/presentation/resources/font_manager.dart';
import 'package:reports/presentation/resources/string_manager.dart';
import 'package:reports/presentation/resources/values_manager.dart';
import 'package:reports/presentation/show_pdf/view.dart';

class EndedColumnView extends StatelessWidget {
  EndedColumnView({Key? key}) : super(key: key);
  final EndedColumnViewModel _viewModel = EndedColumnViewModel();

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<StateFlow>(
      stream: _viewModel.outputState,
      builder: (context, snapshot) =>
          snapshot.data?.getScreenWidget(
            context,
            _getContent(),
            () {},
          ) ??
          _getContent(),
    );
  }

  Widget _getContent() {
    return ListView.separated(
        padding: EdgeInsets.all(AppPadding.p16.w),
        itemBuilder: (context, index) => _customItem(context),
        separatorBuilder: (context, index) => SizedBox(
              height: AppSize.s16.h,
            ),
        itemCount: 30);
  }

  Widget _customItem(BuildContext context) {
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
      child: Row(
        children: [
          const Padding(
            padding: EdgeInsets.all(AppPadding.p8),
            child: Icon(
              Icons.picture_as_pdf_sharp,
            ),
          ),
          Expanded(
              flex: 4,
              child: Text(
                'اسم العمود524878 ',
                style: TextStyle(fontSize: FontSize.s24),
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
              )),
          Expanded(
            flex: 3,
            child: customElevatedButtonWithoutStream(
              onPressed: () {
                PersistentNavBarNavigator.pushNewScreen(
                  context,
                  withNavBar: false,
                  screen: const ShowPDFView(),
                );

              },
              child: const Text(AppStrings.show),
            ),
          ),
          Expanded(
            flex: 3,
            child: customElevatedButtonWithoutStream(
              onPressed: () {},
              child: const Text(AppStrings.delete),
            ),
          ),
        ],
      ),
    );
  }
}
