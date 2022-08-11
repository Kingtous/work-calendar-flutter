import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mpcore/mpcore.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:work_calendar/component/button.dart';

import 'controller/calendar_controller.dart';

class WorkSelectionPage extends StatelessWidget {
  const WorkSelectionPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final c = Get.find<CalendarController>();
    return MPScaffold(
      name: "工作日历配置",
      body: Column(
        children: [
          MPPicker(
            column: 1,
            items: WorkType.values.map((e) => MPPickerItem(label: e.desc())).toList(growable: false),
            child: Row(
              children: [
                Expanded(child: KButton(text: "轮班机制",icon:  MPIcon(MaterialIcons.home_filled
                ), action: Obx(() => Text(c.workType.value.desc())),))
              ],
            ).marginOnly(bottom: 4.0),
            onResult: (items) {
              if (items.first.label == WorkType.w1.desc()) {
                c.setWorkType(WorkType.w1);
              } else if (items.first.label == WorkType.w2.desc()) {
                c.setWorkType(WorkType.w2);
              } else if (items.first.label == WorkType.w3.desc()) {
                c.setWorkType(WorkType.w3);
              }
            },
          ),
          Row(
            children: [
              Expanded(child: MPDatePicker(
                headerText: "任意选择一个周期的第一天",
                defaultValue: DateTime.now(),
                onResult: (dt) {
                  c.setWorkTime(dt);
                },
                child: KButton(text: "选择上班的一天",icon:  MPIcon(MaterialIcons.work
                ), action: Obx(() => Text("${c.initialWorkTime.value.year}年"
                    "${c.initialWorkTime.value.month}月"
                    "${c.initialWorkTime.value.day}日")),),
              ))
            ],
          ),
        ],
      ).marginSymmetric(horizontal: 8.0),
    );
  }

}
