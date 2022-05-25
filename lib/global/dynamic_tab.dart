import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DynamicTab extends StatelessWidget {
  final TabController tabController;
  final List<Tab> tabsList;
  final List<Widget> pagesList;

  const DynamicTab({
    Key? key ,
    required this.tabController    ,
    required this.tabsList         ,
    required this.pagesList        ,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width:Get.width,
      height:Get.height,
      child:Column(
        children: [

          Container(
            width:Get.width,
            color:Colors.grey,
            child:TabBar(
              controller:tabController,
              isScrollable:true,
              padding:EdgeInsets.zero,
              indicator: const BoxDecoration(
                  borderRadius: BorderRadius.only(
                      topRight:Radius.circular(3.6),
                      topLeft:Radius.circular(3.6)
                  ), // Creates border
                  color: Colors.black54),
              tabs: tabsList ,
            ),
          ),
          SizedBox(
            width:Get.width,
            height:Get.height-140.0,
            child:TabBarView(
                controller:tabController,
                children : pagesList
            ),
          ),
        ],
      ),
    );
  }
}
