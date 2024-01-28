import 'package:bruno/bruno.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:mpflutter_wechat_api/mpflutter_wechat_api.dart' hide SafeArea;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:work_calendar/component/calendar.dart';
import 'package:work_calendar/main.dart';
import 'package:work_calendar/me.dart';
import 'package:work_calendar/utils/safe_area.dart';

class MyHomePage extends StatefulWidget {
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    BrnLocalizationDelegate.delegate.load(const Locale('zh', 'CN'));
    Future.delayed(Duration.zero, () {
      checkWorker();
    });
  }

  void checkWorker() async {
    final sp = Get.find<SharedPreferences>();
    if (sp.getInt("initialWorkTime") == null) {
      wx.showModal(ShowModalOption()
        ..title = "提示"
        ..content = "还未配置工作日历哦，请前往\"我的\"页面配置");
      // Future.delayed(Duration.zero, () {
      //   // 跳转至登录
      //   Get.toNamed('/work_selection');
      // });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: safeHeight()),
      child: Scaffold(
        appBar: BrnAppBar(
          leading: Offstage(),
          title: '轮班工作日历',
        ),
        body: FutureBuilder(
          future: f,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return Column(
                children: [
                  Expanded(
                    child: TabBarView(
                      controller: _tabController,
                      // loadingBuilder: (context) => Column(
                      //   mainAxisAlignment: MainAxisAlignment.center,
                      //   children: [
                      //     BrnLoadingDialog(),
                      //     Text("快马加鞭加载中..."),
                      //   ],
                      // ),
                      // keepAlive: true,
                      children: [
                        Calendar(),
                        MePage(),
                        // MPMainTabItem(
                        //     activeTabWidget: Container(
                        //         width: 44,
                        //         height: 44,
                        //         child: renderIcon(
                        //           icon: Icons.calendar_today,
                        //           title: '日历',
                        //           actived: true,
                        //         )),
                        //     inactiveTabWidget: Container(
                        //         width: 44,
                        //         height: 44,
                        //         child: renderIcon(
                        //           icon: Icons.calendar_today,
                        //           title: '日历',
                        //           actived: false,
                        //         )),
                        //     builder: (context) => Calendar()),
                        // MPMainTabItem(
                        //     activeTabWidget: Container(
                        //         width: 44,
                        //         height: 44,
                        //         child: renderIcon(
                        //           icon: Icons.home,
                        //           title: '我的',
                        //           actived: true,
                        //         )),
                        //     inactiveTabWidget: Container(
                        //         width: 44,
                        //         height: 44,
                        //         child: renderIcon(
                        //           icon: Icons.home,
                        //           title: '我的',
                        //           actived: false,
                        //         )),
                        //     builder: (context) => MePage())
                      ],
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              _tabController.animateTo(0);
                            });
                          },
                          child: Container(
                              width: 44,
                              height: 44,
                              child: renderIcon(
                                icon: Icons.calendar_today,
                                title: '日历',
                                actived: _tabController.index == 0,
                              )),
                        ),
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              _tabController.animateTo(1);
                            });
                          },
                          child: Container(
                              width: 44,
                              height: 44,
                              child: renderIcon(
                                icon: Icons.home,
                                title: '我的',
                                actived: _tabController.index == 1,
                              )),
                        )
                      ],
                    ),
                  )
                ],
              );
            } else {
              return Center(child: BrnLoadingDialog());
            }
          },
        ),
      ),
    );
  }

  Widget renderIcon({
    required IconData icon,
    required String title,
    required bool actived,
  }) {
    return Column(
      children: [
        Icon(icon, color: actived ? Colors.black : Colors.grey),
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
