import 'package:flutter/material.dart';
import 'package:flutter_expense_tracker/components/expense_summary.dart';
import 'package:flutter_expense_tracker/components/expense_tile.dart';
import 'package:flutter_expense_tracker/data/expense_data.dart';
import 'package:flutter_expense_tracker/models/expense_item.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final newExpenseNameController = TextEditingController();
  final newExpenseUnitAmountController = TextEditingController();
  final newExpenseDecimalAmountController = TextEditingController();

  @override
  void initState() {
    super.initState();
    // prepare data on startup
    Provider.of<ExpenseData>(context, listen: false).prepareData();
  }

  void addNewExpense() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Add a new expense'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Expense Name
            TextField(
              controller: newExpenseNameController,
              decoration: const InputDecoration(
                hintText: "Name",
              ),
            ),
            //Expense amount
            Row(
              children: [
                // units
                Expanded(
                  child: TextField(
                    controller: newExpenseUnitAmountController,
                    keyboardType: TextInputType.number,
                    decoration:
                        const InputDecoration(hintText: "Units in thousands"),
                  ),
                ),

                //Decimals
                Expanded(
                  child: TextField(
                    controller: newExpenseDecimalAmountController,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(hintText: "Decimals"),
                  ),
                )
              ],
            ),
          ],
        ),
        actions: [
          MaterialButton(onPressed: save, child: const Text('Save')),
          MaterialButton(onPressed: cancel, child: const Text('Cancel')),
        ],
      ),
    );
  }

  void deleteExpense(ExpenseItem expense) {
    Provider.of<ExpenseData>(context, listen: false).deleteExpense(expense);
  }

  void save() {
    //only save if everything is filled
    if (newExpenseNameController.text.isNotEmpty &&
        newExpenseUnitAmountController.text.isNotEmpty &&
        newExpenseDecimalAmountController.text.isNotEmpty) {
      String amount =
          '${newExpenseUnitAmountController.text}.${newExpenseDecimalAmountController.text}';

      ExpenseItem newExpense = ExpenseItem(
          name: newExpenseNameController.text,
          amount: amount,
          dateTime: DateTime.now());
      Provider.of<ExpenseData>(context, listen: false)
          .addNewExpense(newExpense);
    }

    Navigator.pop(context);
    clear();
  }

  void cancel() {
    Navigator.pop(context);
    clear();
  }

  //clear controllers

  void clear() {
    newExpenseUnitAmountController.clear();
    newExpenseDecimalAmountController.clear();
    newExpenseNameController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ExpenseData>(
        builder: (context, value, child) => Scaffold(
            backgroundColor: Colors.grey[300],
            floatingActionButton: FloatingActionButton(
              onPressed: addNewExpense,
              backgroundColor: Colors.black,
              child: const Icon(Icons.add),
            ),
            body: ListView(
              children: [
                //weekly summary
                ExpenseSummary(startOfWeek: value.startOfTheWeekDate()),

                const SizedBox(
                  height: 20,
                ),
                //expense list
                ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: value.getAllExpenseList().length,
                    itemBuilder: (context, index) => ExpenseTile(
                          name: value.getAllExpenseList()[index].name,
                          amount: value.getAllExpenseList()[index].amount,
                          dateTime: value.getAllExpenseList()[index].dateTime,
                          deleteTapped: (p0) =>
                              deleteExpense(value.getAllExpenseList()[index]),
                        ))
              ],
            )));
  }
}
