import 'package:wordandmemory/model/word.dart';

class Quiz {
  List<Question> questions;
  int currentIndex;
  List<Word> words;
  Quiz(List<Word> l) {
    words = List<Word>();
    words = l;
    words.shuffle();
    currentIndex = -1;
    questions = new List<Question>();
    int size = words.length;
    for (int i = 0; i < size; i++) {
      Word w = words[i];
      words.remove(i);
      List<String> _choices = new List<String>();
      _choices.add(w.en);
      _choices.add(words[i + 1].en);
      _choices.add(words[i + 2].en);
      _choices.add(words[i + 3].en);
      _choices.shuffle();
      Question q = new Question(w, _choices);
      questions.add(q);
      words.add(w);
    }
  }

  Question get nextQuestion {
    if (currentIndex >= questions.length - 1) return null;
    currentIndex++;

    return questions[currentIndex];
  }

  bool isCorrect(String userAnswer) {
    if (userAnswer == questions[currentIndex].word.en)
      return true;
    else
      return false;
  }
}

class Question {
  Word word;
  List<String> choices;

  Question(this.word, this.choices);
}
