class QuizQuestions {
  const QuizQuestions(
      this.text, this.answers); //supaya class bisa di reuse buat beda-beda set
  final String text;
  final List<String> answers;

  List<String> getShuffledAnswers() {
    final shuffledList = List.of(answers);
    shuffledList.shuffle();
    return shuffledList;
  }
}
//data structure buat questionsnya
//ga perlu extend apa" karena bukan widget

//sebelum shuffle list, buat copy list aslinya dulu, kita shuffle si copy itu
//teknik ini dinamakan chaining (execute function lain di hasil dari function lain)
//shuffle ternyata ga return hasil shufflenya

//jadi buat variabel baru yang store copy dari list asli
//dikasih function shuffle
//return shuffled list itu

//shuffle masih bisa diterima di final karena dia shuffle objects yang sudah ada di memory
//bukan membuat object baru