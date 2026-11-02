import 'package:easy_localization/easy_localization.dart';
import 'package:fluter_app/entities/category_realm_entity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:flutter_iconpicker/Models/configuration.dart';
import 'package:flutter_iconpicker/flutter_iconpicker.dart';
import 'package:realm/realm.dart';

class CreateOrEditCategory extends StatefulWidget {
  final String? categoryId;
  const CreateOrEditCategory({super.key, this.categoryId});

  @override
  State<CreateOrEditCategory> createState() => _CreateOrEditCategoryState();
}

class _CreateOrEditCategoryState extends State<CreateOrEditCategory> {
  final _nameCategoryController = TextEditingController();
  //  khai báo màu sắc cho danh mục
  // final List<Color> _colorsDataSource = [
  //   const Color(0xFFC9CC41),

  //   const Color(0xFF66CC41),
  //   const Color(0xFF41CCA7),
  //   const Color(0xFF4181CC),
  //   const Color(0xFF41A2CC),
  //   const Color(0xFFCC8441),
  //   const Color(0xFF9741CC),
  //   const Color(0xFFCC4173),
  // ];
  //  nếu muốn gán luôn khi ở phần trên khai báo thì dùng 1 trong 3 cách :
  // 1. late Color? backgroundCategoryColor = _colorsDataSource[0];
  // 2. khai báo _colorsDataSource  là static const
  // 3. khai báo trong initState()
  // ==> nếu khoognn dùng các cách trên thì  nó báo lỗi vì: Khi tạo object, các initializer của field chạy trước constructor và trước initState. Ở thời điểm đó Dart chưa cho phép dùng this hay field khác của cùng instance, kể cả khi field đó khai báo phía trên. Lý do là thứ tự khởi tạo field không được phép phụ thuộc lẫn nhau.

  late Color backgroundCategoryColor = Colors.white.withValues(alpha: 0.20);

  // khai báo 1 lần khi chạy lần đầu tiên
  // @override
  // void initState() {
  //   super.initState();
  //   _colorsDataSource.addAll([
  //     const Color(0xFFC9CC41),

  //     const Color(0xFF66CC41),
  //     const Color(0xFF41CCA7),
  //     const Color(0xFF4181CC),
  //     const Color(0xFF41A2CC),
  //     const Color(0xFFCC8441),
  //     const Color(0xFF9741CC),
  //     const Color(0xFFCC4173),
  //   ]);
  //   backgroundCategoryColor = _colorsDataSource[0];
  // }
  IconPickerIcon? _iconSelected;
  late Color iconAndTextColor = Colors.white;

