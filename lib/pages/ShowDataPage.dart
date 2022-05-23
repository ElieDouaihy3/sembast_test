import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sembast_test/controllers/ShowDataController.dart';

class ShowDataPage extends StatelessWidget {
  final String semBastKey;

  const ShowDataPage({
    Key? key ,
    required this.semBastKey
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ShowDataController showDataController  = Get.put(ShowDataController());
    return Scaffold(
      body:SingleChildScrollView(
        child:Column(
          children: [
            SizedBox(
              height:Get.height*0.05,
            ),
            ElevatedButton(
              onPressed:(){
                showDataController.syncAll(semBastKey);
              },
              child:const Text(
                  "Sync All"
              ),
            ),
            FutureBuilder(
                future:showDataController.getData(semBastKey),
              builder: (context,AsyncSnapshot snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const CircularProgressIndicator();
                } else {
                  if (snapshot.hasError) {
                    // Any error occured while initilizing app
                    return Text(snapshot.error.toString());
                  }
                  else {
                    return GetBuilder<ShowDataController>(
                        builder: (controller){
                          return  Column(
                            children: [
                              for(int i=0;i<showDataController.DataLst.length;i++)
                                Column(
                                  crossAxisAlignment:CrossAxisAlignment.start,
                                  children: [
                                    const Divider(color:Colors.black,),
                                    Column(
                                      crossAxisAlignment:CrossAxisAlignment.start,
                                      children:showDataController.DataLst[i].value.entries.map<Widget>((e){
                                        return Text(
                                            "${e.key}:${e.value}"
                                        );
                                      }).toList(),
                                    ),
                                    ElevatedButton(
                                      onPressed:(){
                                        controller.syncSingle(semBastKey,showDataController.DataLst[i].key);
                                      },
                                      child:const Text(
                                          "Sync"
                                      ),
                                    ),
                                  ],
                                )
                            ],
                          );
                        }
                    );
                  }
                }
              },
            )



          ],
        ),
      ),
    );
  }
}
