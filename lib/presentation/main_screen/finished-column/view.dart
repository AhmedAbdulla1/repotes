import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import 'package:reports/presentation/common/reusable/custom_button.dart';
import 'package:reports/presentation/common/state_render/state_renderer_imp.dart';
import 'package:reports/presentation/edit_screen/view.dart';
import 'package:reports/presentation/main_screen/finished-column/view_model.dart';
import 'package:reports/presentation/resources/color_manager.dart';
import 'package:reports/presentation/resources/font_manager.dart';
import 'package:reports/presentation/resources/routes_manager.dart';
import 'package:reports/presentation/resources/string_manager.dart';
import 'package:reports/presentation/resources/values_manager.dart';

class FinishedColumnView extends StatelessWidget {
  FinishedColumnView({Key? key}) : super(key: key);
  final FinishedColumnViewModel _viewModel = FinishedColumnViewModel();

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<StateFlow>(
      stream: _viewModel.outputState,
      builder: (context, snapshot) =>
          snapshot.data?.getScreenWidget(context, _getContent(), () {}) ??
          _getContent(),
    );
  }

  Widget _getContent() {
    return ListView.separated(
      separatorBuilder: (context, index) => const SizedBox(
        height: 20,
      ),
      itemCount: 6,
      padding: const EdgeInsets.all(
        AppPadding.p16,
      ),
      itemBuilder: (context, index) => _customItem(context),
    );
  }

  Widget _customItem(BuildContext context) {
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
            AppStrings.columnName,
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
                itemCount: 4,
                itemBuilder: (context, index) => _customContainer(),
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
                  onPressed: () {},
                  child: const Text(AppStrings.delete),
                )),
                Expanded(
                    child: customElevatedButtonWithoutStream(
                  onPressed: () {
                    PersistentNavBarNavigator.pushNewScreen(
                      context,
                      withNavBar: false,
                      screen: const EditColumnView(),
                    );
                  },
                  child: const Text(AppStrings.edit),
                )),
                Expanded(
                    child: customElevatedButtonWithoutStream(
                  onPressed: () {},
                  child: const Text(AppStrings.end),
                )),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _customContainer() {
    return Builder(builder: (context) {
      return Container(
        width: MediaQuery.sizeOf(context).width * 0.19,
        height: double.infinity,
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
      );
    });
  }
}
