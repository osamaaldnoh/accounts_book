import '../controller/acc_groups.dart';
import '../controller/acc_restrichions.dart';
import '../controller/customers.dart';
import 'package:get/get.dart';

import '../controller/currencies.dart';

class MyBindings implements Bindings {
  // static Future<void> init() async {
  //   Get.lazyPut<AccGroups>(() => AccGroups(), fenix: true);
  //   Get.lazyPut<Currencies>(() => Currencies(), fenix: true);
  //   Get.lazyPut<AccRestrichions>(() => AccRestrichions(), fenix: true);
  //   Get.lazyPut<Customers>(() => Customers(), fenix: true);
  // }
  @override
  void dependencies() {
    // Get.put(
    //   AccGroups(),
    // );
    Get.lazyPut<AccGroups>(() => AccGroups(), fenix: true);
    Get.lazyPut<Currencies>(() => Currencies(), fenix: true);
    Get.lazyPut<AccRestrichions>(() => AccRestrichions(), fenix: true);
    Get.lazyPut<Customers>(() => Customers(), fenix: true);
  }
}
