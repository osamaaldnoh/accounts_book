import 'package:accounts_book/api/app_db1.dart';
import 'package:accounts_book/api/my_bindings.dart';
import 'package:accounts_book/api/routes_class.dart';
import 'package:accounts_book/controller/acc_groups.dart';
import 'package:accounts_book/model/acc_restrichion.dart';
import 'package:accounts_book/screen/acc_groups_screen.dart';
import 'package:accounts_book/screen/currencies_screen.dart';
import 'package:accounts_book/screen/main_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sqflite/sqflite.dart';

import 'package:path/path.dart';

import 'controller/acc_restrichions.dart';
import 'controller/currencies.dart';
import 'controller/customers.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // String dataBasepath = await getDatabasesPath();
  // String path = join(dataBasepath, 'accounts_book.db');
  // AppDB.deleteDatabase(path);
  AppDB.db;
  // await MyBindings().dependencies;
  //MyBindings().dependencies();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      //home: MainScreen(),
      initialBinding: MyBindings(),
      initialRoute: RoutesClass.home,
      getPages: RoutesClass.routes,
      routes: {
        CurrenciesScreen.routeName: (_) => CurrenciesScreen(),
        AccGroupsScreen.routeName: (_) => AccGroupsScreen(),
      },
    );
  }
}
