import 'package:accounts_book/controller/employess_controller.dart';
import 'package:accounts_book/screen/body_user_screen.dart';
import 'package:accounts_book/widgets/data_table_report_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../const/const_color.dart';
import '../controller/acc_groups.dart';
import '../controller/acc_restrichions.dart';
import '../controller/customers.dart';
import '../model/acc_group.dart';
import '../model/customer.dart';
import '../model/employee.dart';
import '../widgets/main_widgets.dart';
import 'add_amount_screen.dart';

// class DataTableReportScreen extends StatefulWidget {
//   @override
//   State<DataTableReportScreen> createState() => _DataTableReportScreenState();
// }

class DataTableReportScreen extends StatelessWidget {
  //RxBool isSort = false.obs;

  EmployessController _employessController = EmployessController();

  List<Employee> _employeeSort = [];

  int numberColumn = 0;
  int sumAmounts = 0;

  final accRestrichionsConttroller = Get.find<AccRestrichions>();
  final customersConttroller = Get.find<Customers>();

  //AccGroups accGroupsConttroller = Get.find();

  //AccGroup accGroupModel = AccGroup();

  Customer customerModel = Customer();

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: Colors.white.withOpacity(0.8),
        body: SafeArea(
          bottom: false,
          //top: false,
          child: Stack(
            children: [
              Container(
                height: double.infinity,
                child: SingleChildScrollView(
                  //physics: NeverScrollableScrollPhysics(),
                  child: Container(
                    color: ConstColors.dropdownMenuItemColor.withOpacity(0.01),
                    child: Column(
                      children: [
                        Container(
                          // padding: EdgeInsets.all(12),
                          // width: double.infinity,
                          //height: 100,
                          child: Row(
                            //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              SizedBox(
                                width: MediaQuery.of(context).size.width * 0.01,
                              ),
                              columnWidgets(
                                context: context,
                                nameColumn: 'الإسم',
                                width: MediaQuery.of(context).size.width *
                                    0.4 /
                                    1.1,
                                isSort: accRestrichionsConttroller.isSort.value,
                                columnSort: numberColumn == 0 ? '0' : '',
                                onTap: () =>
                                    accRestrichionsConttroller.onTapClick(
                                        isSorts:
                                            accRestrichionsConttroller.isSort,
                                        numColumn: 0),
                              ),
                              columnWidgets(
                                context: context,
                                nameColumn: 'المبلغ',
                                width: MediaQuery.of(context).size.width *
                                    0.3 /
                                    1.2,
                                isSort: accRestrichionsConttroller.isSort.value,
                                columnSort: numberColumn == 1 ? '1' : '',
                                onTap: () =>
                                    accRestrichionsConttroller.onTapClick(
                                        isSorts:
                                            accRestrichionsConttroller.isSort,
                                        numColumn: 1),
                              ),
                              Container(
                                child: columnIconWidget(
                                  iconColumn: Icons.edit_location,
                                ),
                              ),
                              columnWidgets(
                                context: context,
                                nameColumn: 'عددالإيام',
                                width: MediaQuery.of(context).size.width *
                                    0.4 /
                                    1.3,
                                isSort: accRestrichionsConttroller.isSort.value,
                                columnSort: numberColumn == 2 ? '2' : '',
                                onTap: () =>
                                    accRestrichionsConttroller.onTapClick(
                                        isSorts:
                                            accRestrichionsConttroller.isSort,
                                        numColumn: 2),
                              ),
                            ],
                          ),
                          color: ConstColors.dropdownColor,
                        ),
                        Container(
                          child: Obx(
                            () {
                              return accRestrichionsConttroller
                                      .accRestrForAccGroupsReport.isNotEmpty
                                  ? SingleChildScrollView(
                                      // physics: ScrollPhysics(),
                                      child: Container(
                                          width: double.infinity,
                                          alignment: Alignment.centerLeft,
                                          child: ListView.builder(
                                            physics: ScrollPhysics(),
                                            shrinkWrap: true,
                                            itemCount:
                                                accRestrichionsConttroller
                                                    .accRestrForAccGroupsReport
                                                    .length,
                                            itemBuilder: (context, index) {
                                              sumAmounts =
                                                  accRestrichionsConttroller
                                                      .getSumAmountCustomer(
                                                          index);
                                              customerModel =
                                                  customersConttroller.findById(
                                                      accRestrichionsConttroller
                                                          .accRestrForAccGroupsReport[
                                                              index]
                                                          .customerId!);

                                              return Column(
                                                children: [
                                                  dataRowExpListTile(
                                                      create_at:
                                                          '${customerModel.customerName}',
                                                      amount: '${sumAmounts}',
                                                      iconData:
                                                          Icons.expand_more,
                                                      numDays: accRestrichionsConttroller
                                                          .accRestrForAccGroupsReport[
                                                              index]
                                                          .customerId
                                                          .toString(),
                                                      firstsizeWidget:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .width *
                                                              0.4 /
                                                              1.2,
                                                      scoundSizeWidget:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .width *
                                                              0.2 /
                                                              1.1,
                                                      iconSizeWidget:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .width *
                                                              0.2,
                                                      context: context,
                                                      bodyExpanded:
                                                          ListView.builder(
                                                              shrinkWrap: true,
                                                              itemCount: accRestrichionsConttroller
                                                                  .cus.length,
                                                              itemBuilder:
                                                                  (ctx, inde) {
                                                                return bodyExpansionPanelRadio(
                                                                  isCredit:
                                                                      accRestrichionsConttroller.cus[inde].credit ==
                                                                              0
                                                                          ? false
                                                                          : true,
                                                                  context:
                                                                      context,
                                                                  fristText: accRestrichionsConttroller
                                                                      .cus[inde]
                                                                      .registerdon!,
                                                                  amount: accRestrichionsConttroller
                                                                              .cus[
                                                                                  inde]
                                                                              .credit !=
                                                                          0
                                                                      ? accRestrichionsConttroller
                                                                          .cus[
                                                                              inde]
                                                                          .credit
                                                                          .toString()
                                                                      : accRestrichionsConttroller
                                                                          .cus[
                                                                              inde]
                                                                          .debit
                                                                          .toString(),
                                                                  iconData: accRestrichionsConttroller
                                                                              .cus[
                                                                                  inde]
                                                                              .credit ==
                                                                          0
                                                                      ? Icons
                                                                          .expand_more
                                                                      : Icons
                                                                          .expand_less,
                                                                  numDays:
                                                                      'numDays',
                                                                  firstsizeWidget:
                                                                      MediaQuery.of(context)
                                                                              .size
                                                                              .width *
                                                                          0.4 /
                                                                          1.2,
                                                                );
                                                              })),
                                                  Divider(
                                                    color: ConstColors
                                                        .dividerColor,
                                                    thickness: 1,
                                                    height: 1,
                                                  ),
                                                ],
                                              );
                                            },
                                          )),
                                    )
                                  : Container();
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
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
              //             Obx(() {
              //               return Text(
              //                 'عليك:=${accRestrichionsConttroller.credied} لك:=${accRestrichionsConttroller.debited}',
              //                 //style: Styles.headLineStyle3,
              //               );
              //             }),
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
              //               MaterialPageRoute(
              //                   builder: (_) => AddAmountScreen()),
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
            ],
          ),
        ),
      ),
    );
  }

  // onTapClick({required RxBool isSorts, required int numColumn}) {
  //   numberColumn = numColumn;
  //   print('numColumn : $numberColumn');
  //   print(isSorts);
  //   if (accRestrichionsConttroller.isSort.value == false) {
  //     accRestrichionsConttroller.isSort.value = true;
  //     print(accRestrichionsConttroller.isSort);
  //     accRestrichionsConttroller.accRestrForAccGroupsReport
  //         .sort((a, b) => b.accRestrichionId!.compareTo(a.accRestrichionId!));
  //     accRestrichionsConttroller.accRestrForAccGroupsReport.forEach((element) {
  //       print(element.accRestrichionDetails);
  //     });
  //
  //     //_employeeSort = _employessController.sortEmploys(isSort: isSort.value);
  //   } else {
  //     accRestrichionsConttroller.isSort.value = false;
  //     accRestrichionsConttroller.accRestrForAccGroupsReport
  //         .sort((a, b) => a.customerId!.compareTo(b.customerId!));
  //     accRestrichionsConttroller.accRestrForAccGroupsReport.forEach((element) {
  //       print(element.accRestrichionDetails);
  //     });
  //
  //     //_employeeSort = _employessController.sortEmploys(isSort: isSort.value);
  //     // _employeeSort.sort(
  //     //   (a, b) => a.id.compareTo(b.id),
  //     // );
  //   }
  // }
}
