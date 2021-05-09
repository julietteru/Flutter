import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:navigation2_0/appShell.dart';
import 'package:navigation2_0/bookAppState.dart';
import 'package:navigation2_0/routing/paths.dart';

class BookRouterDelegate extends RouterDelegate<BookPath>
    with ChangeNotifier, PopNavigatorRouterDelegateMixin {
  final GlobalKey<NavigatorState> navigatorKey;

  BookRouterDelegate() : navigatorKey = GlobalKey<NavigatorState>() {
    appState.addListener(notifyListeners);
  }

  BookAppState appState = BookAppState();

  BookPath get currentConfiguration {
    if (appState.selectedIndex == 1) {
      return BookSettingsPath();
    } else {
      if (appState.selectedBook == null) {
        return BookListPath();
      } else {
        return BookDetailsPath(appState.selectedBookId);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Navigator(
      key: navigatorKey,
      pages: [
        MaterialPage(child: AppShell(appState: appState,))
      ],
      onPopPage: (route, result)  {
        if(!route.didPop(result)){
          return false;
        }
        if(appState.selectedBook != null){
          appState.selectedBook = null;
        }

        notifyListeners();
        return true;
      },
    );
  }

  @override
  Future<void> setNewRoutePath(BookPath configuration) async {
    if (configuration is BookListPath) {
      appState.selectedIndex = 0;
      appState.selectedBook = null;
    } else if (configuration is BookSettingsPath) {
      appState.selectedIndex = 1;
    } else if (configuration is BookDetailsPath) {
      appState.selectedBookById = configuration.id;
    }
  }
}
