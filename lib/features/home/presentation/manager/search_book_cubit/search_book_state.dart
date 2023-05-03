part of 'search_book_cubit.dart';

enum SearchBookStatus { initial, loading, success, error }

class SearchBookState implements Equatable {
  final List<Book> books;
  final String error;
  final bool hasReachedMax;
  final SearchBookStatus status;

  const SearchBookState({
    this.books = const [],
    this.error = '',
    this.hasReachedMax = false,
    this.status = SearchBookStatus.initial,
  });

  SearchBookState copyWith({
    final List<Book>? books,
    final String? error,
    final bool? hasReachedMax,
    final SearchBookStatus? status,
  }) =>
      SearchBookState(
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
      'SearchBookState(status: $status, books: $books, error: $error, hasReachedMax: $hasReachedMax)';
}

