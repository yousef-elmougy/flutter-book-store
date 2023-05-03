part of 'newest_books_cubit.dart';

enum NewestBooksStatus { initial, loading, success, error }

class NewestBooksState implements Equatable {
  final List<Book> books;
  final String error;
  final bool hasReachedMax;
  final NewestBooksStatus status;

  const NewestBooksState({
    this.books = const [],
    this.error = '',
    this.hasReachedMax = false,
    this.status = NewestBooksStatus.initial,
  });

  NewestBooksState copyWith({
    final List<Book>? books,
    final String? error,
    final bool? hasReachedMax,
    final NewestBooksStatus? status,
  }) =>
      NewestBooksState(
        books: books ?? this.books,
        error: error ?? this.error,
        hasReachedMax: hasReachedMax ?? this.hasReachedMax,
        status: status ?? this.status,
      );

  @override
  bool? get stringify => true;

  @override
  List<Object> get props => [books, error, hasReachedMax, status];

  @override
  String toString() =>
      'NewestBooksState(status: $status, books: $books, error: $error, hasReachedMax: $hasReachedMax)';
}
