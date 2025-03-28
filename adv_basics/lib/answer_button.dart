import 'package:flutter/material.dart';

class AnswerButton extends StatelessWidget {
  const AnswerButton(this.answerText, this.onTap, {super.key});

  final String answerText;
  final void Function() onTap; //buat isi on pressed

  @override
  Widget build(context) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: ElevatedButton(
        onPressed: onTap,
        style: ElevatedButton.styleFrom(
          //style buttonnya
          padding: const EdgeInsets.symmetric(
            vertical: 10,
            horizontal: 40,
          ),
          backgroundColor: const Color.fromARGB(255, 56, 8, 129),
          foregroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(40),
          ),
        ),
        child: Text(
          answerText,
          textAlign: TextAlign.center,
        ), //atur style text
      ),
    );
  }
}

//stateless karena ngga ada yang harus diurus statenya
//onTap buat menentukan function apa yang di execute saat button dipencet berdasarkan dia di widget mana

//button style
//background color -> warna button
//foreground color -> warna text