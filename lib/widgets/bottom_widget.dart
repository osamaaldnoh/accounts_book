import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../const/const_color.dart';

bottomWidget({
  required BuildContext context,
  required IconData iconRight,
  required IconData iconLeft,
  required String uponYou,
  required String forYou,
  required String currency,
  required Function()? iconRightonPressed,
  required Function()? iconLeftonPressed,
}) {
  return Directionality(
    textDirection: TextDirection.ltr,
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        IconButton(
          onPressed: () {},
          icon: Icon(
            Icons.help_outline,
            color: ConstColors.iconappBar,
            size: MediaQuery.of(context).size.height * 0.04,
          ),
        ),
        Column(
          children: [
            Text(
              'عليك:=$uponYou لك:=$forYou',
              style: TextStyle(
                color: ConstColors.textColor,
              ),
            ),
            Text(
              currency,
              style: TextStyle(
                color: ConstColors.textColor,
              ),
            ),
          ],
        ),
        IconButton(
          onPressed: iconRightonPressed,
          icon: Icon(
            Icons.add_circle_outline_sharp,
            color: ConstColors.iconappBar,
            size: MediaQuery.of(context).size.height * 0.04,
          ),
        ),
      ],
    ),
  );
}
