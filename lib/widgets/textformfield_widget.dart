import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';

import '../const/const_color.dart';

TextFormField textFormFieldWidget({
  TextEditingController? controller,
  required String hintText,
  required TextInputType textInputType,
  required BuildContext context,
  void Function(String?)? onSaved,
  String? Function(String?)? validator,
  bool readOnly = false,
}) {
  return TextFormField(
    controller: controller,
    readOnly: readOnly!,
    textAlign: TextAlign.center,
    decoration: InputDecoration(
      hintText: hintText,
      hintStyle: TextStyle(
        color: ConstColors.blackColor.withOpacity(0.3),
      ),
      fillColor: ConstColors.iconsColor,
      focusColor: ConstColors.iconsColor,
      focusedBorder: UnderlineInputBorder(
        borderSide: BorderSide(
          color: ConstColors.iconsColor,
        ),
      ),
    ),
    onSaved: onSaved,
    validator: validator,
    keyboardType: textInputType,
    cursorColor: ConstColors.iconsColor,
    cursorWidth: MediaQuery.of(context).size.width * 0.01,
    cursorHeight: MediaQuery.of(context).size.height * 0.03,
  );
}

TypeAheadFormField typeAheadFormField({
  required String hintText,
  required TextEditingController nameCustomerController,
  required TextInputType textInputType,
  required List<String> Function(String) suggestionsCallback,
  required BuildContext context,
  void Function(String?)? onSaved,
  String? Function(String?)? validator,
}) {
  return TypeAheadFormField<String?>(
    suggestionsBoxDecoration: SuggestionsBoxDecoration(
      color: ConstColors.dropdownMenuItemColor.withOpacity(0.01),
      elevation: 0,
    ),
    textFieldConfiguration: TextFieldConfiguration(
      textAlign: TextAlign.center,
      controller: nameCustomerController,
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: TextStyle(
          color: ConstColors.blackColor.withOpacity(0.3),
        ),
        fillColor: ConstColors.iconsColor,
        focusColor: ConstColors.iconsColor,
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(
            color: ConstColors.iconsColor,
          ),
        ),
      ),
      cursorColor: ConstColors.iconsColor,
    ),
    hideOnEmpty: true,
    onSuggestionSelected: (String? suggestion) =>
        nameCustomerController.text = suggestion!,
    itemBuilder: (context, String? suggestion) => ListTile(
      title: Text(suggestion!),
    ),
    onSaved: onSaved,
    validator: validator,
    suggestionsCallback: suggestionsCallback,
  );
}

MaterialButton materialButtonFullWidget(
    {required BuildContext context,
    required String textButton,
    required Function()? onPressed,
    required Color colorbutton,
    required IconData iconData}) {
  return MaterialButton(
    minWidth: MediaQuery.of(context).size.width * 0.3,
    height: MediaQuery.of(context).size.width * 0.01,
    color: ConstColors.buttonsFilledcolor,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(7),
    ),
    elevation: 0,
    onPressed: onPressed,
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        SizedBox(
          width: MediaQuery.of(context).size.width * 0.1,
        ),
        Text(
          textButton,
          style: TextStyle(
            color: ConstColors.wihteColor,
          ),
        ),
        SizedBox(
          width: MediaQuery.of(context).size.width * 0.1 / 2,
        ),
        Icon(
          Icons.arrow_downward_rounded,
          color: ConstColors.red,
        ),
      ],
    ),
  );
}

MaterialButton materialButtonOutlineWidget(
    {required BuildContext context,
    required String textButton,
    required Function()? onPressed,
    required Color colorbutton,
    required IconData iconData}) {
  return MaterialButton(
    minWidth: MediaQuery.of(context).size.width * 0.3,
    height: MediaQuery.of(context).size.width * 0.01,
    color: colorbutton,
    elevation: 0,
    shape: RoundedRectangleBorder(
      side: BorderSide(
        color: ConstColors.outlinedbuttonscolor,
        width: MediaQuery.of(context).size.width * 0.01 / 2.5,
      ),
      borderRadius: BorderRadius.circular(7),
    ),
    onPressed: onPressed,
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(
          width: 30,
        ),
        Text(
          textButton,
          textAlign: TextAlign.start,
          style: TextStyle(
            color: ConstColors.textoutlinedbuttonscolor,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(
          width: 30,
        ),
        Icon(
          iconData,
          color: ConstColors.green,
        ),
      ],
    ),
  );
}
