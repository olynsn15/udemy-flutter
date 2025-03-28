import 'package:expense_tracker/widgets/expenses_list/expenses_list.dart';
import 'package:expense_tracker/models/expense_template.dart';
import 'package:expense_tracker/widgets/new_expense.dart';
import 'package:flutter/material.dart';
import 'package:expense_tracker/widgets/chart/chart.dart';

class Expenses extends StatefulWidget {
  const Expenses({super.key});

  @override
  State<Expenses> createState() => _ExpensesState();
}

class _ExpensesState extends State<Expenses> {
  final List<ExpenseTemplate> _reqisteredExpenses = [
    ExpenseTemplate(
      title: 'Flutter Course',
      amount: 19.99,
      date: DateTime.now(),
      categories: Category.work,
    ),
    ExpenseTemplate(
      title: 'Cinema',
      amount: 15.69,
      date: DateTime.now(),
      categories: Category.leisure,
    ),
  ];

  void _openAddExpenseOverlay() {
    //adds modal overlay when executed
    showModalBottomSheet(
      useSafeArea: true,
      isScrollControlled: true,
      context: context,
      builder: (ctx) => NewExpense(onAddExpense: _addExpense),
    );
  }

  void _addExpense(ExpenseTemplate expense) {
    //add a new item to the list
    setState(() {
      _reqisteredExpenses.add(expense);
    });
  }

  void _removeExpense(ExpenseTemplate expense) {
    final expenseIndex = _reqisteredExpenses.indexOf(expense);
    //buat dapetin index dari expense yang di hapus

    setState(() {
      _reqisteredExpenses.remove(expense);
      //makes sure the item is removed internally from the list, not just visually
    });

    ScaffoldMessenger.of(context).clearSnackBars();

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        duration: Duration(seconds: 3),
        content: Text('Expense deleted'),
        action: SnackBarAction(
          label: 'Undo',
          onPressed: () {
            setState(
              () {
                _reqisteredExpenses.insert(expenseIndex, expense);
                //insert sesuai index tertentu, kalau add asal add di belakang
              },
            );
          },
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    Widget mainContent = Center(
      child: Text('No expenses found. Start adding some!'),
    );

    if (_reqisteredExpenses.isNotEmpty) {
      mainContent = ExpensesList(
        expenses: _reqisteredExpenses,
        onRemoveExpense: _removeExpense,
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('Flutter Expense tracker'),
        actions: [
          IconButton(
            onPressed: _openAddExpenseOverlay,
            icon: Icon(Icons.add),
          )
        ],
      ),
      body: width < 600
          ? Column(
              children: [
                //Tool bar for users to add their own expenses - for width below 600
                Chart(expenses: _reqisteredExpenses),
                Expanded(
                  child: mainContent,
                ),
              ],
            )
          : Row(
              children: [
                //Tool bar for users to add their own expenses - for width above 600 (jadi row)
                Expanded(
                  child: Chart(expenses: _reqisteredExpenses),
                ),
                Expanded(
                  child: mainContent,
                ),
              ],
            ),
    );
  }
}
