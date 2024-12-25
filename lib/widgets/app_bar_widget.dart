import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../const/const_color.dart';
import '../const/text_style.dart';
import 'main_widgets.dart';

// size: isPortrait!
// ? MediaQuery.of(context).size.height * 0.04
// : MediaQuery.of(context).size.width * 0.04,
AppBarWidget({
  bool? isPortrait,
  required BuildContext context,
  required RxString title,
  IconData? icon1,
  void Function()? onTapIcon1,
  IconData? icon2,
  void Function()? onTapIcon2,
  IconData? icon3,
  void Function()? onTapIcon3,
}) {
  return AppBar(
    elevation: 0,
    backgroundColor: ConstColors.appBar,
    iconTheme: IconThemeData(
        color: ConstColors.iconappBar,
        size: MediaQuery.of(context).size.height * 0.04),
    title: Obx(
      () => Text(
        title.value,
        style: Styles.headLineStyle1,
      ),
    ),
    actions: [
      InkWell(
        onTap: () async {
          // final employ = employessController.employee;
          // await PdfInvoice.generate(employ);
        },
        child: IconWidgets(
          context: context,
          iconData: icon1!,
          isPortrait: isPortrait!,
        ),
      ),
      InkWell(
        onTap: onTapIcon2,
        child: IconWidgets(
          context: context,
          iconData: icon2!,
          isPortrait: isPortrait!,
        ),
      ),
      InkWell(
        onTap: onTapIcon3,
        child: IconWidgets(
          context: context,
          iconData: icon3!,
          isPortrait: isPortrait!,
        ),
      ),
    ],
  );
}

AppBarWidgetTwoIcons({
  required BuildContext context,
  required String title,
  IconData? icon1,
  void Function()? onTapIcon1,
  IconData? icon2,
  void Function()? onTapIcon2,
}) {
  return AppBar(
    backgroundColor: ConstColors.appBar,
    title: Text(
      title,
      style: TextStyle(
        color: ConstColors.textColor,
      ),
    ),
    elevation: 0,
    iconTheme: IconThemeData(
      color: ConstColors.iconsColor,
    ),
    actions: [
      SizedBox(
        width: MediaQuery.of(context).size.width * 0.2 / 1.7,
        child: Icon(
          icon1,
          size: MediaQuery.of(context).size.height * 0.04,
        ),
      ),
      SizedBox(
        width: MediaQuery.of(context).size.width * 0.2 / 1.7,
        child: Icon(
          icon2,
          size: MediaQuery.of(context).size.height * 0.04,
        ),
      ),
    ],
  );
}
