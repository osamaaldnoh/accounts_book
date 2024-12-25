import 'package:accounts_book/api/app_db1.dart';
import 'package:get/state_manager.dart';

import '../model/currency.dart';

class Currencies extends GetxController {
  RxList<Currency> _currencies = RxList<Currency>([]);
  RxList<Currency> get currencies => RxList([..._currencies]);
  AppDB _appDB = AppDB();
  int? length;
  String tableName = 'currencies';

  @override
  void onInit() {
    getCurrenciesData();
    super.onInit();
  }

  addNewCurrency({Currency? currency}) async {
    length = _currencies.isEmpty ? 0 : _currencies.last.currencyId;

    await _appDB.insertTable(tableName, currency!.toMap());
    _currencies.add(Currency(
      currencyId: length! + 1,
      currencyName: currency!.currencyName,
    ));
  }

  Future<void> getCurrenciesData() async {
    //AppDB.nameTable = 'currencies';
    List<Map<String, dynamic>> getcurrencies =
        await _appDB.getTableData(tableName);
    if (getcurrencies.isEmpty) {
      await _appDB.insertTable(tableName, {
        'currencyName': 'يمني',
        'currencySymbol': 'ر.ي',
      });
      await _appDB.insertTable(tableName, {
        'currencyName': 'سعودي',
        'currencySymbol': 'ر.س',
      });
      await _appDB.insertTable(tableName, {
        'currencyName': 'دولار',
        'currencySymbol': 'USD',
      });
      getCurrenciesData();
    }
    _currencies
        .assignAll(getcurrencies.map((e) => new Currency.map(e)).toList());

    // _appDB.getTasksData(tableName).then((value) {
    //   value.forEach((element) {
    //     _currencies.assignAll(Currency(
    //         currencyId: element['currencyId'],
    //         currencyName: element['currencyName']));
    //   });
    // });
  }

  Currency findById(String currencyName) {
    return currencies
        .firstWhere((element) => element.currencyName == currencyName);
  }

  editCurrency({
    Currency? currency,
  }) async {
    await _appDB.updateDate(tableName, currency!.toMap(), 'currencyId');
    getCurrenciesData();
  }

  deleteCurrency({Currency? currency}) async {
    await _appDB.deleteRow(tableName, currency!.toMap(), 'currencyId');
    getCurrenciesData();
  }

  RxString _orderType = ''.obs;
  RxString get orderType => _orderType;

  void setOrderType(String type) {
    _orderType.value = type;
    print('Type :$_orderType');
    // update();
  }
}
