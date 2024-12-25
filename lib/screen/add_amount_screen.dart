import 'package:accounts_book/const/const_color.dart';
import 'package:accounts_book/controller/acc_groups.dart';
import 'package:accounts_book/controller/acc_restrichions.dart';
import 'package:accounts_book/controller/currencies.dart';
import 'package:accounts_book/model/acc_group.dart';
import 'package:accounts_book/model/currency.dart';
import 'package:accounts_book/widgets/app_bar_widget.dart';
import 'package:accounts_book/widgets/widget_radio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/instance_manager.dart';
import 'package:intl/intl.dart' as intl;
import '../controller/customers.dart';
import '../model/acc_restrichion.dart';
import '../model/customer.dart';
import '../widgets/textformfield_widget.dart';

class AddAmountScreen extends StatelessWidget {
  AddAmountScreen({Key? key}) : super(key: key);

  final GlobalKey<FormState> _formKey = GlobalKey();
  final AccGroups accGroupController = Get.find();
  final currenciesController = Get.find<Currencies>();
  Customers customersController = Get.put(Customers());
  AccRestrichions accRestrichionsController = Get.put(AccRestrichions());

  Currency? currencyModel;
  AccGroup? accGroupModel;
  Customer? customerModel;
  AccRestrichion accRestrichionModel2 = AccRestrichion(
    accGroupId: 0,
    debit: 0,
    credit: 0,
    currencyId: 0,
    registerdon: '',
    customerId: 0,
    accRestrichionDetails: '',
    accRestrichionId: 0,
  );

  onsave(BuildContext context, int count) async {
    customersController
        .isExistingName(customersController.nameCustomerController.text);

    if (!_formKey.currentState!.validate()) {
      return;
    }
    _formKey.currentState!.save();
    accGroupModel =
        accGroupController.findByName(accGroupController.title.value);
    currencyModel =
        currenciesController.findById(currenciesController.orderType.value);

    if (customersController.count == 1) {
      customerModel = customersController
          .findByName(customersController.nameCustomerController.text);

      accRestrichionModel2 = AccRestrichion(
        customerId: customerModel!.customerId,
        accRestrichionDetails: accRestrichionsController.detailsController.text,
        registerdon: customersController.data.value,
        currencyId: currencyModel!.currencyId,
        credit: count != 0
            ? int.parse(accRestrichionsController.theAmountController.text)
            : 0,
        debit: count == 0
            ? int.parse(accRestrichionsController.theAmountController.text)
            : 0,
        accGroupId: accGroupModel!.accGroupId,
      );

      accRestrichionsController.addNewAccRestrichion(
        accRestrichion: accRestrichionModel2,
      );
    } else {
      customerModel = Customer(
        customerName: customersController.nameCustomerController.text,
        created_at: customersController.data.value,
        //status: _customer.status,
      );
      accRestrichionModel2 = AccRestrichion(
        accRestrichionDetails: accRestrichionsController.detailsController.text,
        registerdon: customersController.data.value,
        currencyId: currencyModel!.currencyId,
        credit: count != 0
            ? int.parse(accRestrichionsController.theAmountController.text)
            : 0,
        debit: count == 0
            ? int.parse(accRestrichionsController.theAmountController.text)
            : 0,
        accGroupId: accGroupModel!.accGroupId,
      );

      showDailogScreen(
          context: context,
          customer: customerModel!,
          accRestrichion: accRestrichionModel2);
    }
  }

