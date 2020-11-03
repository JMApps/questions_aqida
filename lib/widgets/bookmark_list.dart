import 'package:questions_aqida/models/content_arguments.dart';
import 'package:questions_aqida/models/question_item.dart';
import 'package:questions_aqida/services/database_query.dart';
import 'package:flushbar/flushbar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class BookmarkList extends StatefulWidget {
  @override
  _BookmarkListState createState() => _BookmarkListState();
}

class _BookmarkListState extends State<BookmarkList> {
  DatabaseQuery _query = DatabaseQuery();

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: _buildList(),
    );
  }

  Widget _buildList() {
    return Container(
        child: FutureBuilder<List>(
      future: _query.getBookmarkQuestions(),
      initialData: List(),
      builder: (context, snapshot) {
        return snapshot.hasData
            ? ListView.separated(
                itemCount: snapshot.data.length,
                itemBuilder: (context, index) {
                  return _itemBookmark(index, snapshot.data[index]);
                },
                separatorBuilder: (context, index) => Divider(
                  indent: 16,
                  endIndent: 16,
                ),
              )
            : Center(
                child: FlatButton.icon(
                  onPressed: null,
                  icon: Icon(
                    CupertinoIcons.bookmark,
                    size: 30,
                    color: CupertinoColors.activeGreen,
                  ),
                  label: Text(
                    'Избранных глав нет',
                    style: TextStyle(
                      fontSize: 25,
                      fontFamily: 'Gilroy',
                    ),
                  ),
                ),
              );
      },
    ));
  }

  Widget _itemBookmark(int index, QuestionItem item) {
    return Slidable(
      key: ValueKey(index),
      actionPane: SlidableStrechActionPane(),
      secondaryActions: [
        IconSlideAction(
          color: CupertinoColors.destructiveRed,
          icon: CupertinoIcons.delete_simple,
          foregroundColor: CupertinoColors.white,
          onTap: () {
            setState(() {
              _query.addRemoveBookmark(0, item.id);
            });
            _flushBar();
          },
        )
      ],
      child: _itemCard(index, item),
    );
  }

  Widget _itemCard(int index, QuestionItem item) {
    return Card(
      elevation: 0,
      child: InkWell(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.symmetric(vertical: 4, horizontal: 16),
              child: Text(
                '${item.questionNumber}',
                style: TextStyle(
                  color: CupertinoColors.activeGreen,
                  fontFamily: 'Gilroy',
                  fontSize: 18,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 4, horizontal: 16),
              child: Text(
                '${item.questionContent}',
                style: TextStyle(
                  color: CupertinoColors.darkBackgroundGray,
                  fontFamily: 'Gilroy',
                  fontSize: 20,
                ),
              ),
            ),
          ],
        ),
        onTap: () {
          Navigator.of(context, rootNavigator: true).pushNamed(
            '/content',
            arguments: ContentArguments(
                item.id, item.questionContent, item.answerContent),
          );
        },
      ),
    );
  }

  Widget _flushBar() {
    return Flushbar(
      message: 'Удалено из избранного',
      icon: Icon(
        CupertinoIcons.delete_solid,
        color: CupertinoColors.white,
      ),
      duration: Duration(seconds: 1),
      leftBarIndicatorColor: CupertinoColors.destructiveRed,
    )..show(context);
  }
}
