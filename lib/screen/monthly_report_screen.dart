import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../const/const_color.dart';
import '../controller/acc_groups.dart';
import '../controller/acc_restrichions.dart';
import '../model/acc_group.dart';
import '../widgets/main_widgets.dart';
import '../widgets/bottom_widget.dart';
import 'add_amount_screen.dart';
import 'datatable_report_screen.dart';
import 'total_monthly_amounts_screen.dart';

class MonthlyReportScreen extends StatelessWidget {
  MonthlyReportScreen({Key? key}) : super(key: key);
  final AccGroups accGroupsConttroller = Get.find();

  //final accR = Get.lazyPut(() => AccRestrichions(), fenix: true);
  final accRestrichionsConttroller = Get.find<AccRestrichions>();

  final PageController pageController = PageController(initialPage: 0);

  AccGroup accGroupModel = AccGroup();

  // AccRestrichion? accRestrichion ;

  @override
  Widget build(BuildContext context) {
    // accRestrichionsConttroller.getAccRestrichionCredied();

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: ConstColors.appBar,
        iconTheme: IconThemeData(
          color: ConstColors.iconappBar,
        ),
        leading: InkWell(
          onTap: () {
            Get.back();
            accGroupsConttroller.titleReport.value =
                accGroupsConttroller.accGroups.first.accGroupName!;
          },
          child: Icon(Icons.arrow_back_rounded),
        ),
        title: Obx(
          () => Text(
            accGroupsConttroller.accGroups.isNotEmpty
                ? accGroupsConttroller.titleReport.value
                : '',
            style: TextStyle(
              color: ConstColors.textColor,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        actions: [
          Iconwidget(
            context: context,
            iconData: Icons.search,
          ),
          Iconwidget(
            context: context,
            iconData: Icons.picture_as_pdf,
          ),
          Iconwidget(
            context: context,
            iconData: Icons.list,
          ),
        ],
      ),
      body: Obx(
        () {
          accGroupModel = accGroupsConttroller
              .findByName(accGroupsConttroller.titleReport.value);
          ;

          print('Name:${accGroupModel.accGroupName}');
          accRestrichionsConttroller.accRestrichions.isNotEmpty
              ? accRestrichionsConttroller
                  .getAccGroupIdDataReport(accGroupModel.accGroupId!)
              : accGroupModel;

          //accRestrichionsConttroller.getAccRestrichionCredied();
          //accRestrichionsConttroller.getAccRestrichionCredied();
          return PageView.builder(
            controller: pageController,
            itemCount: accGroupsConttroller.accGroups.isNotEmpty
                ? accGroupsConttroller.accGroups.length
                : 1,
            onPageChanged: (int page) {
              accGroupsConttroller.titleReport.value =
                  accGroupsConttroller.accGroups[page].accGroupName!;
              // accGroupModel = accGroupsConttroller
              //     .findByName(accGroupsConttroller.title.value!);
            },
            itemBuilder: (context, index) {
              return TotalMonthlyAmountsScreen();
            },
          );
        },
      ),
    );
  }
}
