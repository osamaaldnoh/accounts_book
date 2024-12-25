import 'package:accounts_book/api/app_db1.dart';
import 'package:accounts_book/api/routes_class.dart';
import 'package:accounts_book/const/const_color.dart';
import 'package:accounts_book/controller/acc_groups.dart';
import 'package:accounts_book/model/currency.dart';
import 'package:flutter/material.dart';
import 'package:get/instance_manager.dart';
import 'package:get/get.dart';
import '../controller/currencies.dart';
import '../model/acc_group.dart';

class AccGroupsScreen extends StatefulWidget {
  static String routeName = 'AccGroupsScreen';
  AccGroupsScreen({Key? key}) : super(key: key);

  @override
  State<AccGroupsScreen> createState() => _AccGroupsScreenState();
}

class _AccGroupsScreenState extends State<AccGroupsScreen> {
  AccGroups accGroupsController = Get.find<AccGroups>();
  RxList<AccGroup> _accGroupSelected = RxList<AccGroup>([]);
  AccGroup? accGroup;
  RxBool isSelected = false.obs;

  final GlobalKey<FormState> _formKey = GlobalKey();
  //final currenciesController = Get.put(Currencies());

  TextEditingController accGroupName = TextEditingController();
  List<String> dataColumn = ['الحاله', 'عدد الحسابات', 'العملة'];
  RxBool _selected = false.obs;

  onSave() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }
    _formKey.currentState!.save();

    await accGroupsController.addNewAccGroup(
      accGroup: AccGroup(
        accGroupName: accGroupName.text,
        created_at: '20-20-2016',
      ),
    );
    accGroupName.clear();

    Get.back();
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() => Scaffold(
          appBar: AppBar(
            backgroundColor:
                _accGroupSelected.isEmpty ? ConstColors.appBar : Colors.black45,
            elevation: 0,
            iconTheme: IconThemeData(
              color: ConstColors.iconappBar,
            ),
            title: Text(
              _accGroupSelected.isEmpty
                  ? 'التصنيفات'
                  : '${_accGroupSelected.length} Selected',
              style: TextStyle(
                color: ConstColors.textColor,
                fontWeight: FontWeight.bold,
              ),
            ),
            leading: _accGroupSelected.isNotEmpty
                ? IconButton(
                    onPressed: () {
                      //Get.toNamed(RoutesClass.getAccGroupsScreenRoute());
                      _accGroupSelected.value = [];
                    },
                    icon: Icon(Icons.arrow_back_rounded),
                  )
                : null,
            actions: [
              _accGroupSelected.isNotEmpty
                  ? Row(
                      children: [
                        IconButton(
                          onPressed: () {},
                          icon: Icon(Icons.delete),
                        ),
                        IconButton(
                          onPressed: () {},
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
                                accGroupsController.accGroups.length,
                                (index) => DataRow(
                                    selected: _accGroupSelected.value.contains(
                                        accGroupsController
                                            .accGroups.value[index]),
                                    onSelectChanged: (isSelected) {
                                      print('Osama');
                                      _selected.value =
                                          isSelected != null && isSelected;
                                      _selected.value
                                          ? _accGroupSelected.add(
                                              accGroupsController
                                                  .accGroups.value[index])
                                          : _accGroupSelected.remove(
                                              accGroupsController
                                                  .accGroups.value[index]);
                                    },
                                    cells: [
                                      DataCell(
                                        Center(
                                          child: Text(
                                            accGroupsController
                                                .accGroups[index].accGroupName!,
                                            textAlign: TextAlign.center,
                                          ),
                                        ),
                                      ),
                                      DataCell(
                                        Center(
                                          child: Text(
                                            '${accGroupsController.accGroups[index].accGroupId}',
                                            textAlign: TextAlign.center,
                                          ),
                                        ),
                                      ),
                                      DataCell(
                                        Center(
                                          child: Obx(() => Switch(
                                                overlayColor:
                                                    MaterialStatePropertyAll<
                                                        Color>(Colors.grey),
                                                activeColor: Colors.green,
                                                value: accGroupsController
                                                            .accGroups[index]
                                                            .status ==
                                                        1
                                                    ? true
                                                    : false,
                                                onChanged: (value) {
                                                  accGroup = accGroupsController
                                                      .accGroups[index];

                                                  print(value);
                                                  value == true
                                                      ? accGroup!.status = 1
                                                      : accGroup!.status = 0;
                                                  accGroupsController
                                                      .editAccGroup(
                                                          accGroup: accGroup);
                                                },
                                              )),
                                        ),
                                      ),
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
                Get.defaultDialog(
                    content: Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          TextFormField(
                            controller: accGroupName,
                            decoration: InputDecoration(
                              hintText: 'ال${'تصنيف'}',
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
                              accGroupName.text = val!;
                            },
                          ),
                        ],
                      ),
                    ),
                    title: 'أضافة ${'تصنيف'}',
                    actions: [
                      TextButton(
                        onPressed: () => onSave(),
                        child: Text('موافق'),
                      ),
                      TextButton(
                        onPressed: () => Get.back(),
                        child: Text('إلغاء'),
                      ),
                    ]);
              },
              child: Icon(
                Icons.add_circle_outline_sharp,
                size: MediaQuery.of(context).size.width * 0.1,
              ),
            ),
          ),
        ));
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
