import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sembast_test/controllers/AddController.dart';
import 'package:sembast_test/responses/fake_response.dart';
import 'package:sembast_test/pages/ShowDataPage.dart';

class AddPage extends StatelessWidget {
  const AddPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final AddController addController = Get.put(AddController());
    return Scaffold(
      body:SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [

              SizedBox(
                height:Get.height*0.06,
              ),

              for(int i=0;i<formsLst.length;i++)
                GetBuilder<AddController>(
                  builder:(controller){
                    return Column(
                        crossAxisAlignment:CrossAxisAlignment.start,
                        children:[
                          Row(
                            mainAxisAlignment:MainAxisAlignment.spaceBetween,
                            children: [
                              Text('Form_$i'),
                              TextButton(
                                  onPressed:(){
                                    Get.to(()=>ShowDataPage(semBastKey:'Form_$i',));

                                  },
                                  child:const Text(
                                    "Show Data"
                                  )
                              ),

                            ],
                          ),
                          const Divider(),
                          Column(
                            crossAxisAlignment:CrossAxisAlignment.start,
                            children:formsLst[i].entries.map<Widget>((e){
                              return Row(
                                children: [
                                  SizedBox(width:100.0,child: Text("${e.key} :")),
                                  Flexible(child:TextField(
                                    controller:formsTECLst[i][e.key],
                                    onChanged:(value){
                                      formsLst[i][e.key]=value;
                                    },
                                  ))
                                ],
                              );
                            }).toList(),
                          ),
                          SizedBox(
                            width:Get.width,
                            child:ElevatedButton(
                              onPressed:() async {
                                controller.saveData('Form_$i',formsLst[i],i);
                              },
                              child:const Text(
                                  "Save"
                              ),
                            ),
                          )
                        ]
                    );
                  },
                )
            ],
          ),
        ),
      ),
    );
  }
}