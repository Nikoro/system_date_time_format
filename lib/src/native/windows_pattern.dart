// Windows and ICU both use apostrophes for quoted text and doubled apostrophes
// for a literal apostrophe. Consume the whole quoted span before matching fields.
final _windowsFields = RegExp(r"'(?:''|[^'])*'|d+|t+|g+");

String convertWindowsPattern(String pattern) {
  return pattern.replaceAllMapped(_windowsFields, (match) {
    return switch (match[0]!) {
      'ddd' => 'EEE',
      'dddd' => 'EEEE',
      't' || 'tt' => 'a',
      'g' || 'gg' => 'G',
      final field => field,
    };
  });
}
