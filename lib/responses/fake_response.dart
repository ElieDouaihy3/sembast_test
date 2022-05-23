
import 'package:flutter/material.dart';

List<Map<String, Object?>> formsLst = [
  {
    "name"      : "",
    "last_name" : "",
    "address"   : "",
    "road"      : "",
  },
  {
    "country"   : "",
    "zip_code"  : "",
  }
];

List<Map<String,TextEditingController>> formsTECLst = [
  {
    "name"      : TextEditingController(),
    "last_name" : TextEditingController(),
    "address"   : TextEditingController(),
    "road"      : TextEditingController(),
  },
  {
    "country"   : TextEditingController(),
    "zip_code"  : TextEditingController(),
  }
];



