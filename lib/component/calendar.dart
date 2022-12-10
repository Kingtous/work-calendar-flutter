import 'package:common_utils/common_utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lunar/lunar.dart';
import 'package:mpcore/mpcore.dart';
import 'package:work_calendar/controller/calendar_controller.dart';

class Calendar extends StatelessWidget {
  const Calendar({Key? key}) : super(key: key);

  CalendarController get controller => Get.find<CalendarController>();

  _switchToNextMonth() {
    final dt = controller.selectedDate.value;
    final newDate;
    if (dt.month == 12) {
      newDate = DateTime(dt.year + 1, 1, 1);
    } else {
      newDate = DateTime(dt.year, dt.month + 1, 1);
    }
    changeDate(newDate);
  }

  _swithToPreviousMonth() {
    final dt = controller.selectedDate.value;
    final newDate;
    if (dt.month == 1) {
      newDate = DateTime(dt.year - 1, 12, 1);
    } else {
      newDate = DateTime(dt.year, dt.month - 1, 1);
    }
    changeDate(newDate);
  }

  @override
  Widget build(BuildContext context) {
    return MPScaffold(
      backgroundColor: Colors.white,
      name: "工作日历",
      body: SingleChildScrollView(
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: Obx(() => Text(
                        "${controller.selectedDate.value.year}年${controller.selectedDate.value.month}月${controller.selectedDate.value.day}月",
                        style: TextStyle(
                            fontSize: 14, fontWeight: FontWeight.bold),
                      )),
                ),
                MPDatePicker(
                    headerText: "请输入要查询的日期",
                    start: DateTime(2000, 01, 01),
                    end: DateTime(2099, 01, 01),
                    defaultValue: DateTime.now(),
                    onResult: (dt) {
                      changeDate(dt);
                    },
                    child: Container(
                      decoration: BoxDecoration(border: Border.all()),
                      padding: EdgeInsets.symmetric(horizontal: 8.0),
                      child: Text(
                        "选择日期",
                        style: TextStyle(fontSize: 16, color: Colors.black),
                      ),
                    )).marginSymmetric(horizontal: 8.0, vertical: 4.0),
              ],
            ),
            Column(
              children: [
                loadWorkOrder(),
                buildCalendar(),
                buildPanel(),
                buildTipsToday(),
                // tabbar
                const SizedBox(
                  height: 75,
                )
              ],
            )
          ],
        ).marginSymmetric(horizontal: 8.0),
      ),
    );
  }

  void changeDate(DateTime dt) {
    controller.selectedDate.value = dt;
  }

  Widget loadWorkOrder() {
    return Row(
      children: [
        Obx(() => Text(
              "${controller.getWorkStatusToday(controller.selectedDate.value)}",
              style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 24),
            ))
      ],
    );
  }

  buildTipsToday() {
    return Column(
      children: [
        Row(
          children: [
            Text(
              "今日为何日",
              style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 20),
            )
          ],
        ),
        Row(
          children: [
            Expanded(
                child: Obx(() => Text(
                      "${Lunar.fromDate(controller.selectedDate.value).toFullString().replaceAll(" ", "\n")}",
                      softWrap: true,
                      style: TextStyle(
                          color: Colors.grey,
                          fontSize: 14,
                          height: 1.5,
                          wordSpacing: 1.5,
                          letterSpacing: 1.5),
                    )))
          ],
        ).paddingSymmetric(vertical: 4.0),
      ],
    );
  }

  Widget buildCalendar() {
    return Container(
      decoration: BoxDecoration(border: Border.all()),
      child: Obx(() => GridView.count(
            crossAxisCount: 7,
            shrinkWrap: true,
            children: buildItems(controller.selectedDate.value),
          )),
    );
  }

  buildItem(
    String text, {
    bool active = false,
    Function()? onTap,
  }) {
    return GestureDetector(
      key: ValueKey(text),
      onTap: onTap,
      child: Container(
          alignment: Alignment.center,
          decoration: BoxDecoration(
              // shape: BoxShape.circle,
              color: active ? Colors.grey : Colors.white,
              borderRadius: BorderRadius.circular(50)),
          child: Text(
            text,
            textAlign: TextAlign.center,
          )),
    );
  }

  List<Widget> buildItems(DateTime dt) {
    List<Widget> list = [
      buildItem("日"),
      buildItem("一"),
      buildItem("二"),
      buildItem("三"),
      buildItem("四"),
      buildItem("五"),
      buildItem("六"),
    ];
    // judge first date
    final firstDayOfMonth = DateTime(dt.year, dt.month, 1);
    bool isLeapYear = DateUtil.isLeapYearByYear(dt.year);
    var d = firstDayOfMonth.weekday;
    while (d > 0) {
      list.add(Offstage());
      d -= 1;
    }
    var day = 31;
    if ([1, 3, 5, 7, 8, 10, 12].contains(dt.month)) {
      day = 31;
    } else {
      if (dt.month == 2) {
        day = isLeapYear ? 29 : 28;
      } else
        day = 30;
    }
    for (var i = 1; i <= day; i++) {
      final iDt = DateTime(dt.year, dt.month, i);
      final lunar = Lunar.fromDate(iDt);
      list.add(Obx(() => buildItem("$i\n${lunar.getDayInChinese()}",
              active: controller.selectedDate.value.day == i, onTap: () {
            controller.selectedDate.value = iDt;
          })));
    }

    return list;
  }

  Widget buildPanel() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        GestureDetector(
          onTap: _swithToPreviousMonth,
          child: Container(
            decoration: BoxDecoration(border: Border.all()),
            padding: EdgeInsets.symmetric(horizontal: 8.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                MPIcon(MaterialIcons.arrow_left_outlined),
                Text(
                  "上个月",
                  style: TextStyle(fontSize: 16, color: Colors.black87),
                ),
              ],
            ),
          ),
        ),
        GestureDetector(
          onTap: () {
            changeDate(DateTime.now());
          },
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 8.0),
            color: Colors.black87,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  "回到今天",
                  style: TextStyle(fontSize: 16, color: Colors.white),
                ),
              ],
            ),
          ),
        ),
        GestureDetector(
          onTap: _switchToNextMonth,
          child: Container(
            decoration: BoxDecoration(border: Border.all()),
            padding: EdgeInsets.symmetric(horizontal: 8.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  "下个月",
                  style: TextStyle(fontSize: 16, color: Colors.black87),
                ),
                MPIcon(MaterialIcons.arrow_right_outlined),
              ],
            ),
          ),
        ),
      ],
    ).marginSymmetric(vertical: 8.0);
  }
}
