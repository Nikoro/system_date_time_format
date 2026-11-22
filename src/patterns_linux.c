#ifndef _GNU_SOURCE
#define _GNU_SOURCE
#endif

#include "patterns.h"

#include <ctype.h>
#include <langinfo.h>
#include <locale.h>
#include <stdlib.h>
#include <string.h>
#include <unicode/udat.h>
#include <unicode/ustring.h>

static const char* date_token(char token) {
  switch (token) {
    case 'a': return "EEE";
    case 'A': return "EEEE";
    case 'b':
    case 'h': return "MMM";
    case 'B': return "MMMM";
    case 'C':
    case 'g':
    case 'y': return "yy";
    case 'd': return "dd";
    case 'D': return "MM/dd/yy";
    case 'e': return "d";
    case 'F': return "yyyy-MM-dd";
    case 'G':
    case 'Y': return "yyyy";
    case 'j': return "DDD";
    case 'm': return "MM";
    default: return NULL;
  }
}

static const char* time_token(char token) {
  switch (token) {
    case 'H': return "HH";
    case 'I': return "hh";
    case 'M': return "mm";
    case 'n': return "\n";
    case 'p': return "a";
    case 'r': return "hh:mm:ss a";
    case 'R': return "HH:mm";
    case 'S': return "ss";
    case 't': return "\t";
    case 'T': return "HH:mm:ss";
    default: return NULL;
  }
}

static char* convert_pattern(const char* pattern,
                             const char* (*replace)(char)) {
  // Each two-character token can expand to at most ten characters.
  char* result = malloc(strlen(pattern) * 5 + 1);
  if (result == NULL) return NULL;

  char* end = result;
  for (const char* current = pattern; *current != '\0'; ++current) {
    if (*current == '%' && current[1] != '\0') {
      const char* replacement = replace(*++current);
      if (replacement != NULL) {
        size_t length = strlen(replacement);
        memcpy(end, replacement, length);
        end += length;
        continue;
      }
    }
    *end++ = *current;
  }

  char* start = result;
  while (start < end && isspace((unsigned char)*start)) ++start;
  while (end > start && isspace((unsigned char)end[-1])) --end;
  size_t length = end - start;
  memmove(result, start, length);
  result[length] = '\0';
  return result;
}

// POSIX defines a short date and a combined date/time, but no long date.
// Ask ICU for the date-only long style for the same LC_TIME as nl_langinfo.
static char* long_date_pattern(void) {
#ifdef NL_LOCALE_NAME
  const char* locale = nl_langinfo(NL_LOCALE_NAME(LC_TIME));
#else
  const char* locale = setlocale(LC_TIME, NULL);
#endif
  if (locale == NULL) return NULL;
  if (strcmp(locale, "POSIX") == 0 || strcmp(locale, "C") == 0 ||
      strncmp(locale, "C.", 2) == 0) {
    locale = "en_US_POSIX";
  }

  UErrorCode status = U_ZERO_ERROR;
  UDateFormat* format = udat_open(UDAT_NONE, UDAT_LONG, locale, NULL, 0,
                                  NULL, 0, &status);
  if (U_FAILURE(status)) return NULL;

  int32_t length = udat_toPattern(format, 0, NULL, 0, &status);
  UChar* pattern = status == U_BUFFER_OVERFLOW_ERROR
                       ? malloc((length + 1) * sizeof(*pattern))
                       : NULL;
  if (pattern != NULL) {
    status = U_ZERO_ERROR;
    udat_toPattern(format, 0, pattern, length + 1, &status);
  }
  udat_close(format);
  if (pattern == NULL) return NULL;

  // Each UTF-16 code unit needs at most three UTF-8 bytes.
  int32_t capacity = 3 * length + 1;
  char* result = malloc(capacity);
  if (result != NULL) {
    u_strToUTF8(result, capacity, NULL, pattern, length, &status);
    if (U_FAILURE(status)) {
      free(result);
      result = NULL;
    }
  }
  free(pattern);
  return result;
}

char* sdtf_get_pattern(int32_t kind) {
  switch (kind) {
    case SDTF_DATE: return convert_pattern(nl_langinfo(D_FMT), date_token);
    case SDTF_LONG_DATE: return long_date_pattern();
    case SDTF_TIME: return convert_pattern(nl_langinfo(T_FMT), time_token);
    default: return NULL;
  }
}
