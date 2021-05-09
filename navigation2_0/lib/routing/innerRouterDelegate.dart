import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:navigation2_0/bookAppState.dart';
import 'package:navigation2_0/models/book.dart';
import 'package:navigation2_0/routing/fadeInAnimationPage.dart';
import 'package:navigation2_0/routing/paths.dart';
import 'package:navigation2_0/screens/bookDetailsScreen.dart';
import 'package:navigation2_0/screens/bookListScreen.dart';
import 'package:navigation2_0/screens/settingScreen.dart';

class InnerRouterDelegate extends RouterDelegate<BookPath>
    with ChangeNotifier, PopNavigatorRouterDelegateMixin<BookPath> {
  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
  BookAppState _appState;

  BookAppState get appState => _appState;

  set appState(BookAppState appState) {
    if (_appState == appState) {
      return;
    }
    _appState = appState;
    notifyListeners();
  }

  InnerRouterDelegate(this._appState);

  @override
  Widget build(BuildContext context) {
    return Navigator(
      key: navigatorKey,
      pages: [
        if (appState.selectedIndex == 0) ...[
          FadeInAnimationPage(
            child: BookListScreen(
              books: appState.books,
              onTapped: _handleOnTapped,
            ),
            key: ValueKey("BookListPage"),
          ),
          if (appState.selectedBook != null)
            MaterialPage(
                key: ValueKey(appState.selectedBook),
                child: BookDetailsScreen(
                  book: appState.selectedBook,
                ))
        ] else
          FadeInAnimationPage(
              child: SettingsScreen(), key: ValueKey("SettingsPage"))
      ],
      onPopPage: (route, result) {
        appState.selectedBook = null;
        notifyListeners();
        return route.didPop(result);
      },
    );
  }

  @override
  Future<void> setNewRoutePath(BookPath configuration) async {
    assert(false);
  }

  _handleOnTapped(Book book) {
    _appState.selectedBook = book;
    notifyListeners();
  }
}
