//api link collection
////////////
import 'package:flutter/material.dart';
import 'package:shop_app/shared/components/components.dart';

import '../../network/local/cache_helper.dart';
import '../../pages/login/login_screen.dart';
//GET
//POST
//UPDATE
//DELETE



void printFullText(String text){
  final pattern = RegExp('.{1,800}');
  pattern.allMatches(text).forEach((match) {
    print(match.group(0));
  });

}
//login or register token
String? token;

int currentInndex =0 ;