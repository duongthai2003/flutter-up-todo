// cái này để lưu trữ các category của task
class CategoryModel {
  String id;
  String name;
  int? iconCodePoint;
  String backgroundColorHex;
  String iconColorHex;

  CategoryModel({
    required this.id,
    required this.name,
    this.iconCodePoint,
    required this.backgroundColorHex,
    required this.iconColorHex,
  });
}
