import 'package:dartz/dartz.dart';

import '../../../../core/error/exceptions.dart';
import '../model/books/book.dart';

abstract class BooksRepository {
  const BooksRepository();
  Future<Either<Exceptions, List<Book>>> getBestBooks();
  Future<Either<Exceptions, List<Book>>> getNewestBooks([int startIndex = 0]);
  Future<Either<Exceptions, List<Book>>> getSimilarBooks(String category);
  Future<Either<Exceptions, List<Book>>> searchBookByTitle(String query);
  Future<Either<Exceptions, List<Book>>> getSearchedBooks(
    String query, [
    int startIndex = 0,
  ]);
  Future<Either<Exceptions, List<Book>>> getBooksByCategory(
    String category, [
    int startIndex = 0,
  ]);
}
