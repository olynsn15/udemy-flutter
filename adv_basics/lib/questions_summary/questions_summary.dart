import 'package:flutter/material.dart';
import 'package:adv_basics/questions_summary/summary_item.dart';

class QuestionsSummary extends StatelessWidget {
  const QuestionsSummary(this.summaryData, {super.key});

  final List<Map<String, Object>> summaryData;

  @override
  Widget build(context) {
    return SizedBox(
      height: 400,
      child: SingleChildScrollView(
        child: Column(
          children: summaryData.map(
            (data) {
              return SummaryItem(data);
            },
          ).toList(),
        ),
      ),
    );
  }
}

//List summaryData perlu diubah jadi widgets karena children mau nya a list of widgets
//Text(data['question_index'] + 1) -> dart gatau valuenya apa karena dia kan mau ambil value dari key question_index
//which is object
//tapi object kan ga spesifik, jadi harus typecasting
//Text((data['question_index'] as int) + 1) pakai as supaya tau spesifik datanya apa
//1 dianggap bukan string dan ga diterima sama text
//Text(((data['question_index'] as int) + 1).toString()) diubah ke string pake .toString

//jadi row itu buat nomor sama sisa datanya
//pertanyaan, jawaban benar, jawaban user dalam 1 column

//supaya ga tembus layar pakai expanded
//expanded akan memperbolehkan widget dalam childnya (misalnya di case ini column) untuk mengambil semua space sesuai flex widget atasnya (row, column)
//karena atasnya row, max widgetnya menyesuaikan si screen width
//jadi max width column summary = max width row = screen width
//bisa ada spacing di kanan kiri karena di parent widget quiz, kita kasih margin
//jadi expanded nge restrict gitu disini

//SingleChildScrollView nge wrap widget supaya bisa discroll