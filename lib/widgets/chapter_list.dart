import 'package:questions_aqida/models/content_arguments.dart';
import 'package:questions_aqida/models/question_item.dart';
import 'package:questions_aqida/services/database_query.dart';
import 'package:flushbar/flushbar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class ChapterList extends StatefulWidget {
  @override
  _ChapterListState createState() => _ChapterListState();
}

class _ChapterListState extends State<ChapterList> {
  DatabaseQuery _query = DatabaseQuery();
  TextEditingController _textController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    _textController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.max,
      children: [
        Container(
          padding: EdgeInsets.fromLTRB(8, 8, 8, 0),
          child: _buildSearch(),
        ),
        Expanded(
          child: _buildList(),
        ),
      ],
    );
  }

  Widget _buildSearch() {
    return CupertinoTextField(
      controller: _textController,
      autocorrect: true,
      onChanged: (String text) {
        setState(() {});
      },
      decoration: BoxDecoration(
        color: CupertinoColors.extraLightBackgroundGray,
        borderRadius: BorderRadius.circular(10),
      ),
      prefix: Padding(
        padding: EdgeInsets.all(8),
        child: Icon(
          CupertinoIcons.search,
          color: CupertinoColors.activeGreen,
        ),
      ),
      placeholder: 'Поиск по главам...',
      style: TextStyle(
        fontFamily: 'Gilroy',
      ),
      clearButtonMode: OverlayVisibilityMode.editing,
    );
  }

  Widget _buildList() {
    return Container(
      child: Scrollbar(
        child: FutureBuilder<List>(
          future: _textController.text.isEmpty
              ? _query.getAllQuestions()
              : _query.getSearchResult(_textController.text),
          initialData: List(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return ListView.separated(
                itemCount: snapshot.data.length,
                itemBuilder: (context, index) {
                  return _itemChapter(index, snapshot.data[index]);
                },
                separatorBuilder: (context, index) => Divider(
                  indent: 16,
                  endIndent: 16,
                ),
              );
            } else {
              return Center(
                child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: FlatButton.icon(
                      onPressed: null,
                      icon: Icon(
                        CupertinoIcons.square_stack_3d_up_slash_fill,
                        size: 30,
                        color: CupertinoColors.activeGreen,
                      ),
                      label: Expanded(
                        child: Text(
                          'По вашему запросу ничего не найдено',
                          style: TextStyle(
                            fontSize: 20,
                            fontFamily: 'Gilroy',
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    )),
              );
            }
          },
        ),
      ),
    );
  }

  Widget _itemChapter(int index, QuestionItem item) {
    return Slidable(
      key: ValueKey(index),
      actionPane: SlidableStrechActionPane(),
      secondaryActions: [
        IconSlideAction(
          color: CupertinoColors.activeGreen,
          icon: CupertinoIcons.bookmark,
          foregroundColor: CupertinoColors.white,
          onTap: () {
            _query.addRemoveBookmark(1, item.id);
            _flushBar();
          },
        )
      ],
      child: _itemCard(index, item),
    );
  }

  Widget _itemCard(int index, QuestionItem item) {
    FocusScopeNode _currentFocus = FocusScope.of(context);
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
                    fontSize: 18,
                    fontFamily: 'Gilroy'),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 4, horizontal: 16),
              child: Text(
                '${item.questionContent}',
                style: TextStyle(
                  color: CupertinoColors.darkBackgroundGray,
                  fontSize: 20,
                  fontFamily: 'Gilroy',
                ),
              ),
            ),
          ],
        ),
        onTap: () {
          if (!_currentFocus.hasPrimaryFocus) {
            _currentFocus.unfocus();
          }
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
      message: 'Добавлено в избранное',
      icon: Icon(
        CupertinoIcons.bookmark_fill,
        color: CupertinoColors.white,
      ),
      duration: Duration(seconds: 1),
      leftBarIndicatorColor: CupertinoColors.activeGreen,
    )..show(context);
  }
}
