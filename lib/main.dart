import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:mpcore/mpcore.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:work_calendar/component/calendar.dart';
import 'package:work_calendar/controller/calendar_controller.dart';
import 'package:work_calendar/me.dart';
import 'package:work_calendar/work_selection_page.dart';

void main() {
  runApp(MyApp());
  MPCore().connectToHostChannel();
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMPApp(
      title: '工作日历',
      color: Colors.blue,
      routes: {
        '/': (context) => MyHomePage(),
        '/work_selection': (context) => WorkSelectionPage(),
      },
      navigatorObservers: [MPCore.getNavigationObserver()],
    );
  }
}

class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: initTools(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return MPMainTabView(
            loadingBuilder: (context) => MPCircularProgressIndicator(),
            keepAlive: true,
            tabs: [
              MPMainTabItem(
                  activeTabWidget: Container(
                      width: 44,
                      height: 44,
                      child: renderIcon(
                        icon: MaterialIcons.calendar_today,
                        title: '日历',
                        actived: true,
                      )),
                  inactiveTabWidget: Container( width: 44,
                      height: 44,child: renderIcon(
                        icon: MaterialIcons.calendar_today,
                        title: '日历',
                        actived: false,
                      )),
                  builder: (context) => Calendar()),
              MPMainTabItem(
                  activeTabWidget: Container( width: 44,
                      height: 44,child: renderIcon(
                        icon: MaterialIcons.home,
                        title: '我的',
                        actived: true,
                      )),
                  inactiveTabWidget: Container( width: 44,
                      height: 44,child: renderIcon(
                        icon: MaterialIcons.home,
                        title: '我的',
                        actived: false,
                      )),
                  builder: (context) => MePage())
            ],
          );
        } else {
          return Center(child: MPCircularProgressIndicator());
        }
      },
    );
  }

  Widget renderIcon({
    required String icon,
    required String title,
    required bool actived,
  }) {
    return Column(
      children: [
        MPIcon(icon, color: actived ? Colors.black : Colors.grey),
        Text(
          title,
          style: TextStyle(
            fontSize: 12,
            color: actived ? Colors.black : Colors.grey,
          ),
        ),
      ],
    );
  }
}
