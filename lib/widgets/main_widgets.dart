import 'package:flutter/material.dart';

Iconwidget({required BuildContext context, required IconData iconData}) {
  return SizedBox(
    width: MediaQuery.of(context).size.width * 0.2 / 1.7,
    child: Icon(
      iconData,
      size: MediaQuery.of(context).size.height * 0.04,
    ),
  );
}

class IconWidgets extends StatelessWidget {
  const IconWidgets(
      {Key? key,
      required this.iconData,
      required this.context,
      required this.isPortrait})
      : super(key: key);

  final IconData iconData;
  final BuildContext context;
  final bool isPortrait;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: isPortrait
          ? MediaQuery.of(context).size.width * 0.2 / 1.7
          : MediaQuery.of(context).size.width * 0.2 / 2.5,
      child: Icon(
        iconData,
        size: isPortrait
            ? MediaQuery.of(context).size.height * 0.04
            : MediaQuery.of(context).size.width * 0.04,
      ),
    );
  }
}
