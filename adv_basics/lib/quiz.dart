import 'package:flutter/material.dart';

import 'package:adv_basics/start_screen.dart';
import 'package:adv_basics/questions_screen.dart';
import 'package:adv_basics/data/questions.dart';
import 'package:adv_basics/results_screen.dart';

class Quiz extends StatefulWidget {
  const Quiz({super.key});

  @override
  State<Quiz> createState() {
    //initstate udah dijalanin disini makanya bisa di execute sebelum build jalan
    return _QuizState();
  }
}

class _QuizState extends State<Quiz> {
  List<String> selectedAnswers =
      []; //bisa final karena ga ada re assign, nambahin ke list aja
  var activeScreen = 'start-screen';

  // Widget?
  //     activeScreen; //diganti dari var jadi widget supaya less restrictive //widgets can be stored in variables

  // @override
  // void initState() {
  //   activeScreen = StartScreen(switchScreen);
  //   super.initState();
  // }

  void switchScreen() {
    setState(() {
      activeScreen = 'questions-screen';
    });
  }

  void chooseAnswer(String answer) {
    selectedAnswers.add(answer);

    //buat cek jawaban udah sesuai sama soal atau belum, jadi tau kapan stop
    if (selectedAnswers.length == questions.length) {
      setState(() {
        activeScreen = 'results-screen';
        //karena bukan questions-screen jadi otomatis di set ke widget start_screen?
      });
    }
  }

  void restartQuiz() {
    setState(() {
      selectedAnswers = [];
      activeScreen = 'questions-screen';
    });
  }

  @override
  Widget build(context) {
    Widget screenWidget =
        StartScreen(switchScreen); //diawali widget start screen

    if (activeScreen == 'questions-screen') {
      //bakal keganti setelah switch screen jalan
      //krn variable active screen ganti, widget yang ditunjukkan juga ganti
      screenWidget = QuestionsScreen(chooseAnswer);
    }

    if (activeScreen == 'results-screen') {
      screenWidget = ResultsScreen(selectedAnswers, restartQuiz);
    }

    return MaterialApp(
      home: Scaffold(
        body: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Color.fromARGB(255, 75, 37, 139),
                Colors.deepPurple,
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          child: screenWidget, //false
        ),
      ),
    );
  }
}

//lifting state up
//dibuat 1 widget setiap screennya, disambung parent state
//function SwitchScreen kan harusnya bisa dipake dalem widget start_screen karena buttonnya disitu
//jadi, di start_screen dibuat variable void Function dan di add postional argument di sebelah si super
//di widget quiz, di set activeScreen awalnya si start_screen, pass si switchScreen di dalemnya
//tapi ada error karena si switchScreen dianggep belum ada pas di execute
//buat function baru namanya initstate yang akan di execute sebelum build method jalan
//gausah di wrap switch state
//tambahin ? di widget awal untuk ngasih tahu dia bisa aja NULL isinya
//we succesfully lifted up state

//cara lain tanpa initstate
//perscreen ditandain pake string, using ternary operator

//jadi bisa pake initstate, ternary, atau if else

//kita simpan jawaban user disini karena nanti datanya juga diperluin sama results screen
//karena ini parents widget, nantinya dia juga akan menampilkan results screen

//selectedAnswers = [] -> selectedAnswers gabisa di set as final variable karena perlu di re assign jadi kosong
//karena results screen menerima list jawaban user yang di declare di quiz, jadi selected answers tinggal di pass ke si widgetnya

//si empty list nya tadi kan dibuat karena kita mau restart quiz
//tapi sekarang kita mau tampilin results screen