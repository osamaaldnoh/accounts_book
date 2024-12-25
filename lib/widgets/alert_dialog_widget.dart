import 'package:accounts_book/const/const_color.dart';
import 'package:accounts_book/const/text_style.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controller/currencies.dart';

// class showAlertDialogWidget extends StatelessWidget {
//   showAlertDialogWidget({required BuildContext context, Key? key})
//       : super(key: key);
//   Currencies _currencies = Get.put(Currencies());
//
//   @override
//   Widget build(BuildContext context) {
//     // _currencies.getData();
//     return AlertDialog(
//         //scrollable: true,
//
//         //actionsPadding: EdgeInsets.all(MediaQuery.of(context).size.width * 0.05),
//         content: _currencies.currency.value.isNotEmpty
//             ? Column(
//                 children: [
//                   Text('${_currencies.currency.value.first.currencyName}'),
//                   Divider(
//                     color: ConstColors.dividerColor,
//                     thickness: 1,
//                   ),
//                   //Text('data'),
//                 ],
//               )
//             : Center(
//                 child: Text('Null'),
//               )
//         // Column(
//         //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//         //   crossAxisAlignment: CrossAxisAlignment.end,
//         //   children: [
//         //     Text(
//         //       'عملاء(دولار)',
//         //       textAlign: TextAlign.center,
//         //       style: Styles.headLineStyle4,
//         //     ),
//         //     Divider(
//         //       color: ConstColors.dividerColor,
//         //       thickness: 1,
//         //     ),
//         //     Text(
//         //       'عملاء(سعودي)',
//         //       style: Styles.headLineStyle4,
//         //     ),
//         //     Divider(
//         //       color: ConstColors.dividerColor,
//         //       thickness: 1,
//         //     ),
//         //     Text(
//         //       'عام(محلي)',
//         //       style: Styles.headLineStyle4,
//         //     ),
//         //     Divider(
//         //       color: ConstColors.dividerColor,
//         //       thickness: 1,
//         //     ),
//         //     Text(
//         //       'موردين(محلي)',
//         //       style: Styles.headLineStyle4,
//         //     ),
//         //   ],
//         // ),
//
//         );
//   }
// }

class showAlertDialogWidget extends StatelessWidget {
  showAlertDialogWidget({required BuildContext context, Key? key})
      : super(key: key);
  Currencies _currencies = Get.put(Currencies());

  List<Widget> _listCurrency() {
    return _currencies.currencies
        .map((element) => InkWell(
              onTap: () {
                //print('element ${element.currencyName}');
              },
              child: Column(
                children: [
                  Text(element.currencyName.toString()),
                  Divider(
                    color: ConstColors.dividerColor,
                    thickness: 1,
                  ),
                ],
              ),
            ))
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      //actionsPadding: EdgeInsets.all(MediaQuery.of(context).size.width * 0.05),
      actions: [
        Obx(
          () => Column(
            children: _listCurrency(),
          ),
        ),
        // Column(
        //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //   crossAxisAlignment: CrossAxisAlignment.end,
        //   children: [
        //     Text(
        //       'عملاء(دولار)',
        //       textAlign: TextAlign.center,
        //       style: Styles.headLineStyle4,
        //     ),
        //     Divider(
        //       color: ConstColors.dividerColor,
        //       thickness: 1,
        //     ),
        //     Text(
        //       'عملاء(سعودي)',
        //       style: Styles.headLineStyle4,
        //     ),
        //     Divider(
        //       color: ConstColors.dividerColor,
        //       thickness: 1,
        //     ),
        //     Text(
        //       'عام(محلي)',
        //       style: Styles.headLineStyle4,
        //     ),
        //     Divider(
        //       color: ConstColors.dividerColor,
        //       thickness: 1,
        //     ),
        //     Text(
        //       'موردين(محلي)',
        //       style: Styles.headLineStyle4,
        //     ),
        //   ],
        // ),
      ],
    );
  }
}
//
// showAlertDialogWidget({required BuildContext context}) {
//   Currencies _currencies = Get.put(Currencies());
//
//   List<Widget> _listCurrency() {
//     return _currencies.currencies
//         .map((element) => InkWell(
//               onTap: () {
//                 //print('element ${element.currencyName}');
//               },
//               child: Column(
//                 children: [
//                   Text(element.currencyName.toString()),
//                   Divider(
//                     color: ConstColors.dividerColor,
//                     thickness: 1,
//                   ),
//                 ],
//               ),
//             ))
//         .toList();
//   }
//
//   return AlertDialog(
//     //actionsPadding: EdgeInsets.all(MediaQuery.of(context).size.width * 0.05),
//     actions: [
//       _currencies.currencies.isNotEmpty
//           ? Column(
//               children: _listCurrency(),
//             )
//           : Center(
//               child: Text('Null'),
//             )
//       // Column(
//       //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//       //   crossAxisAlignment: CrossAxisAlignment.end,
//       //   children: [
//       //     Text(
//       //       'عملاء(دولار)',
//       //       textAlign: TextAlign.center,
//       //       style: Styles.headLineStyle4,
//       //     ),
//       //     Divider(
//       //       color: ConstColors.dividerColor,
//       //       thickness: 1,
//       //     ),
//       //     Text(
//       //       'عملاء(سعودي)',
//       //       style: Styles.headLineStyle4,
//       //     ),
//       //     Divider(
//       //       color: ConstColors.dividerColor,
//       //       thickness: 1,
//       //     ),
//       //     Text(
//       //       'عام(محلي)',
//       //       style: Styles.headLineStyle4,
//       //     ),
//       //     Divider(
//       //       color: ConstColors.dividerColor,
//       //       thickness: 1,
//       //     ),
//       //     Text(
//       //       'موردين(محلي)',
//       //       style: Styles.headLineStyle4,
//       //     ),
//       //   ],
//       // ),
//     ],
//   );
// }
