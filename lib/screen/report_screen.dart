import 'package:accounts_book/api/routes_class.dart';
import 'package:accounts_book/controller/acc_groups.dart';
import 'package:accounts_book/screen/datatable_report_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/instance_manager.dart';

import '../const/const_color.dart';
import '../controller/acc_restrichions.dart';
import '../model/acc_group.dart';
import '../model/acc_restrichion.dart';
import '../widgets/main_widgets.dart';
import 'add_amount_screen.dart';

class ReportScreen extends StatelessWidget {
  final AccGroups accGroupsConttroller = Get.find();

  //final accR = Get.lazyPut(() => AccRestrichions(), fenix: true);
  final accRestrichionsConttroller = Get.find<AccRestrichions>();

  final PageController pageController =
      PageController(initialPage: 0, viewportFraction: 1, keepPage: false);

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
            // accGroupModel = accGroupsConttroller
            //     .findByName(accGroupsConttroller.title.value);
            // accRestrichionsConttroller
            //     .getAccGroupIdData(accGroupModel.accGroupId!);
            // accRestrichionsConttroller.getAccGroupIdData(accGroupId)
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

          print('Name:${accGroupModel.accGroupName}');
          accRestrichionsConttroller.accRestrichions.isNotEmpty
              ? accRestrichionsConttroller
                  .getAccGroupIdDataReport(accGroupModel.accGroupId!)
              : accGroupModel;

          //accRestrichionsConttroller.getAccRestrichionCredied();
          //accRestrichionsConttroller.getAccRestrichionCredied();
          return PageView.builder(
            // controller: pageController,
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
              return DataTableReportScreen();
            },
          );
        },
      ),
    );
  }
}
