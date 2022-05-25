import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:sembast_test/global/global.dart';
import 'package:sembast_test/models/mobile_app_data_model.dart';
import 'package:sembast_test/pages/AppInfo.dart';
import 'package:xml2json/xml2json.dart';

class AppInfoController extends GetxController with GetTickerProviderStateMixin {
  //Placed As Future Variable To Avoid Re-fetch Of The Data When Hot Reloading For Fast Development And Result
  Future<void>? getDataFuture;
  //Instance To Access Parent Variables
  MainApplicationInfo parent;
  //List To Store Data Of The Tabs As User Can Change App And We Need To Set New Tab Data
  List<Tab> tabsLst = [];
  //List To Store Tabs Page That Will Appear Based On A Tab
  List<Widget> tabsPages = [];
  //Variable Of TabController To Control It And Change Its Length
  TabController? tabController;
  //Scaffold Key To Control Drawer
  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  //Drawer Map Data
  Map drawerContentMap = {};

  //Constructor Taking Parent Data To Control Or Having Access Of All Page Instances
  AppInfoController({
    required this.parent
  });

  //Get Initialize Function
  @override
  void onInit(){
    super.onInit();
    getData();
  }

  //Function Used To Get/Refresh Data Call
  void getData(){
    getDataFuture = getDataFunction();
    update();
  }

  //Function Used To Fetch Sub Items Based On An Application ID
  Future<List<MobileAppData>> getDataFunction() async{
    tabsLst = [];
    tabsPages = [];
    String url = "$baseUrl/Mobile/ReadSubItems.aspx?ID=${parent.mobileAppData.id}";
    print(url);
    http.Response response = await http.get(
        Uri.parse(url),
        headers:<String,String>{
          "Cookie": globalCookie
        }
    );
    print(response.body);
    final Xml2Json myTransformer = Xml2Json();
    myTransformer.parse(response.body);
    String xml = myTransformer.toBadgerfish();
    var map = jsonDecode(xml)["Item"]["SubItems"]["Item"];
    List<MobileAppData> dataList = [];
    for(int i=0;i<map.length;i++){
      MobileAppData mobileAppDataObject = MobileAppData.fromMap(map[i]);
      dataList.add(mobileAppDataObject);
      if(mobileAppDataObject.label=="Sidebar"){
        drawerContentMap = mobileAppDataObject.subItems!;
      }
      else{
        tabsLst.add(tabItem(mobileAppDataObject));
        tabsPages.add(tabPage(mobileAppDataObject));
      }
    }
    tabController =TabController(length:tabsLst.length, vsync:this);
    update();
    return dataList;
  }

  //Return Tab Item
  Tab tabItem(MobileAppData mobileAppDataObject){
    return Tab(
      child:Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(Icons.add),
          const SizedBox(width: 8),
          Text(mobileAppDataObject.label.toString()),
        ],
      ),
    );
  }

  //Return Tab Page
  //text need to be changed to object soon
  Widget tabPage(MobileAppData mobileAppDataObject){
    return SingleChildScrollView(
        child:Column(
          children: [
            Text(
                mobileAppDataObject.subItems.toString(),
                style:const TextStyle(
                  color:Colors.white
                ),
            )
          ],
        ),
    );
  }


}