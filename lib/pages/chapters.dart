import 'package:flutter/cupertino.dart';
import 'package:questions_aqida/widgets/chapter_list.dart';

class Chapters extends StatefulWidget {
  @override
  _ChaptersState createState() => _ChaptersState();
}

class _ChaptersState extends State<Chapters> {
  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      resizeToAvoidBottomInset: false,
      navigationBar: CupertinoNavigationBar(
        middle: Text(
          '200 вопросов',
          style: TextStyle(
            fontFamily: 'Gilroy',
          ),
        ),
      ),
      child: SafeArea(
        child: ChapterList(),
      ),
    );
  }
}
