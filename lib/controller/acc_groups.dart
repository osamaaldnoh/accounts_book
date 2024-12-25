import 'package:accounts_book/api/app_db1.dart';
import 'package:accounts_book/controller/customers.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../model/acc_group.dart';

class AccGroups extends GetxController {
  RxList<AccGroup> _accGroups = RxList<AccGroup>([]);
  RxList<AccGroup> get accGroups => RxList<AccGroup>([..._accGroups]);
  RxBool status = false.obs;
  int? length;
  AppDB _appDB = AppDB();
  String tableName = 'accGroups';
  RxString title = ''.obs;
  RxString titleReport = ''.obs;
  RxInt accGroupsId = 0.obs;
  final pageController = PageController(initialPage: 0);

  @override
  void onInit() {
    fetchDataAccGroup();
    super.onInit();
  }

  @override
  void onClose() {
    pageController.dispose();
    super.onClose();
  }

  addNewAccGroup({AccGroup? accGroup}) async {
    length = _accGroups.isEmpty ? 0 : _accGroups.last.accGroupId;

    await _appDB.insertTable(tableName, accGroup!.toMap());
    _accGroups.add(AccGroup(
      accGroupId: length! + 1,
      accGroupName: accGroup!.accGroupName,
    ));
  }

  fetchDataAccGroup() async {
    //AppDB.nameTable = 'accGroups';
    List<Map<String, dynamic>> getAllTasksData =
        await _appDB.getTableData(tableName);

    if (getAllTasksData.isEmpty) {
      await _appDB.insertTable(tableName, {
        'accGroupName': 'عام',
        'created_at': '20-10-2023',
        'status': '1',
      });
      await _appDB.insertTable(tableName, {
        'accGroupName': 'عملاء',
        'created_at': '20-10-2023',
        'status': '1',
      });
      await _appDB.insertTable(tableName, {
        'accGroupName': 'موردين',
        'created_at': '20-10-2023',
        'status': '1',
      });
      fetchDataAccGroup();
    }
    _accGroups
        .assignAll(getAllTasksData.map((data) => AccGroup.map(data)).toList());
    title.value = accGroups.first.accGroupName!;
    accGroupsId.value = accGroups.first.accGroupId!;
    titleReport.value = accGroups.first.accGroupName!;
  }

  AccGroup findById(int accGroupId) {
    return _accGroups.firstWhere((element) => element.accGroupId == accGroupId);
  }

  AccGroup findByName(String accGroupName) {
    return _accGroups
        .firstWhere((element) => element.accGroupName == accGroupName);
  }

  AccGroup findByNameValue(RxString accGroupName) {
    return _accGroups
        .firstWhere((element) => element.accGroupName == accGroupName.value);
  }

  editAccGroup({
    AccGroup? accGroup,
  }) async {
    await _appDB.updateDate(tableName, accGroup!.toMap(), 'accGroupId');
    fetchDataAccGroup();
  }

  deleteAccGroup({AccGroup? accGroup}) async {
    await _appDB.deleteRow(tableName, accGroup!.toMap(), 'accGroupId');
    fetchDataAccGroup();
  }
}
