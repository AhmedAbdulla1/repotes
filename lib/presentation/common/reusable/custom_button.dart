import 'dart:async';

import 'package:reports/presentation/resources/color_manager.dart';
import 'package:reports/presentation/resources/font_manager.dart';
import 'package:reports/presentation/resources/values_manager.dart';
import 'package:flutter/material.dart';

Widget customElevatedButton({
  required Stream<bool> stream,
  required VoidCallback onPressed,
  required String text,
}) {
  return StreamBuilder<bool>(
    stream: stream,
    builder: (context, snapshot) => SizedBox(
      height: AppSize.s55,
      width: double.infinity,
      child: ElevatedButton(
          onPressed: (snapshot.data ?? false) ? onPressed : null,
          child: Text(
            text,
            style: TextStyle(
              color: ColorManager.white,
              fontFamily: FontConstants.enFontFamily,
              fontSize: FontSize.s24,
              fontWeight: FontWeight.bold
            ),
          )),
    ),
  );
}

Widget customElevatedButtonWithoutStream({
  required VoidCallback onPressed,
  required Widget child,
  double height = AppSize.s55 ,
}) {
  return SizedBox(
      height: height,
      width: double.infinity,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: AppPadding.p12,vertical: AppPadding.p8),
        child: ElevatedButton(
          onPressed: onPressed,
          child: child,
        ),
      ));
}

Widget textButton({
  required context,
  required VoidCallback onPressed,
  required String text,
}) {
  return TextButton(
    onPressed: onPressed,
    child: Text(
      text,
      style: Theme.of(context).textTheme.bodyLarge,
      textAlign: TextAlign.end,
    ),
  );
}
