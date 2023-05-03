part of 'best_books_cubit.dart';

enum BestBooksStatus { initial, loading, success, error }

class BestBooksState {
  const BestBooksState({
    this.books = const [],
    this.error = '',
    this.status = BestBooksStatus.initial,
  });

  final List<Book> books;
  final String error;
  final BestBooksStatus status;

  BestBooksState copyWith({
    final List<Book>? books,
    final String? error,
    final BestBooksStatus? status,
  }) =>
      BestBooksState(
        books: books ?? this.books,
        error: error ?? this.error,
        status: status ?? this.status,
      );

  @override
  String toString() => 'BestBooksState(status: $status, books: $books, error: $error)';
}

