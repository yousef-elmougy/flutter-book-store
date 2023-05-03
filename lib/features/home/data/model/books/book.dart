import 'package:equatable/equatable.dart';
import 'package:hive_flutter/hive_flutter.dart';

part 'book.g.dart';

@HiveType(typeId: 0)
class Book implements Equatable {
  @HiveField(0)
  final String title;
  @HiveField(1)
  final String subtitle;
  @HiveField(2)
  final String thumbnail;
  @HiveField(3)
  final List<String> authors;
  @HiveField(4)
  final String previewLink;
  @HiveField(5)
  final String infoLink;
  @HiveField(6)
  final String buyLink;
  @HiveField(7)
  final List<String> categories;
  @HiveField(8)
  final String description;
  @HiveField(9)
  final String publisher;
  @HiveField(10)
  final String publishedDate;
  @HiveField(11)
  final num averageRating;
  @HiveField(12)
  final int ratingsCount;
  @HiveField(13)
  final String webReaderLink;
  @HiveField(14)
  final String saleability;
  @HiveField(15)
  final int pageCount;
  @HiveField(16)
  final String id;

  const Book({
    this.title = '',
    this.id = '',
    this.subtitle = '',
    this.thumbnail = '',
    this.authors = const [''],
    this.previewLink = '',
    this.infoLink = '',
    this.buyLink = '',
    this.categories = const [''],
    this.description = '',
    this.publisher = '',
    this.publishedDate = '',
    this.averageRating = 0,
    this.ratingsCount = 0,
    this.webReaderLink = '',
    this.pageCount = 0,
    this.saleability = '',
  });

  factory Book.fromJson(Map<String, dynamic> json) {
    final volumeInfo = json['volumeInfo'] ?? {};
    final accessInfo = json['accessInfo'] ?? {};
    final saleInfo = json['saleInfo'] ?? {};
    final listPrice = json['saleInfo']['listPrice'] ?? {};
    final imageLinks = json['volumeInfo']['imageLinks'] ?? {};
    return Book(
      id: json['id'],
      title: volumeInfo['title'] ?? '',
      subtitle: volumeInfo['subtitle'] ?? '',
      thumbnail: imageLinks['thumbnail'] ??
          'https://www.wildhareboca.com/wp-content/uploads/sites/310/2018/03/image-not-available.jpg',
      authors: (volumeInfo['authors'] as List<dynamic>?)
              ?.map((e) => e.toString())
              .toList() ??
          [''],
      previewLink: volumeInfo['previewLink'],
      infoLink: volumeInfo['infoLink'],
      buyLink: saleInfo['buyLink'] ?? '',
      categories: (volumeInfo['categories'] as List<dynamic>?)
              ?.map((e) => e.toString())
              .toList() ??
          [''],
      description: volumeInfo['description'] ?? '',
      publisher: volumeInfo['publisher'] ?? '',
      publishedDate: volumeInfo['publishedDate'] ?? '',
      averageRating: volumeInfo['averageRating'] ?? 0,
      ratingsCount: volumeInfo['ratingsCount'] ?? 0,
      webReaderLink: accessInfo['webReaderLink'] ?? '',
      pageCount: volumeInfo['pageCount'] ?? 0,
      saleability: saleInfo['saleability'] == 'FREE'
          ? 'Free'
          : saleInfo['saleability'] == 'FOR_SALE'
              ? '${((listPrice['amount'] / 30 as double).toStringAsFixed(2))} \$'
              : saleInfo['saleability'] == 'NOT_FOR_SALE'
                  ? 'not for sale'
                  : '',
    );
  }

  @override
  List<Object?> get props => [
        title,
        subtitle,
        thumbnail,
        authors,
        previewLink,
        infoLink,
        buyLink,
        categories,
        description,
        publisher,
        publishedDate,
        averageRating,
        ratingsCount,
        webReaderLink,
        pageCount,
        saleability,
      ];

  @override
  bool? get stringify => true;
}
