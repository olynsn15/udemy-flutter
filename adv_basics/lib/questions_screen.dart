import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:adv_basics/answer_button.dart';
import 'package:adv_basics/data/questions.dart';

class QuestionsScreen extends StatefulWidget {
  const QuestionsScreen(this.onSelectAnswer, {super.key});

  final void Function(String answer) onSelectAnswer;
  //harus dikasih tahu juga functionnya nerima apa
  //ini membedakan dia dari void Function() -> kurungnya kosong -> ga menerima apa"

  @override
  State<QuestionsScreen> createState() {
    return _QuestionsScreenState();
  }
}

class _QuestionsScreenState extends State<QuestionsScreen> {
  var currentQuestionIndex = 0; //start with 0

  void answerQuestion(String selectedAnswer) {
    //answerQuestion harus menerima selectedAnswer supaya bisa di pass ke onSelectAnswer
    //dimana onSelectAnswer ini isinya function yang menerima string dan ditambah ke dalam list
    widget.onSelectAnswer(
        selectedAnswer); //pake ini bisa langsung access function di widget class
    setState(() {
      currentQuestionIndex++;
    });
  }

  @override
  Widget build(context) {
    final currentQuestions = questions[currentQuestionIndex];

    return SizedBox(
      width: double.infinity,
      child: Container(
        margin: const EdgeInsets.all(40), //supaya pinggir kanan kiri ada jarak
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center, //vertical
          crossAxisAlignment: CrossAxisAlignment.stretch, //horizontal
          children: [
            Text(
              currentQuestions.text,
              style: GoogleFonts.lato(
                color: const Color.fromARGB(255, 235, 197, 243),
                fontSize: 28,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 30),
            ...currentQuestions.getShuffledAnswers().map((answer) {
              //menerima list dari shuffled answers, terus di map sesuai jumlah objects dalam list
              //dia udah ambil values dari list jawaban
              return AnswerButton(
                answer,
                () {
                  answerQuestion(answer);
                  //harus kayak gini karena onTap maunya void function yang ga menerima apa-apa, tapi sekarang jadinya menerima string
                },
              ); //kenapa answer question ga pake () -> karena kita mau pass as a value
            }) //dart automaticallny goes through the list
          ],
        ),
      ),
    );
  }
}

//cara lain supaya backgroundnya penuh :
//wrap with sizedbox, width -> double.infinity

//accessing list values in dart
//pake index juga mirip kayak biasa
//karena kita udah buat kelas quiz_questions sebagai model, di file questions antara pertanyaan dan jawaban dianggap 1 set
//jadi begitu di access pake index, udah langsung sama jawaban juga

//hard coding buttons is not ideal
//tambahin functions ke list (ada banyak pre defined functions)
//map does not change the original list
//karena list, harus di spread semua valuesnya (tiga titik di depan)
//it will pull them out of the list and place them as comma separated values
//lebih ideal cause it deals with the data dynamically

//gimana cara shuffle set of answersnya?
//bisa pake shuffle yang ditaro sebelum map
//tapi shuffle ngeubah urutan list aslinya

//mengubah index supaya setelah klik 1 jawaban, move ke next question
//itu kenapa questions screen StatefulWidget
//ganti 0 di index current questions jadi si current questions index
//supaya build method bisa diexecute ulang, masukkin function ke set state

//kenapa button sempet gabisa?
//ke miss di answer_button, onPressed malah dibiarin kosong
//padahal harusnya diisi onTap biar functionnya bisa di pass
//haduh...

//one of the easiest ways to add fonts itu pake google fonts package
//kalau pake google fonts, si text style dihilangin, ganti Googlefonts.(nama font)()
//nanti dalemnya ada banyak function yang bisa dipake, mirip text style