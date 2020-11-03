import 'package:questions_aqida/models/footnote_item.dart';
import 'package:questions_aqida/models/question_item.dart';
import 'package:questions_aqida/services/db_helper.dart';

class DatabaseQuery {
  DBHelper dbHelper = DBHelper();

  Future<List<QuestionItem>> getAllQuestions() async {
    var dbClient = await dbHelper.getDb();
    var res = await dbClient.query('Table_question');

    List<QuestionItem> questions = res.isNotEmpty
        ? res.map((c) => QuestionItem.fromMap(c)).toList()
        : null;
    return questions;
  }

  Future<List<QuestionItem>> getSearchResult(String text) async {
    var dbClient = await dbHelper.getDb();
    var res = await dbClient.rawQuery(
        "SELECT * FROM Table_question WHERE Question_number LIKE '%$text%' OR  Question_content LIKE '%$text%'");

    List<QuestionItem> results = res.isNotEmpty
        ? res.map((c) => QuestionItem.fromMap(c)).toList()
        : null;
    return results;
  }

  Future<List<QuestionItem>> getBookmarkQuestions() async {
    var dbClient = await dbHelper.getDb();
    var res = await dbClient.query('Table_question', where: 'Favorite = 1');

    List<QuestionItem> bookmarks = res.isNotEmpty
        ? res.map((c) => QuestionItem.fromMap(c)).toList()
        : null;
    return bookmarks;
  }

  Future<List<QuestionItem>> addRemoveBookmark(int state, int chapterId) async {
    var dbClient = await dbHelper.getDb();
    var res = await dbClient.rawQuery(
        'UPDATE Table_question SET Favorite = $state WHERE _id == $chapterId');
    List<QuestionItem> bookmarkState = res.isNotEmpty
        ? res.map((c) => QuestionItem.fromMap(c)).toList()
        : null;
    return bookmarkState;
  }

  Future<List<FootnoteItem>> getFootnotes(int currentId) async {
    var dbClient = await dbHelper.getDb();
    var res = await dbClient.query('Table_footnote',
        where: 'Content_number = $currentId');

    List<FootnoteItem> footnotes = res.isNotEmpty
        ? res.map((c) => FootnoteItem.fromMap(c)).toList()
        : null;
    return footnotes;
  }
}
