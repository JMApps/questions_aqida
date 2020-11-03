import 'package:flutter/cupertino.dart';
import 'package:questions_aqida/pages/bookmarks.dart';
import 'package:questions_aqida/pages/chapters.dart';
import 'package:questions_aqida/services/db_helper.dart';

class Main extends StatefulWidget {
  @override
  _MainState createState() => _MainState();
}

class _MainState extends State<Main> {
  DBHelper dbHelper = DBHelper();

  @override
  void dispose() {
    super.dispose();
    dbHelper.closeDb();
  }

  @override
  Widget build(BuildContext context) {
    FocusScopeNode _currentFocus = FocusScope.of(context);
    return CupertinoPageScaffold(
      resizeToAvoidBottomInset: false,
      child: GestureDetector(
        onTap: () {
          if (!_currentFocus.hasPrimaryFocus) {
            _currentFocus.unfocus();
          }
        },
        child: CupertinoTabScaffold(
          tabBar: CupertinoTabBar(
            items: const [
              BottomNavigationBarItem(
                icon: Icon(
                  CupertinoIcons.list_dash,
                  color: CupertinoColors.inactiveGray,
                ),
                activeIcon: Icon(
                  CupertinoIcons.list_dash,
                  color: CupertinoColors.activeGreen,
                ),
              ),
              BottomNavigationBarItem(
                icon: Icon(
                  CupertinoIcons.bookmark,
                  color: CupertinoColors.inactiveGray,
                ),
                activeIcon: Icon(
                  CupertinoIcons.bookmark,
                  color: CupertinoColors.activeGreen,
                ),
              ),
            ],
          ),
          tabBuilder: (context, index) {
            CupertinoTabView returnValue;
            switch (index) {
              case 0:
                returnValue = CupertinoTabView(
                  builder: (context) {
                    return Chapters();
                  },
                );
                break;
              case 1:
                returnValue = CupertinoTabView(
                  builder: (context) {
                    return Bookmarks();
                  },
                );
                break;
            }
            return returnValue;
          },
        ),
      ),
    );
  }
}
