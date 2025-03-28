import 'package:expense_tracker/models/expense_template.dart';
import 'package:expense_tracker/widgets/expenses_list/expenses_list_item.dart';
import 'package:flutter/material.dart';

class ExpensesList extends StatelessWidget {
  const ExpensesList({
    super.key,
    required this.expenses,
    required this.onRemoveExpense,
  });

  final List<ExpenseTemplate> expenses;
  final void Function(ExpenseTemplate expense) onRemoveExpense;

  @override
  Widget build(BuildContext context) {
    //ListView buat kalau widgetnya sama
    //SingleChildScroll buat kalau widget berbeda
    //builder akan ngebantu supaya build pas item akan visible aja
    return ListView.builder(
      itemCount: expenses.length,
      itemBuilder: (ctx, index) => Dismissible(
        key: ValueKey(expenses[index]),
        background: Container(
          color: Theme.of(context).colorScheme.error.withOpacity(0.75),
          margin: EdgeInsets.symmetric(
              horizontal: Theme.of(context).cardTheme.margin!.horizontal),
        ),
        onDismissed: (direction) {
          onRemoveExpense(expenses[index]);
          //jadi ini sebenernya fungsi removeExpense di expenses
        },
        //key makes sure the correct data is deleted
        child: ExpensesListItem(expenses[index]),
      ), //index ini jadi single item aja yang di pass
      //dismissible bisa di swipe away
    );
  }
}
