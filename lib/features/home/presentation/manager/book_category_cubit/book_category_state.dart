part of 'book_category_cubit.dart';

enum BookCategoryStatus { initial, loading, success, error }

class BookCategoryState implements Equatable {
  final List<Book> books;
  final String error;
  final bool hasReachedMax;
  final BookCategoryStatus status;

  const BookCategoryState({
    this.books = const [],
    this.error = '',
    this.hasReachedMax = false,
    this.status = BookCategoryStatus.initial,
  });

  BookCategoryState copyWith({
    final List<Book>? books,
    final String? error,
    final bool? hasReachedMax,
    final BookCategoryStatus? status,
  }) =>
      BookCategoryState(
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
      'BookCategoryState(status: $status, books: $books, error: $error, hasReachedMax: $hasReachedMax)';
}
