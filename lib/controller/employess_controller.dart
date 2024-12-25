import 'package:get/get.dart';

import '../model/employee.dart';

class EmployessController {
  List<Employee> get employee => [..._employee];

  List<Employee> _employee = [
    Employee(101, 'JamesJames', '2,00,0000,0000000000', 20000000000000000,
        '2023-16-16'),
    Employee(10002, 'اسامة احمد محمد سعيد', 'Manager', 30000, '2023-16-16'),
    Employee(10003, 'Lara', 'Developer', 15000, '2023-16-16'),
    Employee(10001, 'JamesJames', 'Project Lead', 20000, '2023-16-16'),
    Employee(10002, 'Kathryn', 'Manager', 30000, '2023-16-16'),
    Employee(10003, 'Lara', 'Developer', 15000, '2023-16-16'),
    Employee(10004, 'Michael', 'Designer', 15000, '2023-16-16'),
    Employee(10005, 'Martin', 'Developer', 15000, '2023-16-16'),
    Employee(10006, 'Newberry', 'Developer', 15000, '2023-16-16'),
    Employee(10007, 'Balnc', 'Developer', 15000, '2023-16-16'),
    Employee(10008, 'Perry', 'Developer', 15000, '2023-16-16'),
    Employee(10009, 'Gable', 'Developer', 15000, '2023-16-16'),
    Employee(10010, 'Grimes', 'Developer', 15000, '2023-16-16')
  ];

  List<Employee> sortEmploys({required bool isSort}) {
    if (isSort == false) {
      _employee.sort((a, b) => a.id.compareTo(b.id));
    } else {
      _employee.sort(
        (a, b) => b.id.compareTo(a.id),
      );
    }

    return _employee;
  }
}
