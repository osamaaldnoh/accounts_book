import 'package:accounts_book/const/const_color.dart';
import 'package:accounts_book/controller/currencies.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class WidgetRadio extends StatelessWidget {
  WidgetRadio({Key? key, required this.value}) : super(key: key);

  final String value;

  Currencies _currencies = Get.find();
  @override
  Widget build(BuildContext context) {
    _currencies.orderType.value = _currencies.orderType.isNotEmpty
        ? _currencies.orderType.value
        : _currencies.currencies.first.currencyName!;
    return Obx(
      () => InkWell(
        overlayColor: MaterialStatePropertyAll(Colors.transparent),
        onTap: () => _currencies.setOrderType(value),
        child: Row(
          children: [
            Text(value),
            Radio(
              value: value,
              groupValue: _currencies.orderType.value,
              onChanged: (String? value) {
                _currencies.setOrderType(value!);
              },
              activeColor: ConstColors.radiocolor,
              focusColor: ConstColors.red,
              fillColor: MaterialStatePropertyAll(
                ConstColors.outlinedbuttonscolor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
//
// WidgetRadio({required String currencyName, required int status}) {
//   return Row(
//     children: [
//       Text('محلي'),
//       Radio(
//         value: 1,
//         groupValue: status,
//         onChanged: (value) {},
//         activeColor: ConstColors.radiocolor,
//         focusColor: ConstColors.red,
//         fillColor: MaterialStatePropertyAll(
//           ConstColors.outlinedbuttonscolor,
//         ),
//       ),
//     ],
//   );
// }
