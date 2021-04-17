import 'package:flutter_test/flutter_test.dart';
import 'package:testing_codelab/models/favorites.dart';

void main() {
  group('App Provider Tests', () {
    test('Add item to favorites', () {
      var favorites = Favorites();
      var number = 35;
      favorites.add(number);
      expect(favorites.items.contains(number), true);
    });

    test('Remove item from favorites', () {
      var favorites = Favorites();
      var number = 35;
      favorites.add(number);
      expect(favorites.items.contains(number), true);
      favorites.remove(number);
      expect(favorites.items.contains(number), false);
    });
  });
}