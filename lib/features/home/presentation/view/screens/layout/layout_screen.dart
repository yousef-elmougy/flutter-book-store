import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../../../../../../core/cache/cache_service_impl.dart';
import '../../../../../../core/constants/colors.dart';
import '../../../../data/model/books/book.dart';
import 'book_marked_tab.dart';
import 'categories_tab.dart';
import 'home_tab.dart';

class LayoutScreen extends StatefulWidget {
  const LayoutScreen({super.key});

  @override
  State<LayoutScreen> createState() => _LayoutScreenState();
}

class _LayoutScreenState extends State<LayoutScreen> {
  int currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    const screens = [HomeTab(), CategoriesTab(), BookMarkedTab()];
    return Scaffold(
      bottomNavigationBar: ClipRRect(
        borderRadius: BorderRadius.circular(15),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaY: 15, sigmaX: 15),
          child: BottomNavigationBar(
            backgroundColor: Colors.white.withAlpha(20),
            currentIndex: currentIndex,
            onTap: (index) => setState(() => currentIndex = index),
            type: BottomNavigationBarType.fixed,
            showUnselectedLabels: false,
            showSelectedLabels: false,
            items: [
              const BottomNavigationBarItem(
                label: '',
                icon: Icon(Icons.book),
              ),
              const BottomNavigationBarItem(
                label: '',
                icon: Icon(Icons.category),
              ),
              BottomNavigationBarItem(
                label: '',
                icon: Badge.count(
                  count:
                      Hive.box<Book>(CacheKeys.bookMarked.name).values.length,
                  backgroundColor: kOrangeColor,
                  child: const Icon(Icons.bookmarks),
                ),
              ),
            ],
          ),
        ),
      ),
      body: screens[currentIndex],
    );
  }
}
