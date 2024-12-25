import 'package:accounts_book/api/my_bindings.dart';
import 'package:accounts_book/screen/add_amount_screen.dart';
import 'package:accounts_book/screen/details_of_all_amounts_screen.dart';
import 'package:accounts_book/screen/main_screen.dart';
import 'package:accounts_book/screen/monthly_report_screen.dart';
import 'package:accounts_book/screen/report_detailing_all_amount.dart';
import 'package:accounts_book/screen/report_screen.dart';
import 'package:accounts_book/screen/setting_screen.dart';
import 'package:accounts_book/screen/body_user_screen.dart';
import 'package:get/get.dart';

import '../screen/acc_groups_screen.dart';
import '../screen/currencies_screen.dart';
import '../screen/user_screen.dart';

class RoutesClass {
  static String home = '/';
  static String accGroupOrCurrencies = '/accGroupOrCurrencies';
  static String accGroupsScreen = '/accGroupsScreen';
  static String addAmountScreen = '/addAmountScreen';
  static String reportScreen = '/reportScreen';
  static String totalAmountsReport = '/totalAmountsReport';
  static String reportDetailingAllAmounts = '/reportDetailingAllAmounts';
  static String monthlyTotalAmountsReport = '/monthlyTotalAmountsReport';
  static String totalRatingsReport = '/totalRatingsReport';
  static String accountsMovementReport = '/accountsMovementReport';
  static String save_a_Backup = '/save_a_Backup';
  static String databaseRecovery = '/databaseRecovery';
  static String googleDrive = '/googleDrive';
  static String setting = '/setting';
  static String communicationAndSupport = '/communicationAndSupport';
  static String aboutTheProgram = '/aboutTheProgram';
  static String programSharing = '/programSharing';
  static String exit = '/exit';
  static String userScreen = '/userScreen';
  static String getHomeRoute() => home;
  static String getAccGroupOrCurrenciesRoute() => accGroupOrCurrencies;
  static String getAccGroupsScreenRoute() => accGroupsScreen;
  static String getReportScreenRoute() => reportScreen;
  static String getaddAmountScreenRoute() => addAmountScreen;
  static String gettotalAmountsReportRoute() => totalAmountsReport;
  static String getreportDetailingAllAmountsRoute() =>
      reportDetailingAllAmounts;
  static String getmonthlyTotalAmountsReportRoute() =>
      monthlyTotalAmountsReport;
  static String gettotalRatingsReportRoute() => totalRatingsReport;
  static String getaccountsMovementReportRoute() => accountsMovementReport;
  static String getsave_a_BackupRoute() => save_a_Backup;
  static String getdatabaseRecoveryRoute() => databaseRecovery;
  static String getgoogleDriveRoute() => googleDrive;
  static String getsettingRoute() => setting;
  static String getcommunicationAndSupportRoute() => communicationAndSupport;
  static String getaboutTheProgramRoute() => aboutTheProgram;
  static String getprogramSharingRoute() => programSharing;
  static String getexitRoute() => exit;
  static String getUserScreenRoute() => userScreen;

  static List<GetPage> routes = [
    GetPage(name: home, page: () => MainScreen(), binding: MyBindings()),
    GetPage(name: accGroupOrCurrencies, page: () => CurrenciesScreen()),
    GetPage(name: accGroupsScreen, page: () => AccGroupsScreen()),
    GetPage(
        name: reportScreen, page: () => ReportScreen(), binding: MyBindings()),
    GetPage(
        name: addAmountScreen,
        page: () => AddAmountScreen(),
        binding: MyBindings()),
    GetPage(name: totalAmountsReport, page: () => CurrenciesScreen()),
    GetPage(
        name: reportDetailingAllAmounts,
        page: () => ReportDetailingAllAmountScreen()),
    GetPage(name: monthlyTotalAmountsReport, page: () => MonthlyReportScreen()),
    GetPage(name: setting, page: () => SettingScreen(), binding: MyBindings()),
    GetPage(name: userScreen, page: () => UserScreen()),
  ];
}
