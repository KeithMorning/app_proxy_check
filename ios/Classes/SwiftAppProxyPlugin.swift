import Flutter
import UIKit

public class SwiftAppProxyPlugin: NSObject, FlutterPlugin {
  public static func register(with registrar: FlutterPluginRegistrar) {
    let channel = FlutterMethodChannel(name: "app_proxy", binaryMessenger: registrar.messenger())
    let instance = SwiftAppProxyPlugin()
    registrar.addMethodCallDelegate(instance, channel: channel)
  }

  public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
    if(call.method == "getPlatformVersion"){
        result("iOS " + UIDevice.current.systemVersion)
    }else if(call.method == "getProxyInfo"){
        let enable = checkProxy();
        result(enable);
    }
    
  }


    private func checkProxy()->[String:Any]{
    
    let NoProxy = ["PROXYENABLE":false];
    guard let proxy = CFNetworkCopySystemProxySettings()?.takeUnretainedValue() else { return NoProxy }
        guard let dict = proxy as? [String: Any] else { return NoProxy }

        guard let HTTPProxy = dict["HTTPProxy"] as? String else { return NoProxy }
        if(HTTPProxy.count>0){ 
            //ok it is open the http proxy
            
            let HttpProxyAddress =  dict["HTTPProxy"] as? String;
            let HttpProxyPort = dict["HTTPPort"];
            let HttpProxyEnable = dict["HTTPEnable"];
            
            return [
                "HttpProxyAddress":HttpProxyAddress ?? "",
                "HttpProxyPort":HttpProxyPort ?? "",
                "HttpProxyEnable":HttpProxyEnable ?? "",
            ];

        }else{
            return NoProxy;
        }
  }
  
}
