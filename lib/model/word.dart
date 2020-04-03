class Word {
  int id, totalAnswer, correctAnswer, avgAnswer;
  String tr, en, sentenceEn, sentenceTr, createdTime;

  Word.withId(this.id, this.tr, this.en, this.sentenceEn, this.sentenceTr,
      this.createdTime, this.correctAnswer, this.totalAnswer, this.avgAnswer);

  Word(this.tr, this.en, this.sentenceEn, this.sentenceTr, this.createdTime,
      this.correctAnswer, this.totalAnswer, this.avgAnswer);

  Word.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        tr = json['tr'],
        en = json['en'],
        sentenceEn = json['sentenceEn'],
        sentenceTr = json['sentenceTr'],
        createdTime = json['createdTime'],
        correctAnswer = json['correctAnswer'],
        totalAnswer = json['totalAnswer'],
        avgAnswer = json['avgAnswer'];

  Map<String, dynamic> toJson() => {
        'id': id,
        'tr': tr,
        'en': en,
        'sentenceEn': sentenceEn,
        'sentenceTr': sentenceTr,
        'createdTime': createdTime,
        'correctAnswer': correctAnswer,
        'totalAnswer': totalAnswer,
        'avgAnswer': avgAnswer
      };
}
