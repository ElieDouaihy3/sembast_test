import 'package:get/get.dart';
import 'package:sembast/sembast.dart';
import 'package:sembast_test/sembast_manager.dart';

class ShowDataController extends GetxController {
  List<RecordSnapshot> DataLst = [];

  @override
  void onInit(){
    super.onInit();
  }

  Future<void> getData(String key) async {
    List<RecordSnapshot<int, Map<String, Object?>>> Lst = [];
    semBastInstance.getAllDataDB(key).then((valueLst){
      for (var element in valueLst) {
        DataLst.add(element);
      }
    });
  }

  void syncAll(String key){
    semBastInstance.delAllDB(key).then((value){
      DataLst = [];
      update();
    });
  }

  void syncSingle(String key,int keyIndex){
    semBastInstance.delAllDB(key).then((value){
      DataLst = [];
      update();
    });
  }




}