class Employee {
  /// Creates the employee class with required details.
  Employee(this.id, this.name, this.designation, this.salary,this.data);

  /// Id of an employee.
  final int id;

  final String data;
  /// Name of an employee.
  final String name;

  /// Designation of an employee.
  final String designation;

  /// Salary of an employee.
  final int salary;
}

class Employeess {
  /// Creates the employee class with required details.
  Employeess(this.id, this.name, this.designation, this.salary, this.childern,
      [this.isExpanded = false]);

  final List childern;
  bool isExpanded;

  /// Id of an employee.
  final int id;

  /// Name of an employee.
  final String name;

  /// Designation of an employee.
  final String designation;

  /// Salary of an employee.
  final int salary;
}
