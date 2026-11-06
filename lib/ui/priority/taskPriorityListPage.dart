import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class TaskPriorityListPage extends StatefulWidget {
  const TaskPriorityListPage({super.key});

  @override
  State<TaskPriorityListPage> createState() => _TaskPriorityListPageState();
}

class _TaskPriorityListPageState extends State<TaskPriorityListPage> {
  List<int> taskPriorityListDataSource = [];

  int? _selectedPriority = 1;
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      taskPriorityListDataSource = List.generate(10, (index) => index + 1);
      setState(() {});
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

        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _buildChoosePriorityTitle(),
            _buildGridPriorityList(),
            _buildCreatePriorityButton(),
          ],
        ),
      ),
    );
  }

  Widget _buildChoosePriorityTitle() {
    return Column(
      spacing: 10,
      children: [
        Text(
          "task.task_priority".tr(),
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

  Widget _buildGridPriorityList() {
    return GridView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        childAspectRatio: 1,
      ),
      itemBuilder: (context, index) {
        final priority = taskPriorityListDataSource[index];
        return _buildGridPriorityItem(priority);
      },
      itemCount: taskPriorityListDataSource.length,
    );
  }

  Widget _buildGridPriorityItem(int priority) {
    final isSelected = _selectedPriority == priority;
    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedPriority = priority;
        });
      },
      child: Container(
        margin: EdgeInsets.all(5),
        child: Container(
          height: 64,
          width: 64,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(6),
            color: isSelected ? Color(0xFF8687E7) : Color(0xFF272727),
          ),

          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            spacing: 5,
            children: [
              Image.asset(
                "assets/images/flag.png",
                width: 24,
                height: 24,
                fit: BoxFit.fill,
              ),
              Text(
                priority.toString(),
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.white,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCreatePriorityButton() {
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
                Navigator.pop(context, {"priority": _selectedPriority});
              },

              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xFF8687E7),
                padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                shape: BeveledRectangleBorder(
                  borderRadius: BorderRadius.circular(4),
                ),
              ),
              child: Text(
                "save".tr(),
                style: TextStyle(color: Colors.white, fontSize: 16),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
