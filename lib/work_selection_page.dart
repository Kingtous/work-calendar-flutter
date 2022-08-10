import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mpcore/mpcore.dart';

class WorkSelectionPage extends StatefulWidget {
  const WorkSelectionPage({Key? key}) : super(key: key);

  @override
  State<WorkSelectionPage> createState() => _WorkSelectionPageState();
}

class _WorkSelectionPageState extends State<WorkSelectionPage> {
  @override
  Widget build(BuildContext context) {
    return MPScaffold(
      name: "工作日历配置",
      appBar: MPAppBar(
        context: context,
        title: const Text('工作日历配置')
      ),
      body: Column(
        children: [
          Row(
            children: [
              Container(
                height: 20,
                width: 5,
                color: Colors.grey,
              ).marginOnly(right: 8.0),
              Text("轮班机制")
            ],
          ),

        ],
      ).marginSymmetric(horizontal: 8.0),
    );
  }


}
