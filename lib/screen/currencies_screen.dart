import 'package:accounts_book/api/app_db1.dart';
import 'package:accounts_book/const/const_color.dart';
import 'package:accounts_book/controller/acc_groups.dart';
import 'package:accounts_book/model/currency.dart';
import 'package:flutter/material.dart';
import 'package:get/instance_manager.dart';
import 'package:get/get.dart';
import '../controller/currencies.dart';
import '../model/acc_group.dart';

class CurrenciesScreen extends StatefulWidget {
  static String routeName = 'CategoriesOrCurrencies';
  CurrenciesScreen({Key? key}) : super(key: key);

  @override
  State<CurrenciesScreen> createState() => _CurrenciesScreenState();
}

class _CurrenciesScreenState extends State<CurrenciesScreen> {
  final currenciesController = Get.find<Currencies>();
  RxList<Currency> _currencySelected = RxList<Currency>([]);
  Currency? currencyModel;
  RxBool _selected = false.obs;

  final GlobalKey<FormState> _formKey = GlobalKey();
  TextEditingController currencyName = TextEditingController();
  List<String> dataColumn = ['العملة', 'عدد الحسابات'];

  onSave(String methodName) async {
    if (!_formKey.currentState!.validate()) {
      return;
    }
    _formKey.currentState!.save();

    methodName == 'add'
        ? await currenciesController.addNewCurrency(
            currency: Currency(
              currencyName: currencyName.text,
              currencySymbol: '\$',
            ),
          )
        : methodName == 'edite'
            ? await currenciesController.editCurrency(
                currency: currencyModel,
              )
            : await currenciesController.deleteCurrency(
                currency: Currency(
                  currencyName: currencyName.text,
                  currencySymbol: '\$',
                ),
              );
    // currenciesController.getData();
    currencyName.clear();

    Get.back();
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() => Scaffold(
          appBar: AppBar(
            backgroundColor:
                _currencySelected.isEmpty ? ConstColors.appBar : Colors.black45,
            elevation: 0,
            iconTheme: IconThemeData(
              color: ConstColors.iconappBar,
            ),
            title: Text(
              _currencySelected.isEmpty
                  ? 'العملات'
                  : '${_currencySelected.length} Selected',
              style: TextStyle(
                color: ConstColors.textColor,
                fontWeight: FontWeight.bold,
              ),
            ),
            leading: _currencySelected.isNotEmpty
                ? IconButton(
                    onPressed: () {
                      //Get.toNamed(RoutesClass.getAccGroupsScreenRoute());
                      _currencySelected.value = [];
                    },
                    icon: Icon(Icons.arrow_back_rounded),
                  )
                : null,
            actions: [
              _currencySelected.isNotEmpty
                  ? Row(
                      children: [
                        IconButton(
                          onPressed: () {},
                          icon: Icon(Icons.delete),
                        ),
                        IconButton(
                          onPressed: () {
                            if (_currencySelected.length == 1) {
                              currencyModel = _currencySelected[0];
                              _currencySelected.clear();
                              currencyName.text = currencyModel!.currencyName!;
                              showDialogWidgetAddCurrencey(
                                  title: 'تفيير العملة',
                                  hintText: 'عملة',
                                  currencyName: currencyName,
                                  methodName: 'edite');
                            }
                          },
                          icon: Icon(Icons.edit),
                        )
                      ],
                    )
                  : Container(),
            ],
          ),
          body: Directionality(
              textDirection: TextDirection.rtl,
              child: Column(
                children: [
                  // Container(
                  //   color: ConstColors.appBar,
                  //   child: ListTile(
                  //     trailing: Icon(Icons.arrow_forward_sharp),
                  //     title: Text(
                  //       'App',
                  //       textAlign: TextAlign.end,
                  //     ),
                  //   ),
                  // ),
                  // Container(
                  //   width: double.infinity,
                  //   child: Text('Selected'),
                  //   color: Colors.green,
                  //   padding: EdgeInsets.all(15),
                  // ),
                  Expanded(
                    child: SingleChildScrollView(
                      child: Obx(() => Container(
                            width: double.infinity,
                            child: DataTable(
                              showCheckboxColumn: false,
                              columns: getColumns(dataColumn),
                              rows: List<DataRow>.generate(
                                currenciesController.currencies.length,
                                (index) => DataRow(
                                    selected: _currencySelected.value.contains(
                                        currenciesController
                                            .currencies.value[index]),
                                    onSelectChanged: (isSelected) {
                                      print('Osama');
                                      _selected.value =
                                          isSelected != null && isSelected;
                                      _selected.value
                                          ? _currencySelected.add(
                                              currenciesController
                                                  .currencies.value[index])
                                          : _currencySelected.remove(
                                              currenciesController
                                                  .currencies.value[index]);
                                      // _currencySelected.length == 1
                                      //     ? currencyName.text =
                                      //         _currencySelected[index]
                                      //             .currencyName!
                                      //     : currencyName.text;
                                    },
                                    cells: [
                                      DataCell(
                                        Center(
                                          child: Text(
                                            currenciesController
                                                .currencies[index]
                                                .currencyName!,
                                            textAlign: TextAlign.center,
                                          ),
                                        ),
                                      ),
                                      DataCell(
                                        Center(
                                          child: Text(
                                            '${currenciesController.currencies[index].currencyId}',
                                            textAlign: TextAlign.center,
                                          ),
                                        ),
                                      ),
                                      // DataCell(
                                      //   Center(
                                      //     child: Obx(() => Switch(
                                      //       overlayColor:
                                      //       MaterialStatePropertyAll<
                                      //           Color>(Colors.grey),
                                      //       activeColor: Colors.green,
                                      //       value: accGroupsController
                                      //           .accGroups[index]
                                      //           .status ==
                                      //           1
                                      //           ? true
                                      //           : false,
                                      //       onChanged: (value) {
                                      //         currencyModel = accGroupsController
                                      //             .accGroups[index];
                                      //
                                      //         print(value);
                                      //         value == true
                                      //             ? currencyModel!.status = 1
                                      //             : currencyModel!.status = 0;
                                      //         accGroupsController
                                      //             .editAccGroup(
                                      //             currencyModel: currencyModel);
                                      //       },
                                      //     )),
                                      //   ),
                                      // ),
                                    ]),
                              ),
                            ),
                          )),
                    ),
                  ),

                  // Obx(
                  //   () => accGroupsController.accGroups.isNotEmpty
                  //       ? ListView.builder(
                  //           //  physics: ScrollPhysics(),
                  //
                  //           itemCount: accGroupsController.accGroups.length,
                  //
                  //           shrinkWrap: true,
                  //           itemBuilder: (ctx, index) {
                  //             return Column(
                  //               children: [
                  //                 InkWell(
                  //                   splashColor: Colors.red,
                  //                   onTap: () {
                  //                     _selected.value = true;
                  //                     print('_selected ${_selected}');
                  //                     print('select');
                  //                   },
                  //                   onLongPress: () {
                  //                     accGroupsController
                  //                         .accGroups[index].accGroupName;
                  //                     _selected.value = true;
                  //                     print('_selected ${_selected}');
                  //                     print('onTapCancel');
                  //                   },
                  //                   child: Container(
                  //                     //color: Colors.green,
                  //                     child: Row(
                  //                       mainAxisAlignment:
                  //                           MainAxisAlignment.spaceAround,
                  //                       //crossAxisAlignment: CrossAxisAlignment.center,
                  //                       children: [
                  //                         Expanded(
                  //                           child: Container(
                  //                             // width:
                  //                             //     MediaQuery.of(context).size.width *
                  //                             //         0.3,
                  //                             child: Text(
                  //                               '${accGroupsController.accGroups[index].accGroupName}',
                  //                               textAlign: TextAlign.center,
                  //                             ),
                  //                           ),
                  //                         ),
                  //                         Expanded(
                  //                           child: Container(
                  //                             // width:
                  //                             //     MediaQuery.of(context).size.width *
                  //                             //         0.3,
                  //                             alignment: Alignment.center,
                  //                             child: Text(
                  //                               '${accGroupsController.accGroups[index].accGroupId}',
                  //                               textAlign: TextAlign.center,
                  //                             ),
                  //                           ),
                  //                         ),
                  //                         Expanded(
                  //                           child: Container(
                  //                             // color: Colors.green,
                  //                             child: Obx(
                  //                               () => Switch(
                  //                                 overlayColor:
                  //                                     MaterialStatePropertyAll<
                  //                                         Color>(Colors.grey),
                  //                                 activeColor: Colors.green,
                  //                                 value: accGroupsController
                  //                                             .accGroups[index]
                  //                                             .status ==
                  //                                         1
                  //                                     ? true
                  //                                     : false,
                  //                                 onChanged: (value) {
                  //                                   value == true
                  //                                       ? accGroupsController
                  //                                               .accGroups[index]
                  //                                               .status !=
                  //                                           '1'
                  //                                       : accGroupsController
                  //                                               .accGroups[index]
                  //                                               .status !=
                  //                                           '0';
                  //                                 },
                  //                               ),
                  //                             ),
                  //                           ),
                  //                         ),
                  //                       ],
                  //                     ),
                  //                   ),
                  //                 ),
                  //                 Divider(
                  //                   color: ConstColors.dividerColor,
                  //                   thickness: 1,
                  //                 ),
                  //               ],
                  //             );
                  //           },
                  //         )
                  //       : Center(
                  //           child: Text('Add'),
                  //         ),
                  // ),
                ],
              )),
          bottomNavigationBar: Container(
            color: ConstColors.appBar,
            padding: EdgeInsets.all(10),
            width: double.infinity,
            child: InkWell(
              onTap: () {
                showDialogWidgetAddCurrencey(
                    title: 'أضافة العملة',
                    hintText: 'عملة',
                    currencyName: currencyName,
                    methodName: 'add');
                currencyName.clear();
              },
              child: Icon(
                Icons.add_circle_outline_sharp,
                size: MediaQuery.of(context).size.width * 0.1,
              ),
            ),
          ),
        ));
  }

  showDialogWidgetAddCurrencey(
      {required String title,
      required String hintText,
      required TextEditingController currencyName,
      required String methodName}) {
    return Get.defaultDialog(
        content: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: currencyName,
                decoration: InputDecoration(
                  hintText: ' ال$hintText',
                  border: UnderlineInputBorder(
                    borderSide: BorderSide(
                      color: ConstColors.textfieldundrColor,
                    ),
                  ),
                ),
                textAlign: TextAlign.center,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'يجب ان يحتوي قيمة';
                  }
                },
                onSaved: (val) {
                  currencyName.text = val!;
                  currencyModel!.currencyName = val;
                },
              ),
            ],
          ),
        ),
        title: '$title',
        actions: [
          TextButton(
            onPressed: () => onSave(methodName),
            child: Text('موافق'),
          ),
          TextButton(
            onPressed: () => Get.back(),
            child: Text('إلغاء'),
          ),
        ]);
  }

  List<DataColumn> getColumns(List<String> columns) => columns
      .map((String data) => DataColumn(
            label: Expanded(
              child: Text(
                data,
                textAlign: TextAlign.center,
              ),
            ),
          ))
      .toList();
}

