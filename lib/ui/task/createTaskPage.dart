import 'package:fluter_app/ui/category/CategoryListPage.dart';
import 'package:flutter/material.dart';

class CreateTaskPage extends StatefulWidget {
  const CreateTaskPage({super.key});

  @override
  State<CreateTaskPage> createState() => _CreateTaskPageState();
}

class _CreateTaskPageState extends State<CreateTaskPage> {
  final _taskController = TextEditingController();
  final _descriptionController = TextEditingController();
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
            taskInput(_taskController, "Do math homework"),
            descriptionField(),
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
          _titleField("Add Task"),
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
          _titleField("Description"),
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
                hintText: "Description",
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
                  onPressed: () {},
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

  void _showDialogChooseCategory() {
    showGeneralDialog(
      context: context,
      pageBuilder: (_, __, ___) {
        return CategoryListPage();
      },
    );
  }
}
