import 'package:flutter/material.dart';
import 'question_brain.dart';
import 'package:rflutter_alert/rflutter_alert.dart';


QuizBrain quizBrain = QuizBrain();


void main() => runApp(Quizzler());

class Quizzler extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Color.fromARGB(255, 250, 250, 250),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: QuizPage(),
          ),
        ),
      ),
    );
  }
}

class QuizPage extends StatefulWidget {
  @override
  _QuizPageState createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {

  List<Icon> scoreKeeper = [];
  
  int rightAnswer = 0;
  int wrongAnswer = 0;
  void resetAnswer(){
    rightAnswer = 0;
    wrongAnswer = 0;
  }
  
  void checkAnswer(bool userPickedAnswer){
    
    bool correctAnswer = quizBrain.getQuestionAnswer();

    setState(() {

      if (quizBrain.isFinished() == true){

        Alert(
          context: context,
          title : 'Finished!',
          content: Column(
            children: <Widget>[
              Text('You have $rightAnswer right answer and $wrongAnswer wrong answer.'),
            ],
          ),
          buttons: [
            DialogButton(
              onPressed: () => Navigator.pop(context), width: 120,
              child: const Text(
                'Restart',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20
                ),
                ),)
          ]
        ).show();

        quizBrain.reset();
        resetAnswer();

        scoreKeeper=[];

      } else {
        if (userPickedAnswer == correctAnswer) {
          rightAnswer++;
        scoreKeeper.add(
          const Icon(
                Icons.check,
                color: Colors.green,
        ));
      } else {
        wrongAnswer++;
        scoreKeeper.add(const Icon(
          Icons.close,
                color: Colors.red,
        ));
      }

      }

      
      quizBrain.nextQuestion();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
       Expanded(
          flex: 5,
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Center(
              child: Text(
                quizBrain.getQuestionText(),
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 25.0,
                  color: Color.fromARGB(153, 0, 0, 0),
                ),
              ),
            ),
          ),
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: FlatButton(
              textColor: Colors.white,
              color: Colors.green,
              child: const Text(
                'True',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20.0,
                ),
              ),
              onPressed: () {
                checkAnswer(true);
              },
            ),
          ),
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: FlatButton(
              color: Colors.red,
              child: const Text(
                'False',
                style: TextStyle(
                  fontSize: 20.0,
                  color: Colors.white,
                ),
              ),
              onPressed: () {
                checkAnswer(false);
              },
            ),
          ),
        ),
        Row(
          children: scoreKeeper
          
        )
      ],
    );
  }
}

/*
question1: 'You can lead a cow down stairs but not up stairs.', false,
question2: 'Approximately one quarter of human bones are in the feet.', true,
question3: 'A slug\'s blood is green.', true,
*/
