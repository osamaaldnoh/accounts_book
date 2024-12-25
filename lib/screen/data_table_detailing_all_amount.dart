import 'package:accounts_book/controller/customers.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../const/const_color.dart';
import '../controller/acc_restrichions.dart';
import '../controller/employess_controller.dart';
import '../model/customer.dart';
import '../model/employee.dart';
import '../widgets/data_table_report_widget.dart';

class DataTableDetailingAllAmount extends StatefulWidget {
  const DataTableDetailingAllAmount({Key? key}) : super(key: key);

  @override
  State<DataTableDetailingAllAmount> createState() =>
      _DataTableDetailingAllAmountState();
}

class _DataTableDetailingAllAmountState
    extends State<DataTableDetailingAllAmount> {
  final accRestrichionsConttroller = Get.find<AccRestrichions>();
  final customerController = Get.find<Customers>();
  Customer? customer;

  bool isSort = false;
  EmployessController _employessController = EmployessController();
  List<Employee> _employeeSort = [];
  int numberColumn = 0;

  @override
  void initState() {
    _employeeSort = _employessController.employee;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: ConstColors.wihteColor,
        body: SafeArea(
          //bottom: false,
          child: Column(
            children: [
              Expanded(
                child: Container(
                  child: SingleChildScrollView(
                    child: Container(
                      color: ConstColors.backGroundCircle.withOpacity(0.05),
                      child: Column(
                        children: [
                          Container(
                            child: Row(
                              // mainAxisAlignment: MainAxisAlignment.s,
                              children: [
                                // SizedBox(
                                //   width: MediaQuery.of(context).size.width * 0.01,
                                // ),
                                columnWidgets(
                                  context: context,
                                  nameColumn: 'التاريخ',
                                  width: MediaQuery.of(context).size.width *
                                      0.4 /
                                      1.6,
                                  isSort: isSort,
                                  columnSort: numberColumn == 0 ? '0' : '',
                                  onTap: () =>
                                      onTapClick(isSorts: isSort, numColumn: 0),
                                ),
                                columnWidgets(
                                  context: context,
                                  nameColumn: 'الإسم',
                                  width: MediaQuery.of(context).size.width *
                                      0.3 /
                                      1.3,
                                  isSort: isSort,
                                  columnSort: numberColumn == 1 ? '1' : '',
                                  onTap: () =>
                                      onTapClick(isSorts: isSort, numColumn: 1),
                                ),
                                columnWidgets(
                                  context: context,
                                  nameColumn: 'المبلغ',
                                  width: MediaQuery.of(context).size.width *
                                      0.3 /
                                      1.5,
                                  isSort: isSort,
                                  columnSort: numberColumn == 2 ? '2' : '',
                                  onTap: () =>
                                      onTapClick(isSorts: isSort, numColumn: 2),
                                ),
                                columnWidgets(
                                  context: context,
                                  nameColumn: 'التفاصيل',
                                  width: MediaQuery.of(context).size.width *
                                      0.3 /
                                      1.2,
                                  isSort: isSort,
                                  columnSort: numberColumn == 3 ? '3' : '',
                                  onTap: () =>
                                      onTapClick(isSorts: isSort, numColumn: 3),
                                ),
                                Expanded(
                                  child: Container(
                                    padding: EdgeInsets.only(
                                      left: 10,
                                    ),
                                    child: columnIconWidget(
                                        iconColumn: Icons.expand_less),
                                  ),
                                ),
                              ],
                            ),
                            color: ConstColors.dropdownColor,
                          ),
                          SingleChildScrollView(
                              child: Obx(
                            () => Container(
                              width: double.infinity,
                              alignment: Alignment.centerLeft,
                              child: ListView.builder(
                                physics: ScrollPhysics(),
                                shrinkWrap: true,
                                itemCount: accRestrichionsConttroller
                                    .accRestrReportForCostomer.length,
                                itemBuilder: (context, index) {
                                  customer = customerController.findById(
                                      accRestrichionsConttroller
                                          .accRestrReportForCostomer[index]
                                          .customerId!);

                                  return Column(
                                    children: [
                                      Container(
                                        padding: EdgeInsets.all(
                                          10,
                                        ),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            SizedBox(
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  0.4 /
                                                  1.8,
                                              child: Container(
                                                child: Text(
                                                  '${accRestrichionsConttroller.accRestrReportForCostomer[index].registerdon}',
                                                  textAlign: TextAlign.center,
                                                ),
                                              ),
                                            ),
                                            SizedBox(
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  0.3 /
                                                  1.4,
                                              child: Container(
                                                child: Text(
                                                  '${customer!.customerName}',
                                                  textAlign: TextAlign.center,
                                                ),
                                              ),
                                            ),
                                            SizedBox(
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  0.3 /
                                                  1.7,
                                              child: Container(
                                                child: Text(
                                                  '${accRestrichionsConttroller.accRestrReportForCostomer[index].credit == 0 ? accRestrichionsConttroller.accRestrReportForCostomer[index].debit : accRestrichionsConttroller.accRestrReportForCostomer[index].credit}',
                                                  textAlign: TextAlign.center,
                                                ),
                                              ),
                                            ),
                                            SizedBox(
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  0.3 /
                                                  1.4,
                                              child: Container(
                                                child: Text(
                                                  '${accRestrichionsConttroller.accRestrReportForCostomer[index].accRestrichionDetails}',
                                                  textAlign: TextAlign.center,
                                                ),
                                              ),
                                            ),
                                            Container(
                                              child: Icon(Icons.expand_less),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Divider(
                                        color: ConstColors.dividerColor,
                                        thickness: 1,
                                        height: 1,
                                      ),
                                    ],
                                  );
                                },
                              ),
                            ),
                          )),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              Container(
                color: ConstColors.appBar,
                padding: EdgeInsets.all(
                    MediaQuery.of(context).size.height * 0.01 / 5),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Icon(
                      Icons.help_outline,
                      color: ConstColors.iconappBar,
                      size: MediaQuery.of(context).size.height * 0.03,
                    ),
                    Row(
                      children: [
                        Text(
                          'عليه:=0',
                          style: TextStyle(
                            color: ConstColors.textColor,
                          ),
                        ),
                        Text(
                          'محلي',
                          style: TextStyle(
                            color: ConstColors.textColor,
                          ),
                        ),
                      ],
                    ),
                    IconButton(
                      onPressed: () {
                        // Navigator.push(
                        //   context,
                        //   MaterialPageRoute(builder: (_) => AddAmountScreen()),
                        // );
                      },
                      icon: Icon(
                        Icons.add_circle_outline_sharp,
                        color: ConstColors.iconappBar,
                        size: MediaQuery.of(context).size.height * 0.03,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  onTapClick({required bool isSorts, required int numColumn}) {
    numberColumn = numColumn;
    print('numColumn : $numberColumn');

    setState(() {
      if (isSort == false) {
        isSort = true;
        _employeeSort = _employessController.sortEmploys(isSort: isSort);
      } else {
        isSort = false;
        _employeeSort = _employessController.sortEmploys(isSort: isSort);
        // _employeeSort.sort(
        //   (a, b) => a.id.compareTo(b.id),
        // );
      }
    });
  }
}
