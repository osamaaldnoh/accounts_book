import 'package:flutter/material.dart';

import '../const/const_color.dart';
import '../controller/employess_controller.dart';
import '../model/employee.dart';
import '../widgets/bottom_widget.dart';
import '../widgets/data_table_report_widget.dart';
import 'add_amount_screen.dart';

class TotalMonthlyAmountsScreen extends StatefulWidget {
  const TotalMonthlyAmountsScreen({Key? key}) : super(key: key);

  @override
  State<TotalMonthlyAmountsScreen> createState() =>
      _TotalMonthlyAmountsScreenState();
}

class _TotalMonthlyAmountsScreenState extends State<TotalMonthlyAmountsScreen> {
  int numberColumn = 0;
  bool isSort = false;
  EmployessController _employessController = EmployessController();
  List<Employee> _employeeSort = [];

  @override
  void initState() {
    _employeeSort = _employessController.employee;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ConstColors.backGroundColor,
      body: Directionality(
        textDirection: TextDirection.rtl,
        child: SingleChildScrollView(
          child: Container(
            color: ConstColors.dropdownMenuItemColor.withOpacity(0.1),
            child: Column(
              children: [
                Container(
                  // padding: EdgeInsets.all(15),
                  // padding: EdgeInsets.only(
                  //   top: 15,
                  //   bottom: 15,
                  //   //left: 20,
                  // ),
                  child: Row(
                    //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.01,
                      ),
                      columnWidgets(
                        context: context,
                        nameColumn: 'الشهر',
                        width: MediaQuery.of(context).size.width * 0.4 / 1.2,
                        isSort: isSort,
                        columnSort: numberColumn == 0 ? '0' : '',
                        onTap: () => onTapClick(isSorts: isSort, numColumn: 0),
                      ),
                      columnWidgets(
                        context: context,
                        nameColumn: 'المبلغ',
                        width: MediaQuery.of(context).size.width * 0.3 / 1.3,
                        isSort: isSort,
                        columnSort: numberColumn == 1 ? '1' : '',
                        onTap: () => onTapClick(isSorts: isSort, numColumn: 1),
                      ),
                      Container(
                        child: columnIconWidget(iconColumn: Icons.expand_less),
                      ),
                      columnWidgets(
                        context: context,
                        nameColumn: 'الرصيد',
                        width: MediaQuery.of(context).size.width * 0.4 / 1.3,
                        isSort: isSort,
                        columnSort: numberColumn == 2 ? '2' : '',
                        onTap: () => onTapClick(isSorts: isSort, numColumn: 2),
                      ),
                    ],
                  ),
                  color: ConstColors.dropdownColor,
                ),
                SingleChildScrollView(
                    child: Container(
                  color: ConstColors.dropdownMenuItemColor.withOpacity(0.01),
                  child: ListView.separated(
                    physics: ScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: 1,
                    itemBuilder: (context, index) {
                      return dataRowExpListTile(
                          create_at: _employeeSort[index].data,
                          amount: _employeeSort[index].designation,
                          iconData: Icons.expand_more,
                          numDays: _employeeSort[index].designation,
                          //employee: _employeeSort,
                          firstsizeWidget:
                              MediaQuery.of(context).size.width * 0.4 / 1.2,
                          scoundSizeWidget:
                              MediaQuery.of(context).size.width * 0.2 / 1.1,
                          iconSizeWidget:
                              MediaQuery.of(context).size.width * 0.2 / 1.9,
                          context: context,
                          bodyExpanded: ListView.builder(
                              shrinkWrap: true,
                              itemCount: _employeeSort.length,
                              itemBuilder: (ctx, index) {
                                return bodyExpansionPanelRadio(
                                  isCredit: true,
                                  context: context,
                                  fristText: _employeeSort[index].name,
                                  amount: 'amount',
                                  iconData: Icons.expand_more,
                                  numDays: 'numDays',
                                  firstsizeWidget:
                                      MediaQuery.of(context).size.width *
                                          0.4 /
                                          1.2,
                                );
                              }));
                    },
                    separatorBuilder: (BuildContext context, int index) {
                      return Divider(
                        color: ConstColors.dividerColor,
                        thickness: 1,
                        height: 1,
                      );
                    },
                  ),
                )),
              ],
            ),
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
