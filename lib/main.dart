import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:mpcore/mpcore.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:work_calendar/component/calendar.dart';
import 'package:work_calendar/controller/calendar_controller.dart';
import 'package:work_calendar/me.dart';
import 'package:work_calendar/work_selection_page.dart';

late Future<String?> f;
bool notified = false;

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  f = initTools();
  runApp(MyApp());
  MPCore().connectToHostChannel();
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMPApp(
      title: '工作日历',
      color: Colors.black,
      routes: {
        '/': (context) => MyHomePage(),
        '/work_selection': (context) => WorkSelectionPage(),
      },
      navigatorObservers: [MPCore.getNavigationObserver()],
      initialRoute: "/",
      unknownRoute: GetPage(name: '/fallback', page: () =>MyHomePage()),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {

  void checkWorker() async {
    if (notified) {
      return;
    }
    notified = true;
    final sp = Get.find<SharedPreferences>();
    if (sp.getString("initialWorkTime") == null) {
      await MPWebDialogs.alert(message: "还未配置工作日历哦，请前往\"我的\"页面配置");
      // Future.delayed(Duration.zero, () {
      //   // 跳转至登录
      //   Get.toNamed('/work_selection');
      // });
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: f,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          Future.delayed(Duration.zero, () {
            checkWorker();
          });
          return MPMainTabView(
            loadingBuilder: (context) => Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                MPCircularProgressIndicator(),
                Text("快马加鞭加载中..."),
              ],
            ),
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
