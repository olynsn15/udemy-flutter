import 'package:expense_tracker/models/expense_template.dart';
import 'package:flutter/material.dart';

class ExpensesListItem extends StatelessWidget {
  const ExpensesListItem(this.expense, {super.key});

  final ExpenseTemplate expense;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              expense.title,
              style: Theme.of(context).textTheme.titleLarge,
            ),
            SizedBox(height: 4),
            Row(
              children: [
                Text(
                  '\$${expense.amount.toStringAsFixed(2)}', //ambil 2 angka belakang koma aja
                ),
                Spacer(),
                Row(
                  children: [
                    Icon(categoryIcons[expense.categories]),
                    SizedBox(
                      width: 8,
                    ),
                    Text(expense
                        .formattedDate), //ga pake kurung karena ini getter bukan method
                  ],
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
