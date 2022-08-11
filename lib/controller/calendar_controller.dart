import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

enum WorkType {
  w1,
  w2,
  w3
}

extension WorkTypeString on WorkType {
  String desc() {
    switch (this) {
      case WorkType.w1:
        return "方式1(全天、休、休、休)";
      case WorkType.w2:
        return "方式2(白、晚、休、休)";
      case WorkType.w3:
        return "方式3(全天、休、休)";
      default:
        return "未知";
    }
  }
}

class CalendarController extends GetxController {
  var selectedDate = DateTime.now().obs;

  var workType = WorkType.w1.obs;

  var initialWorkTime = DateTime.now().obs;

  CalendarController init() {
    final wType = Get.find<SharedPreferences>().getString("workType") ?? "w1";
    if (wType == WorkType.w1.name) {
      workType.value = WorkType.w1;
    } else if (wType == WorkType.w2.name) {
      workType.value = WorkType.w2;
    } else if (wType == WorkType.w3.name) {
      workType.value = WorkType.w3;
    }
    final t = Get.find<SharedPreferences>().getInt("initialWorkTime");
    if (t == null) {
      initialWorkTime.value = DateTime(2000, 1, 1);
    } else {
      initialWorkTime.value = DateTime.fromMillisecondsSinceEpoch(t);
    }
    return this;
  }

  setWorkType(WorkType value) {
    workType.value = value;
    Get.find<SharedPreferences>().setString("workType", value.name);
  }

  void setWorkTime(DateTime dt) {
    initialWorkTime.value = dt;
    Get.find<SharedPreferences>().setInt("initialWorkTime", dt.millisecondsSinceEpoch);
  }

  String getWorkStatusToday(DateTime value) {
    var d = value.difference(initialWorkTime.value).inDays;
    if (d < 0) {
      d = -d;
    }
    switch (workType.value) {
      case WorkType.w1:
        d = d %= 4;
        if (d == 0) {
          return "今天全天上班哦～";
        } else {
          return "休息！";
        }
      case WorkType.w2:
        d = d %= 4;
        if (d == 0) {
          return "白班";
        } else if (d == 1) {
          return "晚班";
        }
        else {
          return "休息！";
        }
      case WorkType.w3:
        d = d %= 3;
        if (d == 0) {
          return "今天全天上班哦～";
        } else {
          return "休息！";
        }
    }
    return "白班";
  }

}

SharedPreferences? _sp;

Future<String?> initTools() async {
  print("loading tools");
  if (_sp != null) {
    return "ok";
  }
  _sp = await SharedPreferences.getInstance();
  Get.lazyPut<SharedPreferences>(() => _sp!);
  Get.lazyPut<CalendarController>(() => CalendarController().init());
  print("calendarController done");
  return "ok";
}