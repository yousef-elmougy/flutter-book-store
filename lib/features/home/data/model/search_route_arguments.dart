import 'books/book.dart';

class SearchRouteArguments {
  final Book book;
  final String result;

  const SearchRouteArguments({
    this.book = const Book(),
    this.result = '',
  });
}
