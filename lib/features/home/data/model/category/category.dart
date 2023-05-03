import '../../../../../core/constants/assets.dart';

class CategoryModel {
  final String title, image;

  const CategoryModel(this.title, this.image);

  static const categories = [
    CategoryModel('Biography', Assets.biography),
    CategoryModel('Programming', Assets.code),
    CategoryModel('Cooking', Assets.cooking),
    CategoryModel('Education', Assets.education),
    CategoryModel('Fantasy', Assets.fantasy),
    CategoryModel('Science Fiction', Assets.fiction),
    CategoryModel('Historical', Assets.history),
    CategoryModel('Horror', Assets.horror),
    CategoryModel('Humour', Assets.humor),
    CategoryModel('Jungle', Assets.jungle),
    CategoryModel('Literature', Assets.literature),
    CategoryModel('Sports', Assets.sports),
    CategoryModel('Suspense', Assets.suspense),
    CategoryModel('Crime', Assets.thriller),
    CategoryModel('Travel', Assets.travel),
  ];
}
