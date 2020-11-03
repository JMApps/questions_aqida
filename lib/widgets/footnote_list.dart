import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_html/style.dart';
import 'package:questions_aqida/models/footnote_item.dart';
import 'package:questions_aqida/services/database_query.dart';

// ignore: must_be_immutable
class FootnoteList extends StatefulWidget {
  int currentId;

  FootnoteList({Key key, this.currentId}) : super(key: key);

  @override
  _FootnoteListState createState() => _FootnoteListState();
}

class _FootnoteListState extends State<FootnoteList> {
  DatabaseQuery _query = DatabaseQuery();

  @override
  Widget build(BuildContext context) {
    return Container(
      child: _buildFootnotes(widget.currentId),
    );
  }

  Widget _buildFootnotes(int currentId) {
    return Container(
      child: Scrollbar(
        child: FutureBuilder<List>(
          future: _query.getFootnotes(currentId),
          initialData: List(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return ListView.separated(
                itemCount: snapshot.data.length,
                itemBuilder: (context, index) {
                  return _itemFootnote(
                    snapshot.data[index],
                  );
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
                        CupertinoIcons.asterisk_circle,
                        size: 30,
                      ),
                      label: Expanded(
                        child: Text(
                          'В данной главе сносок нет',
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

  Widget _itemFootnote(FootnoteItem item) {
    return Card(
      elevation: 0,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(vertical: 4, horizontal: 16),
            child: Text(
              '${item.id}',
              style: TextStyle(
                  color: CupertinoColors.destructiveRed,
                  fontSize: 18,
                  fontFamily: 'Gilroy'),
            ),
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 4, horizontal: 16),
              child: Html(
                data: '${item.footnoteContent}',
                style: {
                  'html': Style(
                      fontSize: FontSize(18),
                      color: CupertinoColors.darkBackgroundGray,
                      fontFamily: 'Gilroy'),
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
