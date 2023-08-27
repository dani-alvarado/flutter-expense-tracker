import 'package:hive_flutter/hive_flutter.dart';

import '../models/expense_item.dart';

class HiveDatabase {
  //reference box
  final _myBox = Hive.box("expense_db");

  //write data
  void saveData(List<ExpenseItem> allExpense) {
    //Hive can only store strings and dateTimes, not custom objects.
    List<List<dynamic>> allExpensesFormatted = [];

    for (var expense in allExpense) {
      // convert each expensItem into a list of storable types
      List<dynamic> expenseFormatted = [
        expense.name,
        expense.amount,
        expense.dateTime
      ];
      allExpensesFormatted.add(expenseFormatted);
    }

    //storeit in database
    _myBox.put('ALL_EXPENSES', allExpensesFormatted);
  }

  //read data
  List<ExpenseItem> readData() {
    List savedExpenses = _myBox.get("ALL_EXPENSES") ?? [];
    List<ExpenseItem> allExpenses = [];

    for (var expense in savedExpenses) {
      String name = expense[0];
      String amount = expense[1];
      DateTime dateTime = expense[2];

      ExpenseItem expenseItem =
          ExpenseItem(name: name, amount: amount, dateTime: dateTime);

      allExpenses.add(expenseItem);
    }

    return allExpenses;
  }
}
