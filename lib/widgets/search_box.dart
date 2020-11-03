import 'package:flutter/cupertino.dart';
import 'package:questions_aqida/services/db_helper.dart';

class SearchBox extends StatefulWidget {
  @override
  _SearchBoxState createState() => _SearchBoxState();
}

class _SearchBoxState extends State<SearchBox> {
  DBHelper dbHelper = DBHelper();
  TextEditingController _textController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    _textController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.maxFinite,
      padding: EdgeInsets.all(8),
      child: _buildSearch(),
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
}
