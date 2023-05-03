import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../../../core/constants/colors.dart';
import '../../../../../../core/routes/app_router.dart';
import '../../../../data/model/category/category.dart';

class CategoriesTab extends StatelessWidget {
  const CategoriesTab({super.key});

  @override
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsets.all(16.0),
    child: GridView.builder(
      itemCount: CategoryModel.categories.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 4 / 3,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
      ),
      itemBuilder: (context, index) {
        final category = CategoryModel.categories[index];
        return GestureDetector(
          onTap: () => context.go(
            AppRouter.layoutToBookCategory,
            extra: category.title,
          ),
          child: Card(
            clipBehavior: Clip.antiAlias,
            shadowColor: Colors.white,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15)),
            color: kPrimaryColor,
            child: GridTile(
              footer: ColoredBox(
                color: Colors.black.withOpacity(.9),
                child: Text(
                  category.title,
                  textAlign: TextAlign.center,
                  style: const TextStyle(height: 1.7, fontSize: 16),
                ),
              ),
              child: Image.asset(
                category.image,
                fit: BoxFit.contain,
              ),
            ),
          ),
        );
      },
    ),
  );
}
