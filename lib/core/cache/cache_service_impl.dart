import 'package:flutter/cupertino.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../error/exceptions.dart';
import 'cache_service.dart';

enum CacheKeys {
  bestBooks,
  newestBooks,
  similarBooks,
  categoryBooks,
  bookMarked,
}

class CacheServiceImpl implements CacheService {
  const CacheServiceImpl();

  @override
  Future<void> addBoxes<T>(List<T> items, String boxName) async {
    final openBox = await Hive.openBox(boxName);

    await openBox.clear();

    for (var item in items) {
      await openBox.add(item);
    }
    debugPrint("adding boxes ,boxName: $boxName ==>> items: $items ");
  }

  @override
  Future<List<T>> getBoxes<T>(String boxName) async {
    List<T> boxList = <T>[];

    final openBox = await Hive.openBox(boxName);

    int length = openBox.length;

    for (int i = 0; i < length; i++) {
      boxList.add(openBox.getAt(i));
    }
    if (boxList.isNotEmpty) {
      debugPrint(
          'boxList ==>> $boxName ------------------------------>> $boxList');
      return boxList;
    } else {
      throw const CacheException('Check Internet Connection');
    }
  }
}
