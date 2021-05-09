import 'package:flutter/cupertino.dart';

import 'models/book.dart';

class BookAppState extends ChangeNotifier{
  int _selectedIndex;
  Book _selectedBook;

  final List<Book> books = [
    Book('Stranger in a Strange Land', 'Robert A. Heinlein'),
    Book('Foundation', 'Isaac Asimov'),
    Book('Fahrenheit 451', 'Ray Bradbury'),
  ];

  BookAppState(): _selectedIndex = 0;

  int get selectedIndex => _selectedIndex;

  set selectedIndex(int index){
    _selectedIndex = index;
    notifyListeners();
  }

  Book get selectedBook => _selectedBook;

  set selectedBook(Book book){
    _selectedBook = book;
    notifyListeners();
  }

  int get selectedBookId {
    if(!books.contains(_selectedBook)) return 0;
    return books.indexOf(_selectedBook);
  }

  set selectedBookById(int id){
    if(id < 0 || id > books.length - 1){
      return;
    }
    _selectedBook = books[id];
    notifyListeners();
  }

}