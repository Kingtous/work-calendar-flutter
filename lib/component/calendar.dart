import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:get/instance_manager.dart';
import 'package:mpcore/mpcore.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:work_calendar/controller/calendar_controller.dart';

class Calendar extends StatefulWidget {
  const Calendar({Key? key}) : super(key: key);

  @override
  State<Calendar> createState() => _CalendarState();
}

class _CalendarState extends State<Calendar> {

  late CalendarController controller;

  @override
  Widget build(BuildContext context) {
    return MPScaffold(
       appBar: MPAppBar(
          context: context,
          title: Text(
            "工作日历",
            style: TextStyle(fontWeight: FontWeight.w600),
          ),
        ),
      body: Column(
        children: [
          Row(
            children: [
              Obx(()=> Text("${controller.selectedDate.value.year}年${controller.selectedDate.value.month}月")),
              MPDatePicker(
                  headerText: "请输入要查询的日期",
                  start: DateTime(2000,01,01),
                  end: DateTime(2099,01,01),
                  defaultValue: DateTime.now(),
                  onResult: (dt) {
                    changeDate(dt);
                  },
                  child: Container(
                    color: Colors.blueAccent,
                    padding: EdgeInsets.symmetric(horizontal: 8.0),
                    child: Text("选择日期", style: TextStyle(
                      color: Colors.white
                    ),),
                  )).marginOnly(left: 8.0),
            ],
          ),
        ],
      ).marginSymmetric(horizontal: 8.0),
    );
  }

  @override
  void initState() {
    super.initState();
    controller = Get.find<CalendarController>();
    SharedPreferences.getInstance().then((sp) {
      Get.lazyPut(() => sp);
      checkWorker();
    });
  }

  void checkWorker() async {
    final sp = Get.find<SharedPreferences>();
    if (sp.getString("work_date") == null) {
      await MPWebDialogs.alert(message: "还未配置工作日历哦，请前往配置");
      // Future.delayed(Duration.zero, () {
      //   // 跳转至登录
      //   Get.toNamed('/work_selection');
      // });
    } else {
      loadWorkOrder();
    }
  }

  void changeDate(DateTime dt) {
    controller.selectedDate.value = dt;
  }

  void loadWorkOrder() {}
}