// class DialogWidgetGetx extends StatelessWidget {
//    DialogWidgetGetx(
//       {required BuildContext context, Key? key, required this.name})
//       : super(key: key);
//   final String name;
//
//   final GlobalKey<FormState> _formKey = GlobalKey();
//   final currenciesController = Get.put(Currencies());
//
//   TextEditingController currencyName = TextEditingController();
//
//   onSave() async {
//     if (!_formKey.currentState!.validate()) {
//       return;
//     }
//     _formKey.currentState!.save();
//     int result = await currenciesController.addNewCurrency(
//       currencies: Currency(
//         currencyName: currencyName.text,
//         currencySymbol: '\$',
//       ),
//     );
//     // currenciesController.getData();
//     currencyName.clear();
//
//     Get.back();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Get.defaultDialog(
//       title: 'أضافة $name',
//       actions: [
//         Form(
//           key: _formKey,
//           child: Column(
//             children: [
//               TextFormField(
//                 controller: currencyName,
//                 decoration: InputDecoration(
//                   hintText: 'ال$name',
//                   border: UnderlineInputBorder(
//                     borderSide: BorderSide(
//                       color: ConstColors.textfieldundrColor,
//                     ),
//                   ),
//                 ),
//                 textAlign: TextAlign.center,
//                 validator: (value) {
//                   if (value!.isEmpty) {
//                     return 'يجب ان يحتوي قيمة';
//                   }
//                 },
//                 onSaved: (val) {
//                   currencyName.text = val!;
//                 },
//               ),
//               Row(
//                 children: [
//                   TextButton(
//                     onPressed: () => onSave(),
//                     child: Text('موافق'),
//                   ),
//                   TextButton(
//                     onPressed: () => Get.back(),
//                     child: Text('إلغاء'),
//                   ),
//                 ],
//               ),
//             ],
//           ),
//         ),
//       ],
//     );
//   }
// }
//
// class AddAccGroupOrCurenciesshowDialogWidget extends StatelessWidget {
//   AddAccGroupOrCurenciesshowDialogWidget(
//       {required BuildContext context, Key? key, required this.name})
//       : super(key: key);
//   final String name;
//
//   final GlobalKey<FormState> _formKey = GlobalKey();
//   final currenciesController = Get.put(Currencies());
//
//   TextEditingController currencyName = TextEditingController();
//
//   onSave() async {
//     if (!_formKey.currentState!.validate()) {
//       return;
//     }
//     _formKey.currentState!.save();
//     int result = await currenciesController.addNewCurrency(
//       currency: Currency(
//         currencyName: currencyName.text,
//         currencySymbol: '\$',
//       ),
//     );
//     // currenciesController.getData();
//     currencyName.clear();
//
//     Get.back();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Directionality(
//       textDirection: TextDirection.rtl,
//       child: AlertDialog(
//         elevation: 0,
//         title: Text('أضافة $name'),
//         actions: [
//           Form(
//             key: _formKey,
//             child: Column(
//               children: [
//                 TextFormField(
//                   controller: currencyName,
//                   decoration: InputDecoration(
//                     hintText: 'ال$name',
//                     border: UnderlineInputBorder(
//                       borderSide: BorderSide(
//                         color: ConstColors.textfieldundrColor,
//                       ),
//                     ),
//                   ),
//                   textAlign: TextAlign.center,
//                   validator: (value) {
//                     if (value!.isEmpty) {
//                       return 'يجب ان يحتوي قيمة';
//                     }
//                   },
//                   onSaved: (val) {
//                     currencyName.text = val!;
//                   },
//                 ),
//                 Row(
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
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
// Positioned(
//   bottom: 0,
//   left: 0,
//   right: 0,
//   child: Container(
//     color: ConstColors.appBar,
//     padding: EdgeInsets.all(10),
//     width: double.infinity,
//     child: InkWell(
//       onTap: () => showAddDialog(
//         context,
//         nameScreen == 'A' ? 'تصنيف' : 'عملة',
//       ),
//       child: Icon(
//         Icons.add_circle_outline_sharp,
//         size: MediaQuery.of(context).size.width * 0.1,
//       ),
//     ),
//   ),
// ),

List<Map<String, dynamic>> currencesList = [
  {
    'name': 'محلي',
    'numberOfAccount': '1',
  },
  {
    'name': 'دولار',
    'numberOfAccount': '1',
  },
  {
    'name': 'سعودي',
    'numberOfAccount': '1',
  },
];
