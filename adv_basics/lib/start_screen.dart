import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class StartScreen extends StatelessWidget {
  const StartScreen(this.startQuiz, {super.key});

  final void Function() startQuiz;

  @override
  Widget build(context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Image.asset(
            'assets/images/quiz-logo.png',
            width: 300,
            color: const Color.fromARGB(128, 255, 255, 255),
          ),
          const SizedBox(
            height: 80,
          ),
          Text(
            'Lets learn flutter the fun way!',
            style: GoogleFonts.lato(
              color: const Color.fromARGB(255, 235, 197, 243),
              fontSize: 28,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(
            height: 30,
          ),
          OutlinedButton.icon(
            onPressed: startQuiz,
            style: OutlinedButton.styleFrom(
              foregroundColor: Colors.white,
              side: const BorderSide(
                color: Color.fromARGB(255, 175, 126, 238),
              ),
            ),
            icon: const Icon(Icons.arrow_right_alt),
            label: const Text('Start Quiz'),
          ),
        ],
      ),
    );
  }
}

//center buat gradient bisa full di screennya
//icon bisa ditambahin dimana aja, tapi kalau bisa diclick harus dimasukkin di button
//tambahin colors di image jadi ada overlay warna lain
//buat transparency, set warna mirip dengan warna asli, turunin transparency dari colors