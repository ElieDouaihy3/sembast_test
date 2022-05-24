
import 'package:flutter/material.dart';

List<Map<String, Object?>> formsLst = [
  {
    "name"      : "",
    "last_name" : "",
    "address"   : "",
    "road"      : "",
    "image"     : "",
  },
  {
    "country"   : "",
    "zip_code"  : "",
    "image"     : "",
  }
];

List<Map<String,TextEditingController>> formsTECLst = [
  {
    "name"      : TextEditingController(),
    "last_name" : TextEditingController(),
    "address"   : TextEditingController(),
    "road"      : TextEditingController(),
    "image"     : TextEditingController(),
  },
  {
    "country"   : TextEditingController(),
    "zip_code"  : TextEditingController(),
    "image"     : TextEditingController(),
  }
];



