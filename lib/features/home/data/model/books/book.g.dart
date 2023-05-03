// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'book.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class BookAdapter extends TypeAdapter<Book> {
  @override
  final int typeId = 0;

  @override
  Book read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Book(
      title: fields[0] as String,
      id: fields[16] as String,
      subtitle: fields[1] as String,
      thumbnail: fields[2] as String,
      authors: (fields[3] as List).cast<String>(),
      previewLink: fields[4] as String,
      infoLink: fields[5] as String,
      buyLink: fields[6] as String,
      categories: (fields[7] as List).cast<String>(),
      description: fields[8] as String,
      publisher: fields[9] as String,
      publishedDate: fields[10] as String,
      averageRating: fields[11] as num,
      ratingsCount: fields[12] as int,
      webReaderLink: fields[13] as String,
      pageCount: fields[15] as int,
      saleability: fields[14] as String,
    );
  }

  @override
  void write(BinaryWriter writer, Book obj) {
    writer
      ..writeByte(17)
      ..writeByte(0)
      ..write(obj.title)
      ..writeByte(1)
      ..write(obj.subtitle)
      ..writeByte(2)
      ..write(obj.thumbnail)
      ..writeByte(3)
      ..write(obj.authors)
      ..writeByte(4)
      ..write(obj.previewLink)
      ..writeByte(5)
      ..write(obj.infoLink)
      ..writeByte(6)
      ..write(obj.buyLink)
      ..writeByte(7)
      ..write(obj.categories)
      ..writeByte(8)
      ..write(obj.description)
      ..writeByte(9)
      ..write(obj.publisher)
      ..writeByte(10)
      ..write(obj.publishedDate)
      ..writeByte(11)
      ..write(obj.averageRating)
      ..writeByte(12)
      ..write(obj.ratingsCount)
      ..writeByte(13)
      ..write(obj.webReaderLink)
      ..writeByte(14)
      ..write(obj.saleability)
      ..writeByte(15)
      ..write(obj.pageCount)
      ..writeByte(16)
      ..write(obj.id);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is BookAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