  showDailogScreen(
      {required BuildContext context,
      required Customer customer,
      required AccRestrichion accRestrichion}) {
    showDialog(
      context: context,
      builder: (c) => alertDailogAddCustomerName(
        context: context,
        customer: customer,
        accRestrichion: accRestrichion,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ConstColors.backGroundColor,
      appBar: AppBarWidgetTwoIcons(
        context: context,
        title: 'إضافة مبلغ',
        icon1: Icons.search_outlined,
        icon2: Icons.notifications_active,
      ),
      body: Directionality(
        textDirection: TextDirection.rtl,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Form(
            key: _formKey,
            child: Obx(
              () => Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.5,
                        child: typeAheadFormField(
                          hintText: 'الإسم',
                          nameCustomerController:
                              customersController.nameCustomerController,
                          textInputType: TextInputType.text,
                          suggestionsCallback: Customers.getsuggestion,
                          context: context,
                          onSaved: (value) {
                            customersController.nameCustomerController.text =
                                value!;
                          },
                          validator: (val) {
                            if (val!.isEmpty) {
                              return 'اضف الإسم';
                            }
                            return null;
                          },
                        ),
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.3,
                        child: textFormFieldWidget(
                          controller:
                              accRestrichionsController.theAmountController,
                          hintText: 'المبلغ',
                          textInputType: TextInputType.number,
                          context: context,
                          onSaved: (value) {
                            accRestrichionsController.theAmountController.text =
                                value!;
                          },
                          validator: (val) {
                            if (val!.isEmpty) {
                              return 'اضف المبلغ';
                            }
                            return null;
                          },
                        ),
                      ),
                      Icon(
                        Icons.calculate_outlined,
                        size: MediaQuery.of(context).size.height * 0.04,
                        color: ConstColors.iconsColor,
                      ),
                    ],
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.01,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.6,
                        child: textFormFieldWidget(
                          controller:
                              accRestrichionsController.detailsController,
                          hintText: 'التفاصيل',
                          textInputType: TextInputType.text,
                          context: context,
                          onSaved: (value) {
                            accRestrichionsController.detailsController.text =
                                value!;
                          },
                          validator: (val) {
                            if (val!.isEmpty) {
                              return 'اضف تفاصيل';
                            }
                            return null;
                          },
                        ),
                      ),
                      Icon(
                        Icons.camera_alt_outlined,
                        size: MediaQuery.of(context).size.height * 0.03,
                        color: ConstColors.iconsColor,
                      ),
                      Obx(
                        () => InkWell(
                          overlayColor: MaterialStatePropertyAll<Color?>(
                            Colors.transparent,
                          ),
                          onTap: () =>
                              customersController.selectedDate(context),
                          child: Text(
                            customersController.data.value.isEmpty
                                ? intl.DateFormat.yMMMd().format(
                                    customersController.selectDate ??
                                        DateTime.now())
                                : customersController.data.value,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: ConstColors.textColor,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: List.generate(
                      currenciesController.currencies.length,
                      (index) => WidgetRadio(
                        value: currenciesController
                            .currencies.value[index].currencyName!,
                      ),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    // crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      materialButtonFullWidget(
                        context: context,
                        textButton: 'عليه',
                        onPressed: () => onsave(context, 1),
                        colorbutton: ConstColors.buttonsFilledcolor,
                        iconData: Icons.download_rounded,
                      ),
                      materialButtonOutlineWidget(
                        context: context,
                        textButton: 'له',
                        onPressed: () => onsave(context, 0),
                        colorbutton: ConstColors.insideoutlinedbuttonscolor
                            .withOpacity(0.2),
                        iconData: Icons.file_upload_outlined,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

alertDailogAddCustomerName(
    {required BuildContext context,
    required Customer customer,
    required AccRestrichion accRestrichion}) {
  alertDailogAddCustomerPhoneNumber(
      {required BuildContext context,
      required Customer customer,
      required AccRestrichion accRestrichion}) {
    showDialog(
        context: context,
        builder: (context) {
          return alertDailogAddCustomerPhone(
            // context: context,
            customer: customer,
            accRestrichion: accRestrichion,
          );
        });
  }

  return Directionality(
    textDirection: TextDirection.rtl,
    child: AlertDialog(
      title: Text('إضافة الإسم#'),
      content: Text('أضافة الإسم#${customer.customerName}'),
      actions: [
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            TextButton(
              onPressed: () {
                Get.back();
                alertDailogAddCustomerPhoneNumber(
                    context: context,
                    customer: customer,
                    accRestrichion: accRestrichion);
              },
              child: Text('موافق'),
            ),
            TextButton(
              onPressed: () => Get.back(),
              child: Text('إلغاء'),
            ),
          ],
        )
      ],
    ),
  );
}

class alertDailogAddCustomerPhone extends StatelessWidget {
  alertDailogAddCustomerPhone(
      {required this.customer, required this.accRestrichion, Key? key})
      : super(key: key);

  Customer customer;
  AccRestrichion accRestrichion;
  final GlobalKey<FormState> _formKey = GlobalKey();
  final accGroups = Get.find<AccGroups>();
  int lastCustomerId = 0;
  Customers customers = Get.find<Customers>();
  AccRestrichions accRestrichions = Get.find<AccRestrichions>();

  onSave() async {
    _formKey.currentState!.save();
    //customerNames = customer.customerName;
    await customers.addNewCustomer(customer: customer);
    customers.customers.isEmpty
        ? lastCustomerId = 1
        : lastCustomerId = customers.customers.last.customerId! + 1;
    //print('Last ${lastCustomerId}');
    accRestrichion.customerId = lastCustomerId;
    accRestrichions.addNewAccRestrichion(accRestrichion: accRestrichion);
    //customers.nameCustomerController.clear();
    // accRestrichion = AccRestrichion();
    // customer = Customer();
    Get.back();
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: AlertDialog(
        //actionsPadding: EdgeInsets.all(0),
        //alignment: Alignment.center,
        elevation: 0,
        actions: [
          Form(
            key: _formKey,
            child: Column(
              children: [
                Container(
                  width: double.infinity,
                  child: Text(
                    customer.customerName!,
                    textAlign: TextAlign.center,
                  ),
                ),
                Divider(
                  color: ConstColors.dividerColor,
                  thickness: 1,
                ),
                Row(
                  children: [
                    Expanded(
                      child: Container(
                        // height: MediaQuery.of(context).size.height * 0.06 / 1.3,

                        child: textFormFieldWidget(
                          controller: customers.phoneCustomerController,
                          hintText: 'التلفون',
                          textInputType: TextInputType.number,
                          context: context,
                          onSaved: (value) {
                            customer.customerPhone = value!;
                          },
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 0,
                      child: Container(
                        child: Icon(
                          Icons.numbers_outlined,
                          color: ConstColors.iconsColor,
                        ),
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Expanded(
                      child: Container(
                        // height: MediaQuery.of(context).size.height * 0.06 / 1.3,
                        // width: MediaQuery.of(context).size.width * 0.5,
                        //color: Colors.blue,
                        child: textFormFieldWidget(
                          hintText: accGroups.title.value,
                          readOnly: true,
                          textInputType: TextInputType.name,
                          context: context,
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 0,
                      child: Icon(
                        Icons.person,
                        color: ConstColors.iconsColor,
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.all(3.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      TextButton(
                        onPressed: () => onSave(),
                        child: Text('موافق'),
                      ),
                      TextButton(
                        onPressed: () => Get.back(),
                        child: Text('إلغاء'),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
//
// alertDailogAddCustomerPhone({
//   required BuildContext context,
//   required Customer customer,
//   required AccRestrichion accRestrichion,
// }) {
//   // final customers = Get.find<Customers>();
//   // final accRestrichions = Get.find<AccRestrichions>();
//   final accGroups = Get.find<AccGroups>();
//   final GlobalKey<FormState> _formKey = GlobalKey();
//   int lastCustomerId = 0;
//   Customers customers = Get.put(Customers());
//   AccRestrichions accRestrichions = Get.put(AccRestrichions());
//   onSave() async {
//     _formKey.currentState!.save();
//     //customerNames = customer.customerName;
//     await customers.addNewCustomer(customer: customer);
//     customers.customers.isEmpty
//         ? lastCustomerId = 1
//         : lastCustomerId = customers.customers.last.customerId! + 1;
//     //print('Last ${lastCustomerId}');
//     accRestrichion.customerId = lastCustomerId;
//     accRestrichions.addNewAccRestrichion(accRestrichion: accRestrichion);
//     //customers.nameCustomerController.clear();
//     // accRestrichion = AccRestrichion();
//     // customer = Customer();
//     Get.back();
//   }
//
//   return Directionality(
//     textDirection: TextDirection.rtl,
//     child: AlertDialog(
//       //actionsPadding: EdgeInsets.all(0),
//       //alignment: Alignment.center,
//       elevation: 0,
//       actions: [
//         Form(
//           key: _formKey,
//           child: Column(
//             children: [
//               Container(
//                 width: double.infinity,
//                 child: Text(
//                   customer.customerName!,
//                   textAlign: TextAlign.center,
//                 ),
//               ),
//               Divider(
//                 color: ConstColors.dividerColor,
//                 thickness: 1,
//               ),
//               textFormFieldWidget(
//                 controller: customers.phoneCustomerController,
//                 hintText: 'التلفون',
//                 textInputType: TextInputType.number,
//                 context: context,
//                 onSaved: (value) {
//                   customer.customerPhone = value!;
//                 },
//               ),
//               // Row(
//               //   children: [
//               //     Expanded(
//               //       child: Container(
//               //         // height: MediaQuery.of(context).size.height * 0.06 / 1.3,
//               //
//               //         child: textFormFieldWidget(
//               //           controller: customers.phoneCustomerController,
//               //           hintText: 'التلفون',
//               //           textInputType: TextInputType.number,
//               //           context: context,
//               //           onSaved: (value) {
//               //             customer.customerPhone = value!;
//               //           },
//               //         ),
//               //       ),
//               //     ),
//               //     Expanded(
//               //       flex: 0,
//               //       child: Container(
//               //         child: Icon(
//               //           Icons.numbers_outlined,
//               //           color: ConstColors.iconsColor,
//               //         ),
//               //       ),
//               //     ),
//               //   ],
//               // ),
//               // Row(
//               //   children: [
//               //     Expanded(
//               //       child: Container(
//               //         // height: MediaQuery.of(context).size.height * 0.06 / 1.3,
//               //         // width: MediaQuery.of(context).size.width * 0.5,
//               //         //color: Colors.blue,
//               //         child: textFormFieldWidget(
//               //           hintText: accGroups.title.value,
//               //           readOnly: true,
//               //           textInputType: TextInputType.name,
//               //           context: context,
//               //         ),
//               //       ),
//               //     ),
//               //     Expanded(
//               //       flex: 0,
//               //       child: Icon(
//               //         Icons.person,
//               //         color: ConstColors.iconsColor,
//               //       ),
//               //     ),
//               //   ],
//               // ),
//               Padding(
//                 padding: const EdgeInsets.all(3.0),
//                 child: Row(
//                   mainAxisAlignment: MainAxisAlignment.start,
//                   children: [
//                     TextButton(
//                       onPressed: () => onSave(),
//                       child: Text('موافق'),
//                     ),
//                     TextButton(
//                       onPressed: () => Get.back(),
//                       child: Text('إلغاء'),
//                     ),
//                   ],
//                 ),
//               )
//             ],
//           ),
//         ),
//       ],
//     ),
//   );
// }
