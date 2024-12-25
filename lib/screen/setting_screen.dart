import 'package:accounts_book/const/const_color.dart';
import 'package:accounts_book/screen/currencies_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../widgets/alert_dialog_widget.dart';
import 'acc_groups_screen.dart';

class SettingScreen extends StatelessWidget {
  const SettingScreen({Key? key}) : super(key: key);

  ShowDialog(BuildContext context) {
    showDialog(
        context: context,
        builder: (_) => showAlertDialogWidget(context: context));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ConstColors.wihteColor,
      appBar: AppBar(
        backgroundColor: ConstColors.appBar,
        elevation: 0,
        iconTheme: IconThemeData(
          color: ConstColors.iconappBar,
        ),
        title: Text(
          'Settings',
          style: TextStyle(
            color: ConstColors.textColor,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Column(
        children: [
          ListView.builder(
            shrinkWrap: true,
            itemCount: iconSetting.length,
            itemBuilder: (context, index) {
              return InkWell(
                onTap: () {
                  index == 3
                      ? Get.toNamed(AccGroupsScreen.routeName)
                      : index == 4
                          ? Get.toNamed(CurrenciesScreen.routeName)
                          : Get.toNamed(
                              CurrenciesScreen.routeName,
                            );
                },
                child: ListTile(
                  title: Text(nameSetting[index]),
                  leading: Icon(
                    iconSetting[index],
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}

List iconSetting = [
  Icons.dataset,
  Icons.print,
  Icons.lock,
  Icons.eighteen_up_rating,
  Icons.currency_exchange_outlined,
  Icons.save_as_outlined,
  Icons.laptop,
  Icons.settings,
];

List nameSetting = [
  'البيانات الشخصية',
  'خيارات الطباعة ',
  'خيارات الامان',
  'التصنيفات',
  'العملات',
  'خيارات حفظ البيانات',
  'إستعراض البيانات من الكمبيوتر',
  'خيارات أخرى',
];
