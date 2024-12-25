import 'package:accounts_book/controller/customers.dart';
import 'package:accounts_book/model/acc_restrichion.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/state_manager.dart';
import 'package:intl/intl.dart';

import '../api/app_db1.dart';
import '../model/customer.dart';

class AccRestrichions extends GetxController {
  RxList<AccRestrichion> _accRestrichions = RxList<AccRestrichion>([]);
  RxList<AccRestrichion> get accRestrichions => RxList([..._accRestrichions]);

  final detailsController = TextEditingController();
  final theAmountController = TextEditingController();

  AppDB _appDB = AppDB();
  int? length;
  String tableName = 'accRestrichions';
  RxBool isSort = false.obs;

  @override
  void onInit() {
    fetchAccRestrichionsData();
    super.onInit();
  }

  // @override
  // void onReady() {
  //   super.onReady();
  //
  // }

  addNewAccRestrichion({AccRestrichion? accRestrichion}) async {
    length =
        _accRestrichions.isEmpty ? 0 : _accRestrichions.last.accRestrichionId;

    await _appDB.insertTable(tableName, accRestrichion!.toMap());

    detailsController.clear();
    theAmountController.clear();
    fetchAccRestrichionsData();
    // _accRestrichions.forEach((element) {
    //
    // });
  }

  fetchAccRestrichionsData() async {
    List<Map<String, dynamic>> getAllAccRestrichionsData =
        await _appDB.getTableData(tableName);
    // getAllAccRestrichionsData.forEach((element) {
    //   print('customerId : ${element['customerId']}');
    //   // print('debit : ${element['debit']}');
    // });
    _accRestrichions.assignAll(getAllAccRestrichionsData
        .map((data) => AccRestrichion.map(data))
        .toList());
  }

  AccRestrichion findById(int accRestrichionId) {
    return _accRestrichions
        .firstWhere((element) => element.accGroupId == accRestrichionId);
  }

  editAccRestrichion({
    AccRestrichion? accRestrichion,
  }) async {
    await _appDB.updateDate(
        tableName, accRestrichion!.toMap(), 'accRestrichionId');
    fetchAccRestrichionsData();
  }

  deleteAccRestrichion({AccRestrichion? accRestrichion}) async {
    await _appDB.deleteRow(
        tableName, accRestrichion!.toMap(), 'accRestrichionId');
    fetchAccRestrichionsData();
  }

  RxInt credied = 0.obs;
  RxInt debited = 0.obs;
  RxList count = [].obs;
  RxList<AccRestrichion> dataAccRestrichionForMainScreen =
      <AccRestrichion>[].obs;
  RxList<AccRestrichion> examList = <AccRestrichion>[].obs;
  getAccGroupIdData(int accGroupId) {
    dataAccRestrichionForMainScreen.value = _accRestrichions.value
        .where((element) => element.accGroupId == accGroupId)
        .toList();
    // dataAccRestrichionForMainScreen.forEach((element) {
    //   if (element.customerId == 4) {
    //     print('Cus:${element.customerId}');
    //   }
    // });

    dataAccRestrichionForMainScreen.sort(
      (a, b) => a.customerId!.compareTo(b.customerId!),
    );
    accRestrReportForCostomer.value = _accRestrichions
        .where((data) => data.accGroupId == accGroupId)
        .toList();
    print('Lingth : ${accRestrReportForCostomer.length}');

    examList.value = dataAccRestrichionForMainScreen
        .where((data) => data.registerdon == 'Jun 12, 2023')
        .toList();

    // examList.forEach((element) {
    //   DateTime dateTime = DateTime.parse('2023-01-20');
    //   final d = DateFormat('d-MM-y').format(dateTime);
    //   print('Date : ${d}');
    //   print('customerId : ${element.customerId}');
    // });

    // accRestrReportForCostomer.forEach((element) {
    //   print('Cus:${element.customerId}');
    // });
    //cus.value = dataAccRestrichionForMainScreen;
    if (dataAccRestrichionForMainScreen.isNotEmpty) {
      credied.value = 0;
      debited.value = 0;
      for (int i = 0; i < dataAccRestrichionForMainScreen.length; i++) {
        if (dataAccRestrichionForMainScreen[i].accGroupId == accGroupId) {
          credied.value += dataAccRestrichionForMainScreen[i].credit!;
          debited += dataAccRestrichionForMainScreen[i].debit!;
        }
        // credied.value = 0;
        // debited.value = 0;
      }
    }

    var counts = dataAccRestrichionForMainScreen.fold<Map<String, int>>({},
        (map, element) {
      map[element.customerId.toString()] =
          (map[element.customerId.toString()] ?? 0) + 1;
      return map;
    });
    count.assignAll(counts.values);
    final ids = dataAccRestrichionForMainScreen
        .map((element) => element.customerId)
        .toSet();
    dataAccRestrichionForMainScreen.value
        .retainWhere((element) => ids.remove(element.customerId));
  }

