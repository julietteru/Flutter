abstract class BookPath{}

class BookListPath extends BookPath{}
class BookSettingsPath extends BookPath{}
class BookDetailsPath extends BookPath{
  final int id;

  BookDetailsPath(this.id);
}
