#ifndef SYSTEM_DATE_TIME_FORMAT_PATTERNS_H_
#define SYSTEM_DATE_TIME_FORMAT_PATTERNS_H_

#include <stdint.h>

#if defined(_WIN32)
#define SDTF_EXPORT __declspec(dllexport)
#else
#define SDTF_EXPORT __attribute__((visibility("default")))
#endif

// The order matches PatternKind in Dart.
enum SdtfPattern {
  SDTF_DATE,
  SDTF_MEDIUM_DATE,
  SDTF_LONG_DATE,
  SDTF_FULL_DATE,
  SDTF_TIME,
};

// Release the returned UTF-8 string with sdtf_free_pattern.
SDTF_EXPORT char* sdtf_get_pattern(int32_t kind);
SDTF_EXPORT void sdtf_free_pattern(char* pattern);

#endif