  RxList<AccRestrichion> accRestrForAccGroupsReport = <AccRestrichion>[].obs;
  RxList<AccRestrichion> accRestrReportForCostomer = RxList<AccRestrichion>([]);
  RxList<AccRestrichion> cus = RxList<AccRestrichion>([]);

  getDataUserBycustomerIdAndAccgroup(int accgroup, int customer) {
    return _accRestrichions
        .where((data) =>
            data.accGroupId == accgroup && data.customerId == customer)
        .toList();
  }

  getAccGroupIdDataReport(int accGroupId) {
    //accRestrReportForCostomer.value = [];
    accRestrReportForCostomer.value.clear();
    accRestrForAccGroupsReport.value = _accRestrichions
        .where((element) => element.accGroupId == accGroupId)
        .toList();
    !isSort.value
        ? accRestrForAccGroupsReport.sort(
            (a, b) => a.customerId!.compareTo(b.customerId!),
          )
        : accRestrForAccGroupsReport.sort(
            (a, b) => b.customerId!.compareTo(a.customerId!),
          );

    accRestrReportForCostomer = _accRestrichions
        .where((data) => data.accGroupId == accGroupId)
        .toList()
        .obs;
    // accRestrReportForCostomer.sort(
    //   (a, b) => a.customerId!.compareTo(b.customerId!),
    // );
    print('Lingth : ${accRestrReportForCostomer.length}');
    final fetchCount =
        accRestrForAccGroupsReport.map((element) => element.customerId).toSet();
    accRestrForAccGroupsReport.value
        .retainWhere((element) => fetchCount.remove(element.customerId));

    // for (int i = 0; i < accRestrForAccGroupsReport.length; i++) {
    //   //print(co[i]);
    //   cus.value = accRestrReportForCostomer
    //       .where((customerId) =>
    //           customerId.customerId == accRestrForAccGroupsReport[i].customerId)
    //       .toList();
    //   print('OOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOO');
    //
    //   for (int o = 0; o < cus.length; o++) {
    //     print('Ccccccccccccc      ${cus[o].customerId}     cccccccccccccccccc');
    //     print('Name :${cus[o].credit}');
    //
    //     Customer customer = Get.find<Customers>().findById(cus[o].customerId!);
    //     // credied.value += cus[i].credit!;
    //     // print('credied : $credied');
    //     print('Name :${customer.customerName}');
    //     //print('Name :${accRestrForAccGroupsReport[j].credit}');
    //     print('*********************************');
    //   }
    //
    //   // for (int j = 0; j < co[i]; j++) {
    //   //   Customer customer = Get.find<Customers>()
    //   //       .findById(accRestrForAccGroupsReport[i].customerId!);
    //   //   //print('^^^^^^^^^^^^^^^^^^^^^^^^^^^^');
    //   //   print('Name :${customer.customerName}');
    //   //   //print('Name :${accRestrForAccGroupsReport[j].credit}');
    //   //   print('*********************************');
    //   // }
    // }
  }
  // getDataForDate(String date)
  // {
  //   ac
  // }

  getSumAmountCustomer(int index) {
    int sum = 0;

    cus.value = accRestrReportForCostomer
        .where((customerId) =>
            customerId.customerId ==
            accRestrForAccGroupsReport[index].customerId)
        .toList();

    for (int i = 0; i < cus.length; i++) {
      cus[i].credit != 0 ? sum += cus[i].credit! : sum += cus[i].debit!;
    }
    return sum;
  }

  // getAccRestrichionCredied() {
  //   if (dataAccRestrichionForMainScreen.isNotEmpty) {
  //     credied.value = 0;
  //     debited.value = 0;
  //     for (int i = 0; i < dataAccRestrichionForMainScreen.length; i++) {
  //       credied.value += dataAccRestrichionForMainScreen[i].credit!;
  //       debited += dataAccRestrichionForMainScreen[i].debit!;
  //     }
  //   }
  // }

  onTapClick({required RxBool isSorts, required int numColumn}) {
    // numberColumn = numColumn;
    // print('numColumn : $numberColumn');
    // print(isSorts);
    if (isSort.value == false) {
      isSort.value = true;
    } else {
      isSort.value = false;
    }
  }
}
