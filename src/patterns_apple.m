#import <Foundation/Foundation.h>

#include <string.h>

#include "patterns.h"

char* sdtf_get_pattern(int32_t kind) {
  @autoreleasepool {
    NSDateFormatter* formatter = [[NSDateFormatter alloc] init];
    switch (kind) {
      case SDTF_DATE:
        formatter.dateStyle = NSDateFormatterShortStyle;
        break;
      case SDTF_MEDIUM_DATE:
        formatter.dateStyle = NSDateFormatterMediumStyle;
        break;
      case SDTF_LONG_DATE:
        formatter.dateStyle = NSDateFormatterLongStyle;
        break;
      case SDTF_FULL_DATE:
        formatter.dateStyle = NSDateFormatterFullStyle;
        break;
      case SDTF_TIME:
        formatter.timeStyle = NSDateFormatterShortStyle;
        break;
    }

    const char* pattern = formatter.dateFormat.UTF8String;
    char* result = pattern == NULL ? NULL : strdup(pattern);
#if !__has_feature(objc_arc)
    [formatter release];
#endif
    return result;
  }
}
