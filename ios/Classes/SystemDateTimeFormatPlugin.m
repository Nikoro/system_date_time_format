#import "SystemDateTimeFormatPlugin.h"
#if __has_include(<system_date_time_format/system_date_time_format-Swift.h>)
#import <system_date_time_format/system_date_time_format-Swift.h>
#else
// Support project import fallback if the generated compatibility header
// is not copied when this plugin is created as a library.
// https://forums.swift.org/t/swift-static-libraries-dont-copy-generated-objective-c-header/19816
#import "system_date_time_format-Swift.h"
#endif

@implementation SystemDateTimeFormatPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  [SwiftSystemDateTimeFormatPlugin registerWithRegistrar:registrar];
}
@end
