import 'package:flutter/material.dart';

import 'package:adv_basics/data/questions.dart';
import 'package:adv_basics/questions_summary/questions_summary.dart';
import 'package:google_fonts/google_fonts.dart';

class ResultsScreen extends StatelessWidget {
  const ResultsScreen(this.chosenAnswers, this.onRestart, {super.key});

  final void Function() onRestart;
  final List<String> chosenAnswers;

  //map itu pasangan key dan values?
  //object is a flexible type, bisa bentuk valuesnya apa aja
  //ini set nomor dan jawabannya
  //string, object itu bukan jumlah key nya tapi formatnya?
  //jadi kayak format object si map (data structure) ini tuh formatnya key, terus value
  //ini buat dapetin list dari object" yang bakal ditampilin di summary screen
  List<Map<String, Object>> getSummaryData() {
    final List<Map<String, Object>> summary = [];

    for (var i = 0; i < chosenAnswers.length; i++) {
      summary.add(
        {
          'question_index': i,
          'question': questions[i].text,
          'correct_answer': questions[i]
              .answers[0], //karena kita set selalu jawaban pertama yang bener
          'user_answer': chosenAnswers[i],
        },
      );
    }
    return summary;
  }

  @override
  Widget build(context) {
    final summaryData = getSummaryData();
    final numTotalQuestions = questions.length;
    final numCorrectQuestions = summaryData.where((data) {
      return data['user_answer'] == data['correct_answer'];
    }).length; //ditambah length supaya dapet angkanya

    return SizedBox(
      width: double.infinity,
      child: Container(
        margin: const EdgeInsets.all(40),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'You answered $numCorrectQuestions out of $numTotalQuestions questions correctly!',
              style: GoogleFonts.lato(
                color: const Color.fromARGB(255, 235, 197, 243),
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            QuestionsSummary(summaryData),
            //execute as a function supaya bisa dapet summary map
            const SizedBox(
              height: 30,
            ),
            TextButton.icon(
              onPressed: onRestart,
              style: TextButton.styleFrom(
                foregroundColor: Colors.white,
              ),
              icon: const Icon(Icons.refresh),
              label: const Text('Restart Quiz'),
            ),
          ],
        ),
      ),
    );
  }
}

//we need to pass selected answers from quiz.dart to results_screen
//ini makanya kenapa tadi disimpan di quiz.dart biar gampang di akses results screen
//QuestionsSummary(summaryData) -> diganti bukan manggil function lagi karena udah ada variable yang menampung list dari hasil panggil function getSummaryData

//summaryData.where() -> buat filtering list, dia return list baru bukan ubah original listnya
//creates a filtered list based on the original list
//dalamnya harus pass a function
//true -> value disimpen, fale -> value dihapus
//buat nentuin true atau false kita bakal buat condition
//data['user_answer'] == data['correct_answer']; akan dianggap true dan disimpan dalam list baru
//data['user_answer'] bakal access data yang disimpan dengan key 'user_answer'

//cara lain nulis getSummaryData jadi pake getter
//List<Map<String, Object>> get SummaryData {
//diaksesnya jadi kayak variabel

//penulisan lain function yang langsung return value 
//summaryData.where((data) {return data['user_answer'] == data['correct_answer'];})
//jadi
//summaryData.where((data) => data['user_answer'] == data['correct_answer'],)