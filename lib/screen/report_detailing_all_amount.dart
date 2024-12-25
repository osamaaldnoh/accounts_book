import 'package:accounts_book/screen/data_table_detailing_all_amount.dart';
import 'package:accounts_book/screen/datatable_report_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../const/const_color.dart';
import '../controller/acc_groups.dart';
import '../controller/acc_restrichions.dart';
import '../model/acc_group.dart';
import '../widgets/main_widgets.dart';
import 'add_amount_screen.dart';

class ReportDetailingAllAmountScreen extends StatelessWidget {
  ReportDetailingAllAmountScreen({Key? key}) : super(key: key);
  final AccGroups accGroupsConttroller = Get.find();

  //final accR = Get.lazyPut(() => AccRestrichions(), fenix: true);
  final accRestrichionsConttroller = Get.find<AccRestrichions>();

  final PageController pageController = PageController(initialPage: 0);

  AccGroup accGroupModel = AccGroup();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: ConstColors.appBar,
        iconTheme: IconThemeData(
          color: ConstColors.iconappBar,
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
        leading: InkWell(
          onTap: () {
            Get.back();
            accGroupsConttroller.titleReport.value =
                accGroupsConttroller.accGroups.first.accGroupName!;
          },
          child: Icon(Icons.arrow_back_rounded),
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
              return DataTableDetailingAllAmount();
            },
          );
        },
      ),
    );
  }
}
// Positioned(
//   bottom: 0,
//   right: 0,
//   left: 0,
//   child: Container(
//     color: ConstColors.appBar,
//     padding: EdgeInsets.all(
//         MediaQuery.of(context).size.height * 0.01 / 5),
//     child: Row(
//       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//       children: [
//         Icon(
//           Icons.help_outline,
//           color: ConstColors.iconappBar,
//           size: MediaQuery.of(context).size.height * 0.03,
//         ),
//         Row(
//           children: [
//             Text(
//               'عليه:=0',
//               style: TextStyle(
//                 color: ConstColors.textColor,
//               ),
//             ),
//             Text(
//               'محلي',
//               style: TextStyle(
//                 color: ConstColors.textColor,
//               ),
//             ),
//           ],
//         ),
//         IconButton(
//           onPressed: () {
//             Navigator.push(
//               context,
//               MaterialPageRoute(builder: (_) => AddAmountScreen()),
//             );
//           },
//           icon: Icon(
//             Icons.add_circle_outline_sharp,
//             color: ConstColors.iconappBar,
//             size: MediaQuery.of(context).size.height * 0.03,
//           ),
//         ),
//       ],
//     ),
//   ),
// ),
