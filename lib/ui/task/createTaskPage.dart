import 'package:easy_localization/easy_localization.dart';
import 'package:fluter_app/entities/category_realm_entity.dart';
import 'package:fluter_app/models/categoryModel.dart';
import 'package:fluter_app/ui/category/CategoryListPage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:realm/realm.dart';

class CreateTaskPage extends StatefulWidget {
  const CreateTaskPage({super.key});

  @override
  State<CreateTaskPage> createState() => _CreateTaskPageState();
}

class _CreateTaskPageState extends State<CreateTaskPage> {
  final _taskController = TextEditingController();
  final _descriptionController = TextEditingController();
  CategoryModel? _categorySelected;
  DateTime? _taskDateTimeSelected;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      color: Color(0xFF363636),
      padding: EdgeInsets.all(25),
      child: Form(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            taskInput(_taskController, "task.task_hint".tr()),
            descriptionField(),
            if (_taskDateTimeSelected != null)
              _buildTaskDateCategory(_taskDateTimeSelected!),

            if (_categorySelected != null)
              _buildTaskCategory(_categorySelected!),
            iconList(),
          ],
        ),
      ),
    );
  }

  Widget taskInput(TextEditingController controllerName, String hintText) {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _titleField("task.add_task".tr()),
          Container(
            margin: EdgeInsets.only(top: 10),
            child: TextFormField(
              controller: controllerName,
              style: TextStyle(color: Colors.white, fontSize: 16, height: 1.2),
              onChanged: (String? value) {
                setState(() {});
              },
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(4),
                  borderSide: BorderSide(width: 1, color: Color(0xF979797)),
                ),
                hintText: hintText,
                hintStyle: TextStyle(
                  color: Color(0xFFAFAFAF),
                  fontSize: 16,
                  height: 1.2,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget descriptionField() {
    return Container(
      margin: EdgeInsets.only(top: 13),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _titleField("task.description".tr()),
          Container(
            margin: EdgeInsets.only(top: 10),
            child: TextFormField(
              controller: _descriptionController,
              style: TextStyle(color: Colors.white, fontSize: 16, height: 1.2),
              onChanged: (String? value) {
                setState(() {});
              },
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(4),
                  borderSide: BorderSide(width: 1, color: Color(0xF979797)),
                ),
                hintText: "task.description".tr(),
                hintStyle: TextStyle(
                  color: Color(0xFFAFAFAF),
                  fontSize: 16,
                  height: 1.2,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _titleField(String title) {
    return Text(
      title,
      style: TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.w700,
        color: Colors.white,
      ),
    );
  }

  Widget iconList() {
    return Container(
      margin: EdgeInsets.only(top: 35),
      child: Row(
        children: [
          Expanded(
            child: Row(
              spacing: 32,
              children: [
                IconButton(
                  onPressed: () {
                    _selectTaskTime();
                  },
                  icon: Image.asset("assets/images/timer.png"),
                ),
                IconButton(
                  onPressed: () {
                    _showDialogChooseCategory();
                  },
                  icon: Image.asset("assets/images/tag.png"),
                ),
                IconButton(
                  onPressed: () {},
                  icon: Image.asset("assets/images/flag.png"),
                ),
              ],
            ),
          ),
          IconButton(
            onPressed: () {},
            icon: Image.asset("assets/images/send.png"),
          ),
        ],
      ),
    );
  }

  Widget _buildTaskCategory(CategoryModel category) {
    return Container(
      margin: EdgeInsets.only(top: 10),
      child: Column(
        spacing: 16,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "category.preview_category".tr(),
            style: TextStyle(
              color: Color(0xFFAFAFAF),
              fontWeight: FontWeight.w400,
              fontSize: 18,
            ),
          ),
          Column(
            spacing: 16,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                height: 64,
                width: 64,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(6),
                  color: colorFromHex(category.backgroundColorHex),
                ),

                child: Icon(
                  IconData(
                    category.iconCodePoint!,
                    fontFamily: 'MaterialIcons',
                  ),
                  color: colorFromHex(category.iconColorHex),
                  size: 32,
                ),
              ),
              Text(
                category.name,
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.white, fontSize: 14),
              ),
            ],
          ),
        ],
      ),
    );
  }

  void _showDialogChooseCategory() async {
    final result = await showGeneralDialog<CategoryModel>(
      context: context,
      barrierLabel: "chọn category", // chỉ là lable user không thấy đucợ

      barrierDismissible: true, // click ra ngoài để tắt
      barrierColor: Colors.black.withValues(alpha: 0.5), // màu overlay
      pageBuilder: (_, __, ___) {
        return CategoryListPage();
      },
    );

    if (!mounted) return;
    if (result != null) {
      setState(() {
        _categorySelected = result;
      });
      return;
    }

    final selectedId = _categorySelected?.id;
    if (selectedId == null) return;
    final updatedCategory = _findCategoryById(selectedId);
    setState(() {
      _categorySelected = updatedCategory ?? _categorySelected;
    });
  }

  CategoryModel? _findCategoryById(String id) {
    final config = Configuration.local([CategoryRealmEntity.schema]);
    final realm = Realm(config);
    final category = realm.find<CategoryRealmEntity>(
      ObjectId.fromHexString(id),
    );
    if (category == null) return null;
    return CategoryModel(
      id: category.id.hexString,
      name: category.name,
      iconCodePoint: category.iconCodePoint,
      backgroundColorHex: category.backgroundColorHex,
      iconColorHex: category.iconColorHex,
    );
  }

  void _selectTaskTime() async {
    final date = await showDatePicker(
      context: context,
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(Duration(days: 365)),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: const ColorScheme.dark(
              primary: Color(0xFF8687E7),
              onSurface: Colors.white,
            ),
          ),
          child: child!,
        );
      },
    );
    if (date == null) return;
    if (!context.mounted) return;

    final time = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: const ColorScheme.dark(
              primary: Color(0xFF8687E7),
              onSurface: Colors.white,
            ),
          ),
          child: child!,
        );
      },
    );
    if (time == null) return;
    final dateTimeSelected = date.copyWith(
      hour: time.hour,
      minute: time.minute,
      second: 0,
    );

    _taskDateTimeSelected = dateTimeSelected;
    setState(() {});
  }

  Widget _buildTaskDateCategory(DateTime dateTimeSelected) {
    return Container(
      margin: EdgeInsets.only(top: 10),
      child: Row(
        spacing: 16,
        children: [
          Text(
            "task.taskTime".tr(),
            style: TextStyle(
              color: Color(0xFFAFAFAF),
              fontWeight: FontWeight.w400,
              fontSize: 18,
            ),
          ),
          Text(
            DateFormat('dd/MM/yyyy HH:mm').format(dateTimeSelected),
            style: TextStyle(
              color: Color(0xFFAFAFAF),
              fontWeight: FontWeight.w400,
              fontSize: 18,
            ),
          ),
        ],
      ),
    );
  }
}
