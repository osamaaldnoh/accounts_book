import 'package:accounts_book/screen/user_screen.dart';
import 'package:flutter/material.dart';

import '../const/const_color.dart';
import '../model/employee.dart';
import '../screen/body_user_screen.dart';

columnWidgets(
    {required BuildContext context,
    required String nameColumn,
    required double width,
    required bool isSort,
    required String columnSort,
    required Function()? onTap}) {
  return InkWell(
    onTap: onTap,
    child: Container(
      //color: Colors.deepPurple,
      //alignment: Alignment.center,
      padding: EdgeInsets.all(10),
      width: width,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Spacer(),
          Expanded(
            flex: 3,
            child: Text(
              nameColumn,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: ConstColors.blackColor,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          //Spacer(),
          columnSort == ''
              ? Text('')
              : Icon(isSort ? Icons.expand_more : Icons.expand_less),
        ],
      ),
    ),
  );
}

columnWidget({
  required String nameColumn,
}) {
  return Container(
    alignment: Alignment.center,
    child: Text(
      nameColumn,
      textAlign: TextAlign.center,
      style: TextStyle(
        color: ConstColors.blackColor,
        fontWeight: FontWeight.bold,
      ),
    ),
  );
}

columnIconWidget({required IconData iconColumn}) {
  return Container(
    alignment: Alignment.center,
    child: Icon(
      iconColumn,
      color: ConstColors.red,
    ),
  );
}

Widget dataRowExpListTile({
  required String create_at,
  required String amount,
  required IconData iconData,
  required String numDays,
  required double firstsizeWidget,
  required double scoundSizeWidget,
  required double iconSizeWidget,
  required BuildContext context,
  required Widget bodyExpanded,
  // List<Employee>? employee,
}) {
  return ExpansionPanelList.radio(
    dividerColor: ConstColors.dividerColor,

    elevation: 0,
    expandedHeaderPadding: EdgeInsets.all(0),
    //expandedHeaderPadding: EdgeInsets.all(10),

    children: [
      ExpansionPanelRadio(
        backgroundColor: ConstColors.backGroundColor,
        headerBuilder: (BuildContext context, bool isExpanded) {
          return Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: SizedBox(
                  width: firstsizeWidget,
                  child: Text(create_at,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        overflow: TextOverflow.clip,
                      )),
                ),
              ),
              SizedBox(
                width: scoundSizeWidget,
                child: Text(
                  amount,
                  textAlign: TextAlign.center,
                ),
              ),
              SizedBox(
                width: iconSizeWidget,
                child: Icon(
                  iconData,
                ),
              ),
              Expanded(
                child: Text(
                  numDays,
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          );
        },
        body: bodyExpanded,
        //isExpanded: step.isExpanded,
        value: create_at,
      ),
    ],
  );
}

// InkWell(
// onTap: () {
// Navigator.push(
// context, MaterialPageRoute(builder: (_) => UserScreen()));
// },
// child: ListView.builder(
// shrinkWrap: true,
// physics: NeverScrollableScrollPhysics(),
// itemCount: 2,
// itemBuilder: (context, index) {
// return Column(
// children: [
// Container(
// padding: EdgeInsets.all(5),
// decoration: BoxDecoration(
// color: Colors.grey[100],
// border: Border(
// bottom: BorderSide(
// color: ConstColors.insideoutlinedbuttonscolor,
// width: 1,
// ),
// top: BorderSide(
// color: ConstColors.insideoutlinedbuttonscolor,
// width: 2,
// ),
// ),
// ),
// child: Row(
// mainAxisAlignment: MainAxisAlignment.spaceEvenly,
// children: [
// SizedBox(
// width: firstsizeWidget,
// child: Text('اسامة احمد محمد سعيد',
// textAlign: TextAlign.center,
// style: TextStyle(
// fontWeight: FontWeight.w400,
// // overflow: TextOverflow.clip,
// )),
// ),
// Expanded(
// child: Text(
// amount,
// textAlign: TextAlign.center,
// ),
// ),
// Expanded(
// child: Icon(iconData),
// ),
// Expanded(
// child: Text(
// numDays,
// textAlign: TextAlign.center,
// ),
// ),
// ],
// ),
// ),
// // Divider(
// //   color: ConstColors.dividerColor,
// //   thickness: 1,
// // ),
// ],
// );
// },
// ),
// ),
bodyExpansionPanelRadio({
  required BuildContext context,
  required String fristText,
  required String amount,
  required IconData iconData,
  required String numDays,
  required double firstsizeWidget,
  required bool isCredit,
}) {
  return InkWell(
    onTap: () {
      Navigator.push(context, MaterialPageRoute(builder: (_) => UserScreen()));
    },
    child: Column(
      children: [
        Container(
          padding: EdgeInsets.all(5),
          decoration: BoxDecoration(
            color: Colors.grey[100],
            border: Border(
              bottom: BorderSide(
                color: ConstColors.insideoutlinedbuttonscolor,
                width: 1,
              ),
              top: BorderSide(
                color: ConstColors.insideoutlinedbuttonscolor,
                width: 2,
              ),
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              SizedBox(
                width: firstsizeWidget,
                child: Text(fristText,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontWeight: FontWeight.w400,
                      // overflow: TextOverflow.clip,
                    )),
              ),
              Expanded(
                child: Text(
                  amount,
                  textAlign: TextAlign.center,
                ),
              ),
              Expanded(
                child: Icon(
                  iconData,
                  color: isCredit == true ? ConstColors.green : ConstColors.red,
                ),
              ),
              Expanded(
                child: Text(
                  numDays,
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
        ),
        // Divider(
        //   color: ConstColors.dividerColor,
        //   thickness: 1,
        // ),
      ],
    ),
  );
}
