import 'package:flutter/cupertino.dart';
import 'package:navigation2_0/routing/paths.dart';

class BookRouteInformationParser extends RouteInformationParser<BookPath> {
  @override
  Future<BookPath> parseRouteInformation(
      RouteInformation routeInformation) async {
    var uri = Uri.parse(routeInformation.location);

    if (uri.pathSegments.isNotEmpty && uri.pathSegments.first == "settings") {
      return BookSettingsPath();
    } else {
      if (uri.pathSegments.length >= 2) {
        if (uri.pathSegments[0] == "book") {
          return BookDetailsPath(int.tryParse(uri.pathSegments[1]));
        }
      }
      return BookListPath();
    }
  }

  @override
  RouteInformation restoreRouteInformation(BookPath configuration) {
    if (configuration is BookListPath) {
      return RouteInformation(location: '/home');
    }
    if (configuration is BookSettingsPath) {
      return RouteInformation(location: '/settings');
    }
    if (configuration is BookDetailsPath) {
      return RouteInformation(location: '/book/${configuration.id}');
    }
    return null;
  }
}
