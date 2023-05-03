part of 'similar_books_cubit.dart';

enum SimilarBooksStatus { initial, loading, success, error }

class SimilarBooksState {
  const SimilarBooksState({
    this.books = const [],
    this.error = '',
    this.status = SimilarBooksStatus.initial,
  });

  final List<Book> books;
  final String error;
  final SimilarBooksStatus status;

  SimilarBooksState copyWith({
    final List<Book>? books,
    final String? error,
    final SimilarBooksStatus? status,
  }) =>
      SimilarBooksState(
        books: books ?? this.books,
        error: error ?? this.error,
        status: status ?? this.status,
      );

  @override
  String toString() => 'SimilarBooksState(status: $status, books: $books, error: $error)';
}