  bool get isEdit {
    return widget.categoryId != null;
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      // cái này là để chạy code sau khi widget được render
      if (isEdit) {
        _findCategoryByIdRealm(widget.categoryId!);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF121212),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: Text(
          isEdit
              ? "category.edit_category".tr()
              : "category.create_new_category".tr(),
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.w700,
          ),
        ),
        iconTheme: IconThemeData(color: Colors.white),
      ),
      body: _buildBody(context),
    );
  }

  Widget _buildBody(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        spacing: 20,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Column(
              spacing: 20,
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _categoryNameField(),
                _categoryIconField(),
                _categoryColor(),
                _IconAndTextCategoryColor(),
                _previewCategory(),
              ],
            ),
          ),
          _bottomButton(),
        ],
      ),
    );
  }

  Widget _categoryNameField() {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _titleField("category.category_name".tr()),
          Container(
            margin: EdgeInsets.only(top: 10),
            child: TextFormField(
              controller: _nameCategoryController, //để lấy value từ textfield
              style: TextStyle(color: Colors.white, fontSize: 16),
              decoration: InputDecoration(
                // hintText tương đương với placeholder
                hintText: "category.category_name".tr(),
                hintStyle: TextStyle(color: Color(0xFFAFAFAF), fontSize: 16),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(4),
                  borderSide: BorderSide(width: 1, color: Color(0xF979797)),
                ),
              ),
              onChanged: (String? value) {
                setState(() {});
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _categoryIconField() {
    return Container(
      child: Column(
        spacing: 16,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _titleField("category.category_icon".tr()),
          GestureDetector(
            onTap: () {
              _chooseIcon();
            },
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(6),
                color: Colors.white.withValues(alpha: 0.20),
              ),

              child: _iconSelected != null
                  ? Icon(_iconSelected?.data, color: iconAndTextColor, size: 26)
                  : Text(
                      "category.choose_icon_from_library".tr(),
                      style: TextStyle(
                        color: Colors.white.withValues(alpha: 0.87),
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _categoryColor() {
    return Container(
      child: Column(
        spacing: 16,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _titleField("category.background_color".tr()),
          GestureDetector(
            onTap: _onChooseCategoryBackgroundColor,
            child: Container(
              width: 36,
              height: 36,
              margin: EdgeInsets.only(right: 12),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(36 / 2),
                color: backgroundCategoryColor,
              ),
            ),
          ),
          // Container(
          //   margin: EdgeInsets.only(top: 10),
          //   width: double.infinity,
          //   height: 36,
          //   child: ListView.builder(
          //     scrollDirection: Axis.horizontal, // chiều cuộn ngang
          //     itemBuilder: (context, index) {
          //       final colorItem = _colorsDataSource[index];
          //       final isSelected = backgroundCategoryColor == colorItem;
          //       return GestureDetector(
          //         onTap: () {
          //           print("click on: ${index}");
          //           setState(() {
          //             backgroundCategoryColor = colorItem;
          //           });
          //         },
          //         child: Container(
          //           width: 36,
          //           height: 36,
          //           margin: EdgeInsets.only(right: 12),
          //           decoration: BoxDecoration(
          //             borderRadius: BorderRadius.circular(36 / 2),
          //             color: colorItem,
          //           ),
          //           child: isSelected
          //               ? Icon(Icons.check, color: Colors.white)
          //               : null,
          //         ),
          //       );
          //     },
          //     itemCount: _colorsDataSource.length,
          //   ),
          // ),
        ],
      ),
    );
  }

  Widget _titleField(String title) {
    return Text(
      title,
      style: TextStyle(
        fontSize: 16,
        color: Colors.white.withValues(alpha: 0.87),
      ),
    );
  }

  Widget _bottomButton() {
    return Container(
      margin: EdgeInsets.only(bottom: 64),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text(
              "cancel".tr(),
              style: TextStyle(fontSize: 16, color: Color(0xFF8687E7)),
            ),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Color(0xFF8875FF),
              padding: EdgeInsets.symmetric(vertical: 12, horizontal: 24),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(4),
              ),
            ),
            onPressed: () {
              isEdit ? _handleEditCategory() : _handleCreateCategory();
            },
            child: Text(
              isEdit
                  ? "category.edit_category".tr()
                  : "category.create_category".tr(),
              style: TextStyle(fontSize: 16, color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }

  Widget _IconAndTextCategoryColor() {
    return Container(
      child: Column(
        spacing: 16,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _titleField("category.icon_and_text_color".tr()),
          GestureDetector(
            onTap: _onChooseIconAndTextCategoryColor,
            child: Container(
              width: 36,
              height: 36,
              margin: EdgeInsets.only(right: 12),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(36 / 2),
                color: iconAndTextColor,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _previewCategory() {
    return Container(
      child: Column(
        spacing: 16,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _titleField("category.preview_category".tr()),
          Container(
            height: 64,
            width: 64,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(6),
              color: backgroundCategoryColor,
            ),

            child: Icon(_iconSelected?.data, color: iconAndTextColor, size: 32),
          ),
          Text(
            _nameCategoryController.text,
            style: TextStyle(color: Colors.white, fontSize: 14),
          ),
        ],
      ),
    );
  }

  void _handleCreateCategory() async {
    try {
      final categoryName = _nameCategoryController.text;
      final categoryBackgroundColor =
          '#${backgroundCategoryColor.toHexString()}';
      final iconAndTextColorHex = '#${iconAndTextColor.toHexString()}';
      print(Configuration.defaultRealmPath);

      if (categoryName.isEmpty) {
        // không làm gì cả
        // show thông báo cho user biết
        _showAlert("notification".tr(), "category.name_required".tr());
        return;
      }
      if (_iconSelected?.data == null) {
        // không làm gì cả
        // show thông báo cho user biết
        _showAlert("notification".tr(), "category.icon_required".tr());
        return;
      }
      // mở realm chuẩn bị ghi dữ liệu
      var config = Configuration.local([CategoryRealmEntity.schema]);
      var realm = Realm(config);

      var category = CategoryRealmEntity(
        ObjectId(),
        categoryName,
        iconCodePoint: _iconSelected?.data.codePoint,
        categoryBackgroundColor,
        iconAndTextColorHex,
      );
      await realm.writeAsync(() {
        realm.add(category);
      });
      _initDataValue();
      setState(() {}); // viết như này nghĩa là  báo cho Flutter rằng dữ liệu của màn hình này vừa đổi, nên cần vẽ lại widget.
      // show thông báo cho user biết
      _showAlert("notification".tr(), "category.create_success".tr());
    } catch (error) {
      print(error);
      _showAlert("notification".tr(), "category.create_failed".tr());
    }
  }

  void _initDataValue() {
    _nameCategoryController.text = "";
    _iconSelected = null;
    iconAndTextColor = Colors.white;
    backgroundCategoryColor = Colors.white.withValues(alpha: 0.20);
  }

  void _chooseIcon() async {
    IconPickerIcon? icon = await showIconPicker(
      context,
      configuration: SinglePickerConfiguration(
        iconPackModes: [IconPack.material],
      ),
    );
    setState(() {
      _iconSelected = icon;
    });
  }

  void _onChooseCategoryBackgroundColor() async {
    showDialog(
      context: context,
      builder: (context) {
        //  cách hiển thị list màu 1
        return AlertDialog(
          content: SingleChildScrollView(
            child: MaterialPicker(
              pickerColor: backgroundCategoryColor,
              onColorChanged: (Color newColor) {
                setState(() {
                  backgroundCategoryColor = newColor;
                });
                Navigator.pop(context);
              },
            ),
          ),
        );
      },
    );
  }

  void _onChooseIconAndTextCategoryColor() {
    showDialog(
      context: context,
      builder: (context) {
        //  cách hiển thị list màu 2
        return AlertDialog(
          content: Listener(
            onPointerUp: (_) {
              Navigator.pop(context);
            },
            child: SingleChildScrollView(
              child: ColorPicker(
                pickerColor: iconAndTextColor,
                onColorChanged: (Color newColor) {
                  setState(() {
                    iconAndTextColor = newColor;
                  });
                },
              ),
            ),
          ),
        );
      },
    );
  }

  Future<void> _showAlert(String title, String message) async {
    await showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(title),
          content: Text(message),
          // actionsAlignment: MainAxisAlignment.center,
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text("ok".tr()),
            ),
          ],
        );
      },
    );
  }

  void _findCategoryByIdRealm(String id) async {
    var config = Configuration.local([
      CategoryRealmEntity.schema,
    ]); // cấu hình realm
    var realm = Realm(config); // mở realm

    final category = realm.find<CategoryRealmEntity>(
      ObjectId.fromHexString(id),
    );
    if (category == null) {
      return;
    }

    // gán giá trị cho các trường

    _nameCategoryController.text = category.name;
    _iconSelected = IconPickerIcon(
      data: IconData(category.iconCodePoint!, fontFamily: 'MaterialIcons'),
      name: '',
      pack: '',
    );
    backgroundCategoryColor =
        colorFromHex(category.backgroundColorHex) ?? backgroundCategoryColor;
    iconAndTextColor = colorFromHex(category.iconColorHex) ?? iconAndTextColor;
    setState(() {});
  }

  void _handleEditCategory() async {
    try {
      final categoryName = _nameCategoryController.text;
      final categoryBackgroundColor =
          '#${backgroundCategoryColor.toHexString()}';
      final iconAndTextColorHex = '#${iconAndTextColor.toHexString()}';

      if (categoryName.isEmpty) {
        _showAlert("notification".tr(), "category.name_required".tr());
        return;
      }
      if (_iconSelected?.data == null) {
        _showAlert("notification".tr(), "category.icon_required".tr());
        return;
      }

      var config = Configuration.local([CategoryRealmEntity.schema]);
      var realm = Realm(config);

      final category = realm.find<CategoryRealmEntity>(
        ObjectId.fromHexString(widget.categoryId!),
      );
      if (category == null) {
        return;
      }
      await realm.writeAsync(() {
        // ghi dữ liệu vào realm
        category.name = categoryName;
        category.iconCodePoint = _iconSelected?.data.codePoint;
        category.backgroundColorHex = categoryBackgroundColor;
        category.iconColorHex = iconAndTextColorHex;
      });
      _initDataValue();
      setState(() {});
      // show thông báo cho user biết
      await _showAlert("notification".tr(), "category.update_success".tr());
      if (context.mounted) {
        Navigator.pop(context);
      }
    } catch (error) {
      print(error);
      _showAlert("notification".tr(), "category.update_failed".tr());
    }
  }
}
