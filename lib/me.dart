import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mpcore/mpcore.dart';

class MePage extends StatefulWidget {
  const MePage({Key? key}) : super(key: key);

  @override
  State<MePage> createState() => _MePageState();
}

class _MePageState extends State<MePage> {
  @override
  Widget build(BuildContext context) {
    return MPScaffold(
      name: "我的",
      appBar: MPAppBar(
        title: Text("我的"),
        context: context,
      ),
      body: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: Container(
                  height: 100,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50),
                    gradient: LinearGradient(colors: [
                      Colors.blue,
                      Colors.lightBlue,
                      Colors.lightBlue,
                      Colors.white,
                    ])
                  ),
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("工作日历", style: TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                            color: Colors.white)).marginOnly(left: 30),
                        Text("Powered by Kingtous", style: TextStyle(color: Colors.white)).marginOnly(left: 50),
                        buildMenu(context),
                      ]
                    ),
                  )
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
      ]
    );
  }
}
