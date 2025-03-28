import 'package:flutter/material.dart';
import 'package:expense_tracker/models/expense_template.dart';

class NewExpense extends StatefulWidget {
  const NewExpense({super.key, required this.onAddExpense});

  final void Function(ExpenseTemplate expense) onAddExpense;

  @override
  State<NewExpense> createState() => _NewExpenseState();
}

class _NewExpenseState extends State<NewExpense> {
  // var _enteredTitle = '';

  // //saves every key stroke because this function is executed on onChanged
  // void _saveTitleInput(String inputValue) {
  //   _enteredTitle = inputValue;
  // }

  //text editing controller stores user input
  final _titleController = TextEditingController();
  final _amountController = TextEditingController();
  DateTime? _selectedDate;
  Category _selectedCategory = Category.leisure;

  void _presentDatePicker() async {
    final now = DateTime.now();
    final firstDate = DateTime(now.year - 1, now.month, now.day);
    //1 year before now

    final pickedDate = await showDatePicker(
      context: context,
      initialDate: now,
      firstDate: firstDate,
      lastDate: now,
    );
    //showDatePicker ini tipe datanya future, karena untuk saat ini belum ada valuenya tapi flutter tau di future akan ada
    //await basically tells flutter to wait until the value is available
    //code di bawahnya juga baru akan di execute setelah await sudah ada valuenya

    setState(() {
      _selectedDate = pickedDate;
    });
  }

  void _submitExpenseData() {
    final enteredAmount = double.tryParse(_amountController.text);

    final amountIsInvalid = enteredAmount == null || enteredAmount <= 0;
    //kalau salah 1 kondisi terpenuhi, amountIsInvalid bakal true

    //trim removes excess white space
    //will be true if we do not have a value
    if (_titleController.text.trim().isEmpty ||
        amountIsInvalid ||
        _selectedDate == null) {
      showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
          title: Text('Invalid input'),
          content: Text(
              'Please make sure a valid / title / amount / date is entered'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(ctx);
              },
              child: Text('Okay'),
            )
          ],
        ),
      );
      return;
      //jadi kalau ada code di bawahnya ga akan di execute kalau masuk if statement
    }

    widget.onAddExpense(
      ExpenseTemplate(
          title: _titleController.text,
          amount: enteredAmount,
          date: _selectedDate!,
          categories: _selectedCategory),
    );
    Navigator.pop(context);
  }

  @override
  void dispose() {
    _titleController.dispose(); //deleted when the widget is not used / closed
    _amountController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final keyboardSpace = MediaQuery.of(context).viewInsets.bottom;
    return SizedBox(
      height: double.infinity,
      child: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.fromLTRB(16, 16, 16, keyboardSpace + 16),
          child: Column(
            children: [
              TextField(
                controller: _titleController,
                maxLength: 50,
                decoration: const InputDecoration(
                  label: Text('Title'),
                ),
              ),
              Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _amountController,
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                        prefixText: '\$ ',
                        label: Text('Amount'),
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 16,
                  ),
                  Expanded(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          _selectedDate == null
                              ? 'No date selected'
                              : formatter.format(_selectedDate!),
                          //tanda seru memaksa dart untuk menganggap variable itu ga akan pernah null
                          //karena kan formatter mau nya dia ada isi, sedangkan selectedDate bisa menampung null
                        ),
                        IconButton(
                            onPressed: _presentDatePicker,
                            //date picker harus dibuat method karena onPressed mau nya function / method
                            icon: Icon(Icons.calendar_month))
                      ],
                    ),
                  )
                ],
              ),
              const SizedBox(
                height: 16,
              ),
              Row(
                children: [
                  DropdownButton(
                    value: _selectedCategory,
                    //value memastikan drop down button ada value awal yang ter select
                    items: Category.values
                        .map(
                          (categories) => DropdownMenuItem(
                            value: categories,
                            child: Text(
                              categories.name.toUpperCase(),
                            ),
                          ),
                        )
                        .toList(),
                    onChanged: (value) {
                      if (value == null) {
                        return;
                      }
                      //cek kalau user ga ada select apa"
                      setState(
                        () {
                          _selectedCategory = value;
                          //only executes if value is not null (already checked above)
                        },
                      );
                    },
                  ),
                  //values bakal display semua value di enum
                  Spacer(),
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                      //ini pake context di build method, dia remove overlay si modal screen itu
                    },
                    child: const Text('Cancel'),
                  ),
                  ElevatedButton(
                    onPressed: _submitExpenseData,
                    child: Text('Save Expense'),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
