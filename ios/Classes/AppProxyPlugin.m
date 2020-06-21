#import "AppProxyPlugin.h"
#if __has_include(<app_proxy/app_proxy-Swift.h>)
#import <app_proxy/app_proxy-Swift.h>
#else
// Support project import fallback if the generated compatibility header
// is not copied when this plugin is created as a library.
// https://forums.swift.org/t/swift-static-libraries-dont-copy-generated-objective-c-header/19816
#import "app_proxy-Swift.h"
#endif

@implementation AppProxyPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  [SwiftAppProxyPlugin registerWithRegistrar:registrar];
}
@end
