import 'package:easy_localization/easy_localization.dart';
import 'package:fluter_app/entities/category_realm_entity.dart';
import 'package:fluter_app/models/categoryModel.dart';
import 'package:fluter_app/ui/category/createOrEditCategory.dart';
import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:realm/realm.dart';

class CategoryListPage extends StatefulWidget {
  const CategoryListPage({super.key});

  @override
  State<CategoryListPage> createState() => _CategoryListPageState();
}

class _CategoryListPageState extends State<CategoryListPage> {
  List<CategoryModel> categoryListDataSource = [];
  bool isEditMode = false;
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      _getCategoryListFromRealm();
    });
  }

  @override
  Widget build(BuildContext context) {
    return _buildBodyPage();
  }

  Widget _buildBodyPage() {
    return Center(
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(4),
          color: Color(0xFF363636),
        ),
        padding: EdgeInsets.symmetric(horizontal: 25, vertical: 10),
        margin: EdgeInsets.symmetric(horizontal: 24, vertical: 24),
        // color: Color(0xFF363636),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _buildChooseCategoryTitle(),
            _buildGridCategoryList(),

            _buildCreateCategoryButton(),
          ],
        ),
      ),
    );
  }

  Widget _buildChooseCategoryTitle() {
    return Column(
      spacing: 10,
      children: [
        Text(
          isEditMode
              ? "category.edit_category".tr()
              : "category.choose_category".tr(),
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Colors.white.withValues(alpha: 0.87),
          ),
        ),
        Divider(color: Color(0xFF979797), height: 1),
      ],
    );
  }

  Widget _buildGridCategoryList() {
    return GridView.builder(
      shrinkWrap: true, // cái này là để khi scroll thì không scroll được
      physics: NeverScrollableScrollPhysics(), // cái này là để khi scroll thì không scroll được
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3, // 3 cột
        childAspectRatio:
            1, // cái này là để tỷ lệ chiều rộng và chiều cao của item
      ),
      itemBuilder: (context, index) {
        final isLastIndex = index == categoryListDataSource.length;
        if (isLastIndex) {
          return _buildGridCategoryItemCreateNew();
        }
        final category = categoryListDataSource[index];
        return _buildGridCategoryItem(category);
      },
      itemCount: categoryListDataSource.length + 1, // số lượng item trong grid
    );
  }

  Widget _buildGridCategoryItem(CategoryModel category) {
    return GestureDetector(
      onTap: () {
        _onHandleClickCategoryItem(category);
      },
      child: Column(
        spacing: 16,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            height: 64,
            width: 64,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(6),
              color: colorFromHex(category.backgroundColorHex),
              border: Border.all(
                color: isEditMode
                    ? Color.fromARGB(255, 245, 145, 13)
                    : Colors.transparent,
                width: isEditMode ? 2 : 0,
              ),
            ),

            child: category.iconCodePoint != null
                ? Icon(
                    IconData(
                      category.iconCodePoint!,
                      fontFamily: 'MaterialIcons',
                    ),
                    color: colorFromHex(category.iconColorHex),
                    size: 32,
                  )
                : null,
          ),
          Text(
            category.name,
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.white, fontSize: 14),
          ),
        ],
      ),
    );
  }

  Widget _buildGridCategoryItemCreateNew() {
    return GestureDetector(
      onTap: () {
        _navigateToCreateCategoryPage();
      },
      child: Container(
        child: Column(
          spacing: 16,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              height: 64,
              width: 64,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(6),
                color: Color(0xFF8687E7),
              ),

              child: Icon(Icons.add, color: Colors.white, size: 32),
            ),
            Text(
              "category.create_new".tr(),
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.white, fontSize: 14),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCreateCategoryButton() {
    return Container(
      width: double.maxFinite,
      height: 49,
      child: Row(
        spacing: 12,
        children: [
          Expanded(
            child: TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text(
                "cancel".tr(),
                style: TextStyle(
                  color: Color(0xFF8687E7),
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
          ),
          Expanded(
            child: ElevatedButton(
              onPressed: () {
                setState(() {
                  isEditMode ? isEditMode = false : isEditMode = true;
                });
              },

              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xFF8687E7),
                padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                shape: BeveledRectangleBorder(
                  borderRadius: BorderRadius.circular(4),
                ),
              ),
              child: Text(
                "category.edit".tr(),
                style: TextStyle(color: Colors.white, fontSize: 16),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _getCategoryListFromRealm() async {
    final config = Configuration.local([
      CategoryRealmEntity.schema,
    ]); // cái này là để kết nối với realm
    final realm = Realm(config); // mở realm để đọc dữ liệu từ realm
    // RealmResults CategoryRealmEntity => List<CategoryRealmEntity>
    final categories = realm
        .all<CategoryRealmEntity>(); // lấy tất cả các category từ realm
    List<CategoryModel> categoryModals = categories.map((e) {
      return CategoryModel(
        id: e.id.hexString,
        name: e.name,
        iconCodePoint: e.iconCodePoint,
        backgroundColorHex: e.backgroundColorHex,
        iconColorHex: e.iconColorHex,
      );
    }).toList(); // chuyển đổi từ List<CategoryRealmEntity> thành List<CategoryModel>

    setState(() {
      categoryListDataSource =
          categoryModals; // cập nhật dữ liệu cho categoryListDataSource
    });
  }

  Future<void> _navigateToCreateCategoryPage() async {
    await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) {
          return CreateOrEditCategory();
        },
      ),
    );
    // chờ sau khi đóng cái trang createOrEditCategory thì lấy lại dữ liệu từ realm
    if (!mounted) return;
    await _getCategoryListFromRealm();
  }

  Future<void> _onHandleClickCategoryItem(CategoryModel category) async {
    if (isEditMode) {
      await Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) {
            return CreateOrEditCategory(categoryId: category.id);
          },
        ),
      );
      // sau khi đóng cái trang createOrEditCategory thì lấy lại dữ liệu từ realm
      if (!mounted) return;
      await _getCategoryListFromRealm();
    } else {
      Navigator.pop(
        context,
        category,
      ); // cái category trả về là category được chọn khi tắt cái modal
    }
  }
}
