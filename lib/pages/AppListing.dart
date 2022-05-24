import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sembast_test/controllers/AppListingController.dart';
import 'package:sembast_test/global/global.dart';
import 'package:sembast_test/models/mobile_app_data_model.dart';

class AppListingPage extends StatelessWidget {

  const AppListingPage({
    Key? key
  }) : super(key: key);


  Widget displayApps(List<MobileAppData> dataList){
    return ListView.builder(
        itemCount:dataList.length,
        itemBuilder:(context,i){
          return ListTile(
            onTap:(){

            },
            leading:SizedBox(
              width:55.0,
              height:55.0,
              child: Image.network(
                baseUrlImage+dataList[i].icon.toString(),
              ),
            ),
            title:Text(
              dataList[i].label.toString(),
              style:const TextStyle(
                  color:Colors.white,
                  fontWeight:FontWeight.bold
              ),
            ),
            subtitle:Text(
              dataList[i].description.toString().replaceAll("null", ""),
              style:const TextStyle(
                  color:Colors.white
              ),
            ),
          );
        }
    );
  }

  Widget displayError(AppListingPageController controller){
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


  @override
  Widget build(BuildContext context) {
    final AppListingPageController appListingPageController = Get.put(AppListingPageController());

    return SafeArea(
      child:Scaffold(
        body:Container(
            width:Get.width,
            height:Get.height,
            decoration:const BoxDecoration(
              image:DecorationImage(
                  image:AssetImage("assets/AppPage_Background.jpg"),
                  fit:BoxFit.cover
              ),
            ),
            child:GetBuilder<AppListingPageController>(
              builder:(controller){
                return Column(
                  crossAxisAlignment:CrossAxisAlignment.center,
                  children: [
                    Padding(
                      padding:const EdgeInsets.only(
                          left : 8.0,
                          right: 8.0
                      ),
                      child:Row(
                        mainAxisAlignment:MainAxisAlignment.spaceBetween,
                        children: [
                          Image.asset(
                            "assets/logo-name-white.png",
                            width:120,
                            height:65,
                          ),
                          const CircleAvatar(
                            child:Text(
                                "ED"
                            ),
                          ),
                        ],
                      ),
                    ),
                    const Divider(color:Colors.white,),
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
                              return displayApps(snapshot.data);
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