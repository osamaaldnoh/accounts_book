import 'package:accounts_book/api/app_db1.dart';
import 'package:accounts_book/model/customer.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../model/acc_group.dart';

class Customers extends GetxController {
  //static Customers instans = Get.find();
  RxList<Customer> _customers = RxList<Customer>([]);
  RxList<Customer> get customers => RxList<Customer>([..._customers]);

  static List<String> customersName = [];
  final nameCustomerController = TextEditingController();
  final phoneCustomerController = TextEditingController();
  int? length;
  AppDB _appDB = AppDB();
  String tableName = 'customers';

  @override
  void onInit() {
    fetchCustomerData();
    super.onInit();
  }

  addNewCustomer({Customer? customer}) async {
    length = _customers.isEmpty ? 0 : _customers.last.customerId;
    await _appDB.insertTable(tableName, customer!.toMap());
    fetchCustomerData();
    nameCustomerController.clear();
    phoneCustomerController.clear();
    // _customers.forEach((element) {
    //   print('Name User: ${element.customerName}');
    // });
  }

  fetchCustomerData() async {
    //AppDB.nameTable = 'accGroups';
    List<Map<String, dynamic>> getAllCustomers =
        await _appDB.getTableData(tableName);
    // getAllCustomers.forEach((element) {
    //   print('getAllCustomers : ${element['customerName']}');
    // });
    _customers
        .assignAll(getAllCustomers.map((data) => Customer.map(data)).toList());

    customersName = List.generate(customers.value.length,
        (index) => customers.value[index].customerName!);
  }

  findById(int customerId) {
    return _customers.firstWhere((element) => element.customerId == customerId);
  }

  editCurrency({
    Customer? customer,
  }) {
    _appDB.updateDate(tableName, customer!.toMap(), 'customerId');
    fetchCustomerData();
  }

  deleteCurrency({Customer? customer}) async {
    await _appDB.deleteRow(tableName, customer!.toMap(), 'customerId');
    fetchCustomerData();
  }

  static List<String> getsuggestion(String query) =>
      List.of(customersName).where((names) {
        final nameLower = names.toLowerCase();
        final queryLower = query.toLowerCase();

        return nameLower.contains(queryLower);
      }).toList();

  findByName(String customerName) {
    return customers
        .firstWhere((element) => element.customerName == customerName);
  }

  final exist = '0'.obs;
  RxInt count = 0.obs;
  isExistingName(String name) {
    var isExisting =
        _customers.where((element) => element.customerName == name);
    if (isExisting.isNotEmpty) {
      count.value = 1;
    } else {
      count.value = 0;
    }
  }

  RxString data = DateFormat('d-MM-y').format(DateTime.now()).obs;
  DateTime? selectDate;
  selectedDate(BuildContext context) {
    //data.value = DateFormat.yMMMd().format(DateTime.now());
    showDatePicker(
        context: Get.context!,
        initialDate: DateTime.now(),
        firstDate: DateTime.now(),
        lastDate: DateTime.now().add(Duration(
          days: 5,
        ))).then((value) {
      selectDate = value;
      data.value = DateFormat('d-MM-y').format(value ?? DateTime.now());
    });
    //print('Date :$data');
  }
}
