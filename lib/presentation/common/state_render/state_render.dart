// ignore_for_file: must_be_immutable

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:reports/presentation/resources/assets_manager.dart';
import 'package:reports/presentation/resources/color_manager.dart';
import 'package:reports/presentation/resources/font_manager.dart';
import 'package:reports/presentation/resources/string_manager.dart';
import 'package:reports/presentation/resources/style_manager.dart';
import 'package:reports/presentation/resources/values_manager.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

enum StateRenderType {
  //popup state
  popupErrorState,
  popupLoadingState,
  popupSuccessState,
  //full screen state
  fullScreenErrorState,
  fullScreenLoadingState,
  fullScreenEmptyState,
  //general
  contentState,
}

class StateRenderer extends StatelessWidget {
  String title;
  String message;
  final StateRenderType stateRenderType;
  final Function retryAction;

  late BuildContext newContext;

  StateRenderer({
    Key? key,
    this.title = '',
    this.message = AppStrings.loading,
    required this.stateRenderType,
    required this.retryAction,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    newContext = context;
    return _getStateWidget();
  }

  Widget _getStateWidget() {
    switch (stateRenderType) {
      case StateRenderType.popupErrorState:
        return _getPopUpDialog(
          [
            _getAnimatedImage(JsonAssets.error),
            SizedBox(height: 10.h,),
            _getMessage(),
            _getRetryButton(AppStrings.retry),
          ],
        );
      case StateRenderType.popupLoadingState:
        return _getPopUpDialog(
          [
            _getAnimatedImage(JsonAssets.loading),
            SizedBox(height: 10.h,),
            _getMessage(),
          ],
        );
      case StateRenderType.popupSuccessState:
        return _getPopUpDialog([
          _getAnimatedImage(JsonAssets.success),
          SizedBox(height: 10.h,),
          _getMessage(),
          _getRetryButton(AppStrings.ok)
        ]);
      case StateRenderType.fullScreenErrorState:
        return _getItemColumn([
          _getAnimatedImage(JsonAssets.error),
          SizedBox(height: 10.h,),
          _getMessage(),
          // _getRetryButton(AppStrings.retry),
        ]);
      case StateRenderType.fullScreenLoadingState:
        return _getItemColumn(
          [
            _getAnimatedImage(JsonAssets.loading),
            SizedBox(height: 10.h,),
            _getMessage(),
          ],
        );

      case StateRenderType.fullScreenEmptyState:
        return _getItemColumn(
          [
            _getAnimatedImage(JsonAssets.empty),
            SizedBox(height: 10.h,),
            _getMessage(),
          ],
        );
      case StateRenderType.contentState:
        return Container();
      default:
        return Container();
    }
  }

  Widget _getPopUpDialog(List<Widget> children) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppSize.s14),
      ),
      elevation: AppSize.s1_5,
      backgroundColor: Colors.transparent,
      child: Container(
        clipBehavior: Clip.hardEdge,
        height: 250.h,
        decoration: BoxDecoration(
            color: ColorManager.white,
            shape: BoxShape.rectangle,
            borderRadius: BorderRadius.circular(AppSize.s14),
            boxShadow: [
              BoxShadow(
                color: ColorManager.grey,
              )
            ]),
        child: _getItemColumn(children),
      ),
    );
  }

  Widget _getItemColumn(List<Widget> children) {
    return Container(
      color: Colors.white,
      height: double.infinity,
      child: Padding(
        padding: const EdgeInsets.all(AppPadding.p8),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: children,
          ),
        ),
      ),
    );
  }

  Widget _getAnimatedImage(String animationName) {
    return SizedBox(
        height: AppSize.s100,
        width: AppSize.s100,
        child: Lottie.asset(animationName));
  }

  Widget _getMessage() {
    return Text(
      message,
      style: getMessageStyle(
        color: ColorManager.black,
        fontSize: FontSize.s16,

      ),
      textAlign: TextAlign.center,
    );
  }

  Widget _getRetryButton(String title) {
    return Padding(
      padding: const EdgeInsets.all(AppPadding.p10),
      child: SizedBox(
        width: double.infinity,
        child: ElevatedButton(
          onPressed: () {
            if (title == AppStrings.retry || title ==AppStrings.ok) {
              //call retry function
              retryAction.call();
              Navigator.of(newContext).pop();
            } else {
              Navigator.of(newContext).pop();
            }
          },
          child: Text(
            title,
            style:const  TextStyle(
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}
