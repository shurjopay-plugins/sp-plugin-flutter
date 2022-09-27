#import "ShurjopaySdkPlugin.h"
#if __has_include(<shurjopay_sdk/shurjopay_sdk-Swift.h>)
#import <shurjopay_sdk/shurjopay_sdk-Swift.h>
#else
// Support project import fallback if the generated compatibility header
// is not copied when this plugin is created as a library.
// https://forums.swift.org/t/swift-static-libraries-dont-copy-generated-objective-c-header/19816
#import "shurjopay_sdk-Swift.h"
#endif

@implementation ShurjopaySdkPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  [SwiftShurjopaySdkPlugin registerWithRegistrar:registrar];
}
@end
