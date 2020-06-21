import 'dart:async';

import 'package:flutter/services.dart';

class AppProxyInfo{
  final String proxyAddress;
  final String proxyPort;
  final bool proxyEnable;

  AppProxyInfo({this.proxyAddress,this.proxyPort,this.proxyEnable});
}

class AppProxy {
  static const _proxyEnableKey = "PROXYENABLE";
  static const _proxyAddressKey = "HttpProxyAddress";
  static const _proxyPortKey = "HttpProxyPort";
  static const _proxyHttpEnableKey = "HttpProxyEnable";

  static const MethodChannel _channel =
      const MethodChannel('app_proxy');

  static Future<String> get platformVersion async {
    final String version = await _channel.invokeMethod('getPlatformVersion');
    //debug
    return version;
  }

  static Future<AppProxyInfo> checkProxyEnable() async {
    final Map<String,dynamic> proxyInfo = await _channel.invokeMethod("getProxyInfo");
    
    if(proxyInfo["PROXYENABLE"] == false){
      return AppProxyInfo(proxyEnable: false);
    }else{
      return AppProxyInfo(proxyAddress: proxyInfo[_proxyAddressKey],proxyPort: proxyInfo[_proxyPortKey],proxyEnable: proxyInfo[_proxyHttpEnableKey]);
    }
  }
}
