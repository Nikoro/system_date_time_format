#define _XOPEN_SOURCE 700

#include <assert.h>
#include <locale.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#include "../../src/patterns.h"

static void expect_pattern(int kind, const char* expected) {
  char* pattern = sdtf_get_pattern(kind);
  if (pattern == NULL || strcmp(pattern, expected) != 0) {
    fprintf(stderr, "Expected [%s], got [%s]\n", expected, pattern ? pattern : "null");
    exit(EXIT_FAILURE);
  }
  sdtf_free_pattern(pattern);
}

int main(void) {
  assert(setlocale(LC_TIME, "C") != NULL);
  expect_pattern(SDTF_DATE, "MM/dd/yy");
  expect_pattern(SDTF_TIME, "HH:mm:ss");
  expect_pattern(SDTF_LONG_DATE, "MMMM d, y");
  assert(setlocale(LC_TIME, "pl_PL.UTF-8") != NULL);
  expect_pattern(SDTF_LONG_DATE, "d MMMM y");
  locale_t spanish = newlocale(LC_TIME_MASK, "es_ES.UTF-8", (locale_t)0);
  assert(spanish != (locale_t)0);
  locale_t previous = uselocale(spanish);
  assert(previous != (locale_t)0);
  expect_pattern(SDTF_LONG_DATE, "d 'de' MMMM 'de' y");
  assert(uselocale(previous) != (locale_t)0);
  freelocale(spanish);
  expect_pattern(SDTF_LONG_DATE, "d MMMM y");
  return 0;
}
