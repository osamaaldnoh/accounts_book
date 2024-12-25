import 'package:accounts_book/api/routes_class.dart';
import 'package:accounts_book/const/text_style.dart';
import 'package:accounts_book/controller/acc_groups.dart';
import 'package:accounts_book/controller/acc_restrichions.dart';
import 'package:accounts_book/controller/customers.dart';
import 'package:accounts_book/model/acc_restrichion.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../const/const_color.dart';
import '../model/acc_group.dart';
import '../model/customer.dart';
import 'add_amount_screen.dart';

class AllScreen extends StatelessWidget {
  AllScreen({Key? key, required this.pageNumper}) : super(key: key);

  RxInt pageNumper;

  AccRestrichions accRestrichionsConttroller = Get.find<AccRestrichions>();
  Customers customersConttroller = Get.find<Customers>();
  AccGroups accGroupsConttroller = Get.find();
  AccGroup accGroupModel = AccGroup();
  Customer? customerModel;
  AccRestrichion? accRestrichionModel;
  //RxInt count = 0.obs;

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return OrientationBuilder(builder: (ctx, orientation) {
      final isPortrait = orientation == Orientation.portrait;
      return Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          bottom: false,
          child: Stack(
            children: [
              Container(
                height: double.infinity,
                child: Obx(() {
                  // accRestrichionsConttroller.getAccRestrichionCredied();
                  return accRestrichionsConttroller
                          .dataAccRestrichionForMainScreen.isNotEmpty
                      ? SingleChildScrollView(
                          physics: ScrollPhysics(),
                          padding: EdgeInsets.only(
                            bottom: isPortrait ? height * 0.1 : width * 0.1,
                          ),
                          child: Column(
                            children: [
                              ListView.separated(
                                padding: EdgeInsets.only(
                                  top:
                                      isPortrait ? height * 0.01 : width * 0.01,
                                  //bottom: isPortrait ? height * 0.02 : width * 0.02,
                                ),
                                shrinkWrap: true,
                                //scrollDirection: Axis.vertical,
                                itemCount: accRestrichionsConttroller
                                    .dataAccRestrichionForMainScreen.length,
                                physics: ScrollPhysics(),
                                itemBuilder: (ctx, index) {
                                  customerModel = customersConttroller.findById(
                                      accRestrichionsConttroller
                                          .dataAccRestrichionForMainScreen[
                                              index]
                                          .customerId!);
                                  //  print(customerModel!.customerId);

                                  // if (accRestrichionsConttroller
                                  //         .accRestrForAccGroups[index]
                                  //         .customerId ==
                                  //     customersConttroller
                                  //         .customers[index].customerId) {
                                  //   count++;
                                  // } // else {
                                  //   count.value = 1;
                                  // }

                                  return InkWell(
                                    onTap: () {
                                      customerModel = customersConttroller
                                          .findById(accRestrichionsConttroller
                                              .dataAccRestrichionForMainScreen[
                                                  index]
                                              .customerId!);

                                      Get.toNamed(
                                          RoutesClass.getUserScreenRoute(),
                                          arguments: {
                                            'index': index,
                                            'customerId': accRestrichionsConttroller
                                                .dataAccRestrichionForMainScreen[
                                                    index]
                                                .customerId,
                                            'customerName':
                                                customerModel!.customerName,
                                            'accGroupId': accRestrichionsConttroller
                                                .dataAccRestrichionForMainScreen[
                                                    index]
                                                .accGroupId,
                                          });
                                    },
                                    child: Container(
                                      padding: EdgeInsets.all(
                                        isPortrait
                                            ? height * 0.01
                                            : width * 0.01,
                                      ),
                                      margin: EdgeInsets.symmetric(
                                        horizontal: isPortrait
                                            ? height * 0.01
                                            : width * 0.02,
                                      ),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Expanded(
                                            flex: 0,
                                            child: Icon(
                                              Icons.edit_location,
                                              color: accRestrichionsConttroller
                                                          .dataAccRestrichionForMainScreen[
                                                              index]
                                                          .credit !=
                                                      0
                                                  ? Colors.green
                                                  : ConstColors.red,
                                            ),
                                          ),
                                          Expanded(
                                            flex: 2,
                                            child: Text(
                                              '${accRestrichionsConttroller.dataAccRestrichionForMainScreen[index].credit == 0 ? accRestrichionsConttroller.dataAccRestrichionForMainScreen[index].debit : accRestrichionsConttroller.dataAccRestrichionForMainScreen[index].credit!}',
                                              textAlign: TextAlign.center,
                                              style: Styles.textStyle.copyWith(
                                                color: ConstColors.textColor
                                                    .withOpacity(0.5),
                                                fontWeight: FontWeight.bold,

                                                // fontSize: isPortrait ? height * 0.02 : width * 0.02,
                                              ),
                                            ),
                                          ),
                                          Expanded(
                                            flex: 1,
                                            child: CircleAvatar(
                                              backgroundColor:
                                                  ConstColors.backGroundCircle,
                                              radius: isPortrait
                                                  ? height * 0.1 / 6
                                                  : width * 0.1 / 5,
                                              child: Text(
                                                '${accRestrichionsConttroller.count[index]}',
                                                style:
                                                    Styles.textStyle.copyWith(
                                                  fontSize: isPortrait
                                                      ? height * 0.02
                                                      : width * 0.02,
                                                ),
                                              ),
                                            ),
                                          ),
                                          Expanded(
                                            flex: 3,
                                            child: Text(
                                              '${customerModel!.customerName}',
                                              textAlign: TextAlign.center,
                                              style: Styles.headLineStyle2,
                                            ),
                                          ),
                                          Material(
                                            color: ConstColors.backGroundColor,
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(
                                                      isPortrait
                                                          ? height * 0.01
                                                          : width * 0.01),
                                              side: BorderSide(
                                                color: ConstColors
                                                    .outlinedbuttonscolor,
                                                width: 1,
                                              ),
                                            ),
                                            child: InkWell(
                                              onTap: () {
                                                // customersConttroller
                                                //     .nameCustomerController
                                                //     .clear();
                                                customerModel =
                                                    customersConttroller.findById(
                                                        accRestrichionsConttroller
                                                            .dataAccRestrichionForMainScreen[
                                                                index]
                                                            .customerId!);
                                                customersConttroller
                                                        .nameCustomerController
                                                        .text =
                                                    customerModel!
                                                        .customerName!;
                                                Get.toNamed(RoutesClass
                                                    .getaddAmountScreenRoute());
                                              },
                                              focusColor:
                                                  ConstColors.backgroundIcon,
                                              borderRadius:
                                                  BorderRadius.circular(
                                                      isPortrait
                                                          ? height * 0.01
                                                          : width * 0.01),
                                              child: Icon(
                                                Icons.add,
                                                size: isPortrait
                                                    ? height * 0.04
                                                    : width * 0.04,
                                                color: ConstColors
                                                    .iconInBorderColor,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  );
                                },
                                separatorBuilder: (cont, int b) {
                                  return Divider(
                                    color: ConstColors.dividerColor,
                                    thickness: 2,
                                  );
                                },
                              )
                            ],
                          ),
                        )
                      : Container();
                }),
              ),
              Positioned(
                bottom: 0,
                right: 0,
                left: 0,
                child: Container(
                  color: ConstColors.drawerColor,
                  padding: EdgeInsets.symmetric(
                    horizontal: MediaQuery.of(context).size.height * 0.01,
                    vertical: MediaQuery.of(context).size.height * 0.01 / 1.8,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.help_outline,
                        color: ConstColors.iconappBar,
                        size: MediaQuery.of(context).size.height * 0.04,
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Obx(() {
                            return Text(
                              'عليك:=${accRestrichionsConttroller.credied} لك:=${accRestrichionsConttroller.debited}',
                              style: Styles.headLineStyle3,
                            );
                          }),
                          Text(
                            'محلي',
                            style: Styles.headLineStyle3,
                          ),
                        ],
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (_) => AddAmountScreen()),
                          );
                        },
                        child: Icon(
                          Icons.add_circle_outline_sharp,
                          color: ConstColors.iconappBar,
                          size: MediaQuery.of(context).size.height * 0.04,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    });
  }
}
