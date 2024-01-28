import 'package:bruno/bruno.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:work_calendar/component/button.dart';

import 'controller/calendar_controller.dart';

class WorkSelectionPage extends StatelessWidget {
  const WorkSelectionPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final c = Get.find<CalendarController>();
    return Scaffold(
      appBar: BrnAppBar(
        title: "工作日历配置",
      ),
      backgroundColor: Colors.white,
      // name: "工作日历配置",
      body: Column(
        children: [
          GestureDetector(
            // column: 1,
            // items: WorkType.values
            //     .map((e) => MPPickerItem(label: e.desc()))
            //     .toList(growable: false),
            onTap: () {
              showDialog(
                  context: context,
                  builder: (context) => BrnSingleSelectDialog(
                      title: '轮班机制',
                      conditions: WorkType.values.map((e) => e.desc()).toList(),
                      onSubmitClick: (v) {
                        final item = v;
                        if (item == WorkType.w1.desc()) {
                          c.setWorkType(WorkType.w1);
                        } else if (item == WorkType.w2.desc()) {
                          c.setWorkType(WorkType.w2);
                        } else if (item == WorkType.w3.desc()) {
                          c.setWorkType(WorkType.w3);
                        }
                      }));
            },
            child: Row(
              children: [
                Expanded(
                    child: KButton(
                  text: "轮班机制",
                  icon: Icon(Icons.home_filled),
                  action: Obx(() => Text(c.workType.value.desc())),
                ))
              ],
            ).marginOnly(bottom: 4.0),
            // onResult: (items) {
            //   if (items.first.label == WorkType.w1.desc()) {
            //     c.setWorkType(WorkType.w1);
            //   } else if (items.first.label == WorkType.w2.desc()) {
            //     c.setWorkType(WorkType.w2);
            //   } else if (items.first.label == WorkType.w3.desc()) {
            //     c.setWorkType(WorkType.w3);
            //   }
            // },
          ),
          Row(
            children: [
              Expanded(
                  child: GestureDetector(
                // headerText: "任意选择一个周期的第一天",
                // defaultValue: DateTime.now(),
                // onResult: (dt) {
                //   c.setWorkTime(dt);
                // },
                onTap: () {
                  BrnDatePicker.showDatePicker(context,
                      initialDateTime: DateTime.now(),
                      pickerMode: BrnDateTimePickerMode.date,
                      onConfirm: (dt, list) {
                    c.setWorkTime(dt);
                  });
                },
                child: KButton(
                  text: "选择上班的一天",
                  icon: Icon(Icons.work),
                  action: Obx(() => Text("${c.initialWorkTime.value.year}年"
                      "${c.initialWorkTime.value.month}月"
                      "${c.initialWorkTime.value.day}日")),
                ),
              ))
            ],
          ),
        ],
      ).marginSymmetric(horizontal: 8.0),
    );
  }
}
