import 'package:accounts_book/api/routes_class.dart';
import 'package:accounts_book/screen/add_amount_screen.dart';
import 'package:flutter/material.dart';

import '../model/drawar_model.dart';
import '../screen/monthly_report_screen.dart';
import '../screen/report_detailing_all_amount.dart';
import '../screen/report_screen.dart';
import '../screen/setting_screen.dart';

class DrawersController {
  List<DrawarModel> get drawerMode => [..._drawerMode];
  List<DrawarModel> _drawerMode = [
    DrawarModel(id: 1, text: 'أضافة مبلغ', iconData: Icons.add),
    DrawarModel(
        id: 2, text: 'تقرير-إجمالي المبالغ', iconData: Icons.calendar_month),
    DrawarModel(
        id: 3, text: 'تقرير-تفاصيل كل المبالغ', iconData: Icons.calendar_month),
    DrawarModel(
        id: 4,
        text: 'تقرير-إجمالي المبالغ شهريا',
        iconData: Icons.calendar_month),
    DrawarModel(
        id: 5, text: 'تقرير-إجمالي التصنيفات', iconData: Icons.calendar_month),
    DrawarModel(
        id: 6, text: 'تقرير-حركة الحسابات', iconData: Icons.calendar_month),
    DrawarModel(
        id: 7, text: 'حفظ نسخة إحتياطية', iconData: Icons.upload_outlined),
    DrawarModel(
        id: 8, text: 'إسترجاع قاعدة البيانات', iconData: Icons.backup_outlined),
    DrawarModel(id: 9, text: 'جوجل درايف', iconData: Icons.drafts_outlined),
    DrawarModel(id: 10, text: 'إعدادات', iconData: Icons.settings),
    DrawarModel(id: 11, text: 'للتواصل والدعم', iconData: Icons.phone_rounded),
    DrawarModel(
        id: 12, text: 'حول البرنامج', iconData: Icons.help_outline_sharp),
    DrawarModel(id: 13, text: 'مشاركة البرنامج', iconData: Icons.share),
    DrawarModel(id: 14, text: 'خروج', iconData: Icons.logout),
  ];

  List drawerScreen = [
    RoutesClass.getaddAmountScreenRoute(),
    RoutesClass.getReportScreenRoute(),
    RoutesClass.getreportDetailingAllAmountsRoute(),
    RoutesClass.getmonthlyTotalAmountsReportRoute(),
    RoutesClass.getaddAmountScreenRoute(),
    RoutesClass.getaddAmountScreenRoute(),
    RoutesClass.getaddAmountScreenRoute(),
    RoutesClass.getaddAmountScreenRoute(),
    RoutesClass.getaddAmountScreenRoute(),
    RoutesClass.getsettingRoute(),
    RoutesClass.getaddAmountScreenRoute(),
    RoutesClass.getaddAmountScreenRoute(),
    RoutesClass.getaddAmountScreenRoute(),
    RoutesClass.getaddAmountScreenRoute(),
  ];
}
