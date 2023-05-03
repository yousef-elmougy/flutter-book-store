import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

import '../../../../core/api/api_service.dart';
import '../../../../core/cache/cache_service_impl.dart';
import '../../../../core/error/exceptions.dart';
import '../model/books/book.dart';
import 'books_repository.dart';

class BooksRepositoryImpl implements BooksRepository {
  final ApiService apiConsumer;
  final CacheServiceImpl hiveService;
  const BooksRepositoryImpl(this.apiConsumer, this.hiveService);

  /// Best Books
  @override
  Future<Either<Exceptions, List<Book>>> getBestBooks() async {
    final boxName = CacheKeys.bestBooks.name;
    if (await InternetConnectionChecker().hasConnection) {
      return  _booksOnline(
        endPoint: '/volumes?q= Programming',
        boxName: boxName,
      );
    } else {
      return  _booksOffline(boxName);
    }
  }

  /// Newest Books
  @override
  Future<Either<Exceptions, List<Book>>> getNewestBooks([
    int startIndex = 0,
  ]) async {
    final boxName = CacheKeys.newestBooks.name;
    if (await InternetConnectionChecker().hasConnection) {
      return  _booksOnline(
        endPoint:
            '/volumes?startIndex=$startIndex&maxResults=40&q= search+terms+Programming+action+Crime+Cooking+business',
        boxName: boxName,
      );
    } else {
      return  _booksOffline(boxName);
    }
  }

  /// Similar Books
  @override
  Future<Either<Exceptions, List<Book>>> getSimilarBooks(
    String category,
  ) async {
    final boxName = '${CacheKeys.similarBooks.name}$category';
    if (await InternetConnectionChecker().hasConnection) {
      return  _booksOnline(
        endPoint: '/volumes?orderBy=relevance&q=subject: $category',
        boxName: boxName,
      );
    } else {
      return  _booksOffline(boxName);
    }
  }

  ///  Books By Categories
  @override
  Future<Either<Exceptions, List<Book>>> getBooksByCategory(
    String category, [
    int startIndex = 0,
  ]) async {
    final boxName = '${CacheKeys.categoryBooks.name}$category';
    if (await InternetConnectionChecker().hasConnection) {
      return  _booksOnline(
        endPoint:
            '/volumes?startIndex=$startIndex&maxResults=40&q=subject: $category',
        boxName: boxName,
      );
    } else {
      return  _booksOffline(boxName);
    }
  }

  /// get Searched book
  @override
  Future<Either<Exceptions, List<Book>>> getSearchedBooks(
    String query, [
    int startIndex = 0,
  ]) async =>
      await _booksOnline(
        endPoint: '/volumes?startIndex=$startIndex&maxResults=40&q= $query',
        isCached: false,
      );

  /// Search for a book
  @override
  Future<Either<Exceptions, List<Book>>> searchBookByTitle(
    String query,
  ) async =>
      await _booksOnline(
        endPoint: '/volumes?q= $query',
        isCached: false,
      );

  Future<Either<Exceptions, List<Book>>> _booksOnline({
    required String endPoint,
    String? boxName,
    bool isCached = true,
  }) async {
    try {
      List<Book> books = [];

      final Map<String, dynamic> jsonData = await apiConsumer.get(endPoint);

      for (var item in jsonData['items'] ?? []) {
        books.add(Book.fromJson(item));
      }

      if (isCached) await hiveService.addBoxes(books, boxName!);

      return right(books);
    } catch (e) {
      if (e is DioError) {
        return left(ServerException.getDioException(e));
      }
      return left(ServerException(e.toString()));
    }
  }

  Future<Either<Exceptions, List<Book>>> _booksOffline(
    String boxName,
  ) async {
    try {
      List<Book> books = await hiveService.getBoxes(boxName);
      return right(books);
    } catch (e) {
      return left(CacheException(e.toString()));
    }
  }
}
