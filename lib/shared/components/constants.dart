// ignore_for_file: avoid_print

import 'package:experiences_app/modules/Login/login_screen.dart';
import 'package:experiences_app/shared/components/components.dart';
import 'package:experiences_app/shared/network/local/cache_helper.dart';

void singOut(context) {
  CacheHelper.removeData(key: 'token').then((value) {
    if (value) {
      navigateAndFinish(context, ShopLoginScreen());
    }
  });
}

void printFullText(String text) {
  final pattern = RegExp('.{1.800}');
  pattern.allMatches(text).forEach((match) => print(match.group(0)));
}

String token = '';
