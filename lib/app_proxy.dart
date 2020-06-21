import 'dart:async';

import 'package:flutter/services.dart';

class AppProxy {
  static const MethodChannel _channel =
      const MethodChannel('app_proxy');

  static Future<String> get platformVersion async {
    final String version = await _channel.invokeMethod('getPlatformVersion');
    //debug
    return version;
  }

  static Future<Map<String,dynamic>> checkProxyEnable() async {
    final Map<String,dynamic> proxyInfo = await _channel.invokeMethod("getProxyInfo");
    
    if(proxyInfo["PROXYENABLE"] == false){
      return null;
    }else{
      return proxyInfo;
    }
  }
}
