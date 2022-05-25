import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sembast_test/controllers/AppInfoController.dart';
import 'package:sembast_test/global/dynamic_tab.dart';
import 'package:sembast_test/global/global.dart';
import 'package:sembast_test/models/mobile_app_data_model.dart';

class MainApplicationInfo extends StatelessWidget {
  MobileAppData mobileAppData;
  final List<MobileAppData> mobileAppDataList;

  MainApplicationInfo({
    Key? key                        ,
    required this.mobileAppData     ,
    required this.mobileAppDataList ,
  }) : super(key: key);


  Widget displayError(AppInfoController controller){
    return Center(
        child:Column(
          mainAxisAlignment:MainAxisAlignment.center,
          children: [
            const Text(
              "Error Occurred!",
              style:TextStyle(
                  color:Colors.white,
                  fontWeight:FontWeight.bold
              ),
            ),
            OutlinedButton(
                onPressed:(){
                  controller.getData();
                },
                child:const Text(
                  "Retry",
                  style:TextStyle(
                      color:Colors.white
                  ),
                )
            ),
          ],
        )
    );
  }

  Widget displayTab(List<MobileAppData> dataList,AppInfoController controller){
    return DynamicTab(
      tabController: controller.tabController!,
      tabsList: controller.tabsLst,
      pagesList: controller.tabsPages,
    );
  }

  @override
  Widget build(BuildContext context) {
    final AppInfoController appInfoController = Get.put(AppInfoController(parent:this));
    return SafeArea(
      child: Scaffold(
        key:appInfoController.scaffoldKey,
        drawer:Drawer(
          child:GetBuilder<AppInfoController>(
            builder:(controller) {
              return Container(
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage("assets/AppPage_Background.jpg"),
                    fit: BoxFit.cover,
                  ),
                ),
                child: Text(
                    appInfoController.drawerContentMap.toString(),
                    style:const TextStyle(
                      color:Colors.white
                    ),
                ),
              );
            },
          ),
        ),
        appBar: AppBar(
            leadingWidth:40,
            leading:IconButton(
              icon:const Icon(Icons.menu),
              onPressed:(){
                appInfoController.scaffoldKey.currentState!.openDrawer();
              },
            ),
            flexibleSpace: Container(
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("assets/AppPage_Background.jpg"),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            backgroundColor: Colors.transparent,
            title:SizedBox(
              width:Get.width*0.8,
              height:45.0,
              child:DropdownButton(
                underline:const SizedBox(),
                hint:Text(
                  mobileAppData.label.toString(),
                  style:const TextStyle(
                      color:Colors.blueGrey
                  ),
                ),
                value: mobileAppData,
                onChanged: (MobileAppData? newValue) {
                  mobileAppData = newValue!;
                  appInfoController.getData();
                },
                items: mobileAppDataList.map((mobileAppDataValue) {
                  return DropdownMenuItem(
                    value: mobileAppDataValue,
                    child:SizedBox(
                      width:Get.width*0.7,
                      height:75.0,
                      child:ListTile(
                        dense:true,
                        contentPadding:EdgeInsets.zero,
                        leading:Image.network(
                          baseUrlImage+mobileAppDataValue.icon.toString(),
                          width:45.0,
                          height:45.0,
                        ),
                        title:Text(
                          mobileAppDataValue.label.toString(),
                          style:TextStyle(
                              color:Colors.grey[400],
                              fontWeight:FontWeight.bold
                          ),
                        ),
                      ),
                    ),
                  );
                }).toList(),
              ),
            )
        ),
        body:Container(
            width:MediaQuery.of(context).size.width,
            height:MediaQuery.of(context).size.height,
            decoration:const BoxDecoration(
              image:DecorationImage(
                  image:AssetImage("assets/AppPage_Background.jpg"),
                  fit:BoxFit.cover
              ),
            ),
            child:GetBuilder<AppInfoController>(
              builder:(controller){
                return Column(
                  crossAxisAlignment:CrossAxisAlignment.center,
                  children: [
                    Expanded(
                      child: FutureBuilder(
                        future:controller.getDataFuture,
                        builder: (BuildContext context, AsyncSnapshot snapshot) {
                          if (snapshot.connectionState == ConnectionState.waiting) {
                            return const Center(
                              child:CircularProgressIndicator(
                                color:Colors.white,
                              ),
                            );
                          } else {
                            if (snapshot.hasError) {
                              return displayError(controller);
                            }
                            else {
                              return displayTab(snapshot.data,controller);
                            }
                          }
                        },
                      ),
                    ),
                  ],
                );
              },
            )
        ),
      ),
    );
  }
}