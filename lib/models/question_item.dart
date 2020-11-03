class QuestionItem {
  int _id;
  String _questionNumber;
  String _questionContent;
  String _answerContent;
  int _favorite;

  QuestionItem(this._id, this._questionNumber, this._questionContent,
      this._answerContent, this._favorite);

  QuestionItem.fromMap(dynamic obj) {
    this._id = obj['_id'];
    this._questionNumber = obj['Question_number'];
    this._questionContent = obj['Question_content'];
    this._answerContent = obj['Answer_content'];
    this._favorite = obj['Favorite'];
  }

  int get id => _id;

  String get questionNumber => _questionNumber;

  String get questionContent => _questionContent;

  String get answerContent => _answerContent;

  int get favorite => _favorite;

  Map<String, dynamic> toMap() {
    var map = new Map<String, dynamic>();
    map['_id'] = _id;
    map['Question_number'] = _questionNumber;
    map['Question_content'] = _questionContent;
    map['Answer_content'] = _answerContent;
    map['Favorite'] = _favorite;
    return map;
  }

  @override
  String toString() => '$answerContent';
}
