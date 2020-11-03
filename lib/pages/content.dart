import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_html/style.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:questions_aqida/models/content_arguments.dart';
import 'package:questions_aqida/widgets/footnote_list.dart';

class Content extends StatefulWidget {
  @override
  _ContentState createState() => _ContentState();
}

class _ContentState extends State<Content> {
  @override
  Widget build(BuildContext context) {
    final ContentArguments args = ModalRoute.of(context).settings.arguments;
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: Text(
          'Вопрос ${args.chapterId}',
          style: TextStyle(fontFamily: 'Gilroy'),
        ),
        trailing: CupertinoButton(
          onPressed: () {
            showCupertinoModalBottomSheet(
              expand: true,
              context: context,
              builder: (context, scrollController) => Container(
                child: Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.all(8),
                      child: FlatButton.icon(
                        onPressed: null,
                        icon: Icon(CupertinoIcons.asterisk_circle),
                        label: Text(
                          'Сноски',
                          style: TextStyle(
                              fontFamily: 'Gilroy',
                              fontSize: 20,
                              color: CupertinoColors.darkBackgroundGray),
                        ),
                      ),
                    ),
                    Divider(
                      indent: 16,
                      endIndent: 16,
                    ),
                    Expanded(
                      child: FootnoteList(
                        currentId: args.chapterId,
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
          padding: EdgeInsets.zero,
          child: Icon(
            CupertinoIcons.asterisk_circle,
            color: CupertinoColors.destructiveRed,
          ),
        ),
      ),
      child: SafeArea(
        child: Scrollbar(
          child: SingleChildScrollView(
            child: Column(
              children: [
                Center(
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: SelectableText(
                      '${args.questionContent}',
                      style: TextStyle(
                        fontSize: 20,
                        fontFamily: 'Gilroy',
                        color: CupertinoColors.activeGreen,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
                Divider(
                  indent: 16,
                  endIndent: 16,
                ),
                Center(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Text(
                      'ОТВЕТ',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 20,
                        fontFamily: 'Gilroy',
                        color: CupertinoColors.darkBackgroundGray,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                Divider(
                  indent: 16,
                  endIndent: 16,
                ),
                Center(
                  child: Html(
                    data: '${args.answerContent}',
                    style: {
                      'html': Style(
                          fontSize: FontSize(20),
                          padding: EdgeInsets.all(8),
                          fontFamily: 'Gilroy',
                          textAlign: TextAlign.justify),
                      'strong': Style(
                        color: CupertinoColors.destructiveRed,
                      ),
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
