import 'package:accounts_book/const/const_color.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controller/acc_restrichions.dart';
import '../model/acc_restrichion.dart';
import '../screen/datatable_report_screen.dart';
import '../widgets/data_table_report_widget.dart';
import '../widgets/main_widgets.dart';

class BodyUserScreen extends StatelessWidget {
  BodyUserScreen({Key? key}) : super(key: key);

  final AccRestrichions accRestrichionsConttroller = Get.find();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Directionality(
        textDirection: TextDirection.rtl,
        child: Container(
          color: ConstColors.dropdownMenuItemColor.withOpacity(0.01),
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.all(15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    columnWidget(nameColumn: 'التاريخ'),
                    columnWidget(nameColumn: 'المبلغ'),
                    columnWidget(nameColumn: 'التفاصيل'),
                    columnIconWidget(iconColumn: Icons.expand_less),
                    columnWidget(nameColumn: 'الرصيد'),
                  ],
                ),
                color: ConstColors.dropdownColor,
              ),
              Obx(
                () => ListView.builder(
                  itemCount: accRestrichionsConttroller.cus.length,
                  shrinkWrap: true,
                  itemBuilder: (ctx, index) {
                    return Column(
                      children: [
                        Container(
                          padding: EdgeInsets.all(
                            MediaQuery.of(context).size.width * 0.03,
                          ),
                          //  margin: EdgeInsets.symmetric(horizontal: 30),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              SizedBox(
                                width: MediaQuery.of(context).size.width * 0.2,
                                child: Text(
                                  accRestrichionsConttroller
                                      .cus[index].registerdon!,
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                              ),
                              Expanded(
                                child: Text(
                                  '${accRestrichionsConttroller.cus[index].credit == 0 ? accRestrichionsConttroller.cus[index].debit : accRestrichionsConttroller.cus[index].credit}',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              Expanded(
                                child: Text(
                                  accRestrichionsConttroller
                                      .cus[index].accRestrichionDetails!,
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              Expanded(
                                child: Icon(Icons.expand_more_outlined),
                              ),
                              Expanded(
                                child: Text(
                                  'Total',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Divider(
                          color: ConstColors.dividerColor,
                        ),
                      ],
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

Widget kTableColumn(
    {String? nameColu,
    String? nameColu2,
    String? nameColu3,
    IconData? iconData,
    String? nameColu4}) {
  return Container(
    padding: const EdgeInsets.all(5.0),
    margin: EdgeInsets.all(5),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        InkWell(
          onTap: () {},
          child: Container(
            alignment: Alignment.center,
            child: Row(
              children: [
                Text(
                  nameColu != null ? '{$nameColu}' : 'Name',
                  textAlign: TextAlign.center,
                ),
                Icon(Icons.expand_less),
              ],
            ),
          ),
        ),
        Container(
            alignment: Alignment.center,
            child: Text(
              nameColu2 != null ? '{$nameColu2}' : 'Name2',
              textAlign: TextAlign.center,
            )),
        Container(
          alignment: Alignment.center,
          child: Icon(
            iconData != null
                ? Icons.edit_location_rounded
                : Icons.expand_more_outlined,
          ),
        ),
        Container(
            alignment: Alignment.center,
            child: Text(
              nameColu3 != null ? '{$nameColu3}' : 'Name3',
              textAlign: TextAlign.center,
            )),
      ],
    ),
  );
}
