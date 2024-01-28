import 'package:bruno/bruno.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:work_calendar/component/button.dart';
import 'package:work_calendar/utils/safe_area.dart';

class MePage extends StatelessWidget {
  const MePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: safeHeight()),
      child: Scaffold(
        backgroundColor: Colors.white,
        // appBar: BrnAppBar(),
        // name: "我的",
        body: Column(
          children: [
            Expanded(
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Row(
                    //   crossAxisAlignment: CrossAxisAlignment.end,
                    //   children: [
                    //     Text("轮班工作日历", style: TextStyle(
                    //       fontSize: 30,
                    //       fontWeight: FontWeight.bold,
                    //     )),
                    //   ],
                    // ),
                    // Divider(),
                    Expanded(child: buildMenu(context)),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Column(
                          children: [
                            Text(
                              '浪韬沙网络科技工作室™ ${DateTime.now().year}',
                              style:
                                  TextStyle(color: Colors.grey, fontSize: 12.0),
                            ),
                            Text(
                              '由MPFlutter 2.0强力驱动',
                              style:
                                  TextStyle(color: Colors.grey, fontSize: 10.0),
                            ),
                          ],
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 8.0,
                    ),
                  ]).marginSymmetric(horizontal: 8.0, vertical: 4.0),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildMenu(BuildContext context) {
    return SingleChildScrollView(
      child: Column(children: [
        // MP
        // GestureDetector(
        //   onTap: () {
        //     Navigator.pushNamed(context, '/work_selection');
        //   },
        //   child: AspectRatio(
        //     aspectRatio: 3,
        //     child: Container(
        //       width: double.infinity,
        //       decoration: BoxDecoration(
        //           borderRadius: BorderRadius.circular(12.0),
        //           gradient: LinearGradient(colors: [
        //             Colors.black,
        //             Colors.black.withAlpha(200),
        //             Colors.black.withAlpha(100),
        //           ])),
        //       child: Padding(
        //         padding: const EdgeInsets.all(8.0),
        //         child: Row(
        //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //           crossAxisAlignment: CrossAxisAlignment.center,
        //           children: [
        //             Padding(
        //               padding: const EdgeInsets.symmetric(horizontal: 8.0),
        //               child: Text(
        //                 '轮班设置',
        //                 style: TextStyle(
        //                     color: Colors.white,
        //                     fontWeight: FontWeight.bold,
        //                     fontSize: 40.0),
        //               ),
        //             ),
        //             Column(
        //               mainAxisAlignment: MainAxisAlignment.end,
        //               children: [
        //                 Icon(
        //                   Icons.settings,
        //                   color: Colors.white.withAlpha(200),
        //                   size: 40,
        //                 ),
        //               ],
        //             )
        //           ],
        //         ),
        //       ),
        //     ),
        //   ),
        // ),
        KButton(
          text: "轮班设置",
          icon: Icon(Icons.settings),
          onTap: () {
            Navigator.pushNamed(context, '/work_selection');
          },
        ),
        SizedBox(
          height: 8.0,
        ),
        KButton(
          text: "关于小程序",
          icon: Icon(Icons.align_vertical_bottom_rounded),
          onTap: () {
            showDialog(
                context: context,
                builder: (context) => BrnDialog(
                      titleText: '关于作者',
                      messageText: '浪韬沙网络科技工作室\n备案号：冀ICP备18017068号-3X',
                      actionsText: ['确定'],
                    ));
          },
        ),
      ]),
    );
  }
}
