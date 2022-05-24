import 'dart:convert';

import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sembast/sembast.dart';
import 'package:sembast_test/responses/fake_response.dart';
import 'package:sembast_test/sembast_manager.dart';

class AddController extends GetxController {

  @override
  void onInit(){
    super.onInit();
    semBastInstance.openDB();
  }

  void saveData(String key,Map<String, Object?> valueMap,int index){
    semBastInstance.saveDB(key, valueMap).then((value){
      valueMap.forEach((key, value) {
        valueMap[key]="";
        formsTECLst[index][key]!.text = "";
      });
      update();
    });
  }

  Future<void> chooseImage(String key,int index) async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);
    image!.readAsBytes().then((value){
      formsLst[index][key]=base64Encode(value);
      update();
    });
  }

}