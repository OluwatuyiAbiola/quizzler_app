class Question {
  String questionText = 'This is a text';
  bool questionAnswer = true;


  Question(String s, bool a){
    questionText = s;
    questionAnswer = a;
  }
}

Question newQuestion = Question( 'text', true);