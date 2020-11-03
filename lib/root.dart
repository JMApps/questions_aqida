import 'package:flutter/cupertino.dart';
import 'package:questions_aqida/pages/content.dart';
import 'package:questions_aqida/pages/main.dart';

void main() {
  runApp(
    CupertinoApp(
      theme: CupertinoThemeData(
        primaryColor: CupertinoColors.activeGreen,
      ),
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      onGenerateRoute: (RouteSettings routeSettings) {
        switch (routeSettings.name) {
          case '/':
            return CupertinoPageRoute(
                builder: (_) => Main(), settings: routeSettings);
            break;
          case '/content':
            return CupertinoPageRoute(
                builder: (_) => Content(), settings: routeSettings);
            break;
          default:
            throw Exception('Invalid route');
        }
      },
    ),
  );
}