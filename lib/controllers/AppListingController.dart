import 'dart:convert';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:sembast_test/global/global.dart';
import 'package:sembast_test/models/mobile_app_data_model.dart';
import 'package:xml2json/xml2json.dart';


class AppListingPageController extends GetxController with GetSingleTickerProviderStateMixin {
  //Placed As Future Variable To Avoid Re-fetch Of The Data When Hot Reloading For Fast Development And Result
  Future<void>? getDataFuture;

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

  //Function That Get User Cookie That Need To Be Deleted After Auth Migration
  Future<String> loginFunction() async {
    String url = "$baseUrl/Mobile/Login.aspx?Username=designer&Password=temp1234&AutoLogin=true";
    http.Response response = await http.get(
        Uri.parse(url),
        headers:{}
    );
    return response.headers["set-cookie"].toString();
  }

  //Function That Get Apps To The Logged In User
  Future<List<MobileAppData>> getDataFunction() async {
    globalCookie = await loginFunction();
    String url = "$baseUrl/Mobile/ReadSubItems.aspx";
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
      dataList.add(MobileAppData.fromMap(map[i]));
    }
    return dataList;
  }


}


