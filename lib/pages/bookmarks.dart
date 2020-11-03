import 'package:flutter/cupertino.dart';
import 'package:questions_aqida/widgets/bookmark_list.dart';

class Bookmarks extends StatefulWidget {
  @override
  _BookmarksState createState() => _BookmarksState();
}

class _BookmarksState extends State<Bookmarks> {
  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      resizeToAvoidBottomInset: false,
      navigationBar: CupertinoNavigationBar(
        middle: Text(
          'Избранное',
          style: TextStyle(
            fontFamily: 'Gilroy',
          ),
        ),
      ),
      child: SafeArea(
        child: Column(
          children: [
            BookmarkList(),
          ],
        ),
      ),
    );
  }
}
