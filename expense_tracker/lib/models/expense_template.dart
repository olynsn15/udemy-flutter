import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';
import 'package:intl/intl.dart';

final formatter = DateFormat.yMd();

const uuid = Uuid();

//custom type
enum Category { food, travel, leisure, work }

const categoryIcons = {
  Category.food: Icons.lunch_dining,
  Category.travel: Icons.flight_takeoff,
  Category.leisure: Icons.movie,
  Category.work: Icons.work,
};

class ExpenseTemplate {
  ExpenseTemplate({
    required this.title,
    required this.amount,
    required this.date,
    required this.categories,
  }) : id = uuid.v4();

  final String id;
  final String title;
  final double amount;
  final DateTime date;
  final Category categories;

  //pake package intl
  String get formattedDate {
    return formatter.format(date);
  }
}

class ExpenseBucket {
  ExpenseBucket({required this.category, required this.expenses});

  ExpenseBucket.forCategory(List<ExpenseTemplate> allExpenses, this.category)
      : expenses = allExpenses
            .where((ExpenseTemplate) => ExpenseTemplate.categories == category)
            .toList();

  final Category category;
  final List<ExpenseTemplate> expenses;

  double get totalExpenses {
    double sum = 0;

    for (final ExpenseTemplate in expenses) {
      sum += ExpenseTemplate.amount;
    }

    return sum;
  }
}
