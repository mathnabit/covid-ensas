import 'package:covidensa/pages/questions.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:covidensa/services/database.dart';

class QuestionsPage extends StatefulWidget {
  @override
  _QuestionsPageState createState() => _QuestionsPageState();
}

class _QuestionsPageState extends State<QuestionsPage> {
  
  DatabaseService db= new DatabaseService.authen();
  
  int currentQuestion = 0; // had variable howa ch7al man question jawbna 3lih l7ad ssa3a  li kibda bi 0 o kiybda ytzad
  int score = 0; // had variable howa resultat h7ta hiya kitabda bi 0 o kitbada tzad
  int correctCounter = 0; // hnya compteur li kiy7ssab ch7a man Question ss7i7a
  String resultat = ''; //affichage du resultat
  int wrongCounter = 10; // hanaya compteur li kiy7ssab ch7al mman question khata2e
  bool quizCompleted = false;  // had variable dyal kintisstiw bih wach quiz sala ola nn bach manb9awch kindoro fi boucle infini
  void nextQuestion(bool answer, BuildContext context) {
    setState(() {
      if (!quizCompleted) {
        wrongCounter--;
        correctCounter++;
        if (questions[currentQuestion].answer == answer) {
          score += 1;
        } else {
          
        }
      }

      if (questions.length - 1 > currentQuestion) {
        currentQuestion++;
      } else {
        quizCompleted = true;
        showResults(context);
      }
    });
  }

  void showResults(BuildContext context) {
    if(score <=2 ){
      resultat='Votre état ne semble pas préoccupant ou ne relève probablement pas du COVID 19.';
    }
    if (score>=3 && score<7 ) {
        resultat = 'Vous êtes susceptible d être infecté,continuez à appliquer les gestes barrières, surveillez la température deux fois par jour et consultez un medecin si ça continue';
      }
    if (score <= 10 && score >=7) {
        resultat = 'Votre situation peut relever d’un COVID 19. Vos symptômes nécessitent une prise en charge rapide.';
      }
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text(
              'Fin du diagnostique',
              style: TextStyle(fontSize: 32.0),
              textAlign: TextAlign.center,
            ),
            content: Container(
              height: 200.0,
              child: Column(
                children: <Widget>[
                  Icon(
                    Icons.ac_unit,
                    size: 52.0,
                    color: Colors.cyan,
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  Text('$resultat ')
                ],
              ),
            ),
            actions: <Widget>[
              FlatButton(
                child: Text('Tester une autre fois '),
                onPressed: () {
                  setState(() {
                  db.editUser( score);
                   
                    quizCompleted = false;
                    score = 0;
                    currentQuestion = 0;
                    wrongCounter = 10;
                    correctCounter = 0;
                  });
                  Navigator.of(context).pop();
                },
              )
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Expanded(
          flex: 4,
          child: Text(
            questions[currentQuestion].text,
            style: TextStyle(color: Colors.white, fontSize: 32.0),
          ),
        ),
        Expanded(
          flex: 1,
          child: ButtonTheme(
            minWidth: 200,
            buttonColor: Colors.white,
            splashColor: Colors.deepPurple,
            child: RaisedButton(
              onPressed: () {
                nextQuestion(true, context);
              },
              child: Text('Oui', style: TextStyle(fontSize: 32.0)),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30.0),
              ),
            ),
          ),
        ),
        SizedBox(
          height: 20.0,
        ),
        Expanded(
          flex: 1,
          child: ButtonTheme(
            minWidth: 200,
            buttonColor: Colors.white,
            splashColor: Colors.deepPurple,
            child: RaisedButton(
              onPressed: () {
                nextQuestion(false, context);
              },
              child: Text('Non', style: TextStyle(fontSize: 32.0)),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30.0),
              ),
            ),
          ),
        ),
        SizedBox(
          height: 40.0,
        ),
        Expanded(
          flex: 2,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              Column(
                children: <Widget>[
                  Text(
                    'Réponses',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20.0,
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    correctCounter.toString(),
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20.0,
                    ),
                  )
                ],
              ),
              Column(
                children: <Widget>[
                  Text(
                    'Questions',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20.0,
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    wrongCounter.toString(),
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20.0,
                    ),
                  )
                ],
              )
            ],
          ),
        )
      ],
    );
  }
}