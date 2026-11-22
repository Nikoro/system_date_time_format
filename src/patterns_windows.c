#include "patterns.h"

#include <windows.h>

#include <stdlib.h>

char* sdtf_get_pattern(int32_t kind) {
  LCTYPE type;
  switch (kind) {
    case SDTF_DATE: type = LOCALE_SSHORTDATE; break;
    case SDTF_LONG_DATE: type = LOCALE_SLONGDATE; break;
    case SDTF_TIME: type = LOCALE_SSHORTTIME; break;
    default: return NULL;
  }

  int length = GetLocaleInfoW(LOCALE_USER_DEFAULT, type, NULL, 0);
  if (length == 0) return NULL;

  WCHAR* wide = malloc(length * sizeof(*wide));
  if (wide == NULL) return NULL;
  if (GetLocaleInfoW(LOCALE_USER_DEFAULT, type, wide, length) == 0) {
    free(wide);
    return NULL;
  }

  int size = WideCharToMultiByte(CP_UTF8, 0, wide, -1, NULL, 0, NULL, NULL);
  char* result = size > 0 ? malloc(size) : NULL;
  if (result != NULL &&
      WideCharToMultiByte(CP_UTF8, 0, wide, -1, result, size, NULL, NULL) == 0) {
    free(result);
    result = NULL;
  }
  free(wide);
  return result;
}
