import 'package:accounts_book/const/const_color.dart';
import 'package:accounts_book/controller/acc_groups.dart';
import 'package:accounts_book/controller/acc_restrichions.dart';
import 'package:accounts_book/model/acc_group.dart';
import 'package:accounts_book/screen/all_screen.dart';
import 'package:accounts_book/widgets/app_bar_widget.dart';
import 'package:accounts_book/widgets/drawer_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/instance_manager.dart';
import '../model/acc_restrichion.dart';
import '../widgets/alert_dialog_widget.dart';

class MainScreen extends StatelessWidget {
  MainScreen({Key? key}) : super(key: key);

  final AccGroups accGroupsConttroller = Get.find();
  final AccRestrichions accRestrichionsConttroller = Get.find();

  final pageController = PageController(initialPage: 0);
  AccGroup accGroupModel = AccGroup();
  AccRestrichion accRestrichion = AccRestrichion();

  @override
  Widget build(BuildContext context) {
    // accGroupModel = _accGroups.accGroups.isNotEmpty
    //     ? _accGroups.findById(_accGroups.accGroupsId.value)
    //     : accGroupModel;
    // _accRestrichions.accRestrichions.isNotEmpty
    //     ? _accRestrichions.AccRestrichionCredit(accGroupModel.accGroupId!)
    //     : accRestrichion;
    // print(accGroupModel.accGroupId);
    return OrientationBuilder(builder: (ctx, orientation) {
      final isPortrait = orientation == Orientation.portrait;

      return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBarWidget(
            context: context,
            title: accGroupsConttroller.title,
            icon1: Icons.search,
            icon2: Icons.notifications_active,
            icon3: Icons.filter_list,
            isPortrait: isPortrait,
            onTapIcon3: () {
              showDialog(
                context: context,
                builder: (context) => showAlertDialogWidget(context: context),
              );
            }),
        drawer: Drawer(
          elevation: 0,
          backgroundColor: ConstColors.drawerColor,
          child: DrawerWidget(),
        ),
        body: Obx(() {
          //print('Osama');
          accGroupModel = accGroupsConttroller.accGroups.isNotEmpty
              ? accGroupsConttroller
                  .findByName(accGroupsConttroller.title.value)
              : accGroupModel;
          print('AccId : ${accGroupModel!.accGroupId}');
          accRestrichionsConttroller.accRestrichions.isNotEmpty
              ? accRestrichionsConttroller
                  .getAccGroupIdData(accGroupModel.accGroupId!)
              : accRestrichionsConttroller;
          //accRestrichionsConttroller.getAccRestrichionCredied();
          return PageView.builder(
            controller: pageController,
            itemCount: accGroupsConttroller.accGroups.isNotEmpty
                ? accGroupsConttroller.accGroups.length
                : 1,
            onPageChanged: (int page) {
              accGroupsConttroller.title.value =
                  accGroupsConttroller.accGroups[page].accGroupName!;
            },
            itemBuilder: (context, index) {
              return AllScreen(
                pageNumper: accGroupsConttroller.accGroupsId,
              );
            },
          );
        }),
      );
    });
  }
}
// Positioned(
//   bottom: 0,
//   right: 0,
//   left: 0,
//   child: Container(
//     color: ConstColors.drawerColor,
//     padding: EdgeInsets.symmetric(
//       horizontal: MediaQuery.of(context).size.height * 0.01,
//       vertical: MediaQuery.of(context).size.height * 0.01 / 1.8,
//     ),
//     child: Row(
//       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//       crossAxisAlignment: CrossAxisAlignment.center,
//       children: [
//         Icon(
//           Icons.help_outline,
//           color: ConstColors.iconappBar,
//           size: MediaQuery.of(context).size.height * 0.04,
//         ),
//         Obx(() {
//           // accGroupModel = _accGroups.accGroupp;
//
//           int v = _accRestrichions.credied.value != 0
//               ? _accRestrichions.credied.value
//               : 0;
//           print('Creadet : ${v}');
//           return Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             crossAxisAlignment: CrossAxisAlignment.center,
//             children: [
//               Text(
//                 'عليك:=${_accRestrichions.credied.value} لك:=',
//                 style: Styles.headLineStyle3,
//               ),
//               Text(
//                 'محلي',
//                 style: Styles.headLineStyle3,
//               ),
//             ],
//           );
//         }),
//         InkWell(
//           onTap: () {
//             Navigator.push(
//               context,
//               MaterialPageRoute(
//                   builder: (_) => AddAmountScreen()),
//             );
//           },
//           child: Icon(
//             Icons.add_circle_outline_sharp,
//             color: ConstColors.iconappBar,
//             size: MediaQuery.of(context).size.height * 0.04,
//           ),
//         ),
//       ],
//     ),
//   ),
// ),
