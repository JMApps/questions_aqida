class FootnoteItem {
  int _id;
  String _footnoteContent;

  FootnoteItem(this._id, this._footnoteContent);

  FootnoteItem.fromMap(dynamic obj) {
    this._id = obj['_id'];
    this._footnoteContent = obj['Footnote_content'];
  }

  int get id => _id;

  String get footnoteContent => _footnoteContent;

  Map<String, dynamic> toMap() {
    var map = new Map<String, dynamic>();
    map['_id'] = _id;
    map['Footnote_content'] = _footnoteContent;
    return map;
  }

  @override
  String toString() => '$footnoteContent';
}