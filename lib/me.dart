import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mpcore/mpcore.dart';
import 'package:work_calendar/component/button.dart';

class MePage extends StatelessWidget {
  const MePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MPScaffold(
      name: "我的",
      body: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text("工作日历", style: TextStyle(
                              fontSize: 30,
                              fontWeight: FontWeight.bold,
                            )),
                            Text("Powered by Kingtous").marginOnly(left: 10,bottom: 8.0),
                          ],
                        ),
                        buildMenu(context),
                      ]
                  ),
                ).marginSymmetric(horizontal: 8.0, vertical: 4.0),
              ),
            ],
          ),


        ],
      ),
    );
  }

  Widget buildMenu(BuildContext context) {
    return Column(
        children: [
          // MP
          KButton(text: "轮班设置", icon: MPIcon(MaterialIcons.settings), onTap: () {
            Get.toNamed('/work_selection');
          },),
        ]
    );
  }
}
