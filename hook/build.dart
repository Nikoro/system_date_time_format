import 'package:code_assets/code_assets.dart';
import 'package:hooks/hooks.dart';
import 'package:native_toolchain_c/native_toolchain_c.dart';

void main(List<String> args) async {
  await build(args, (input, output) async {
    if (!input.config.buildCodeAssets) return;

    final os = input.config.code.targetOS;
    final isApple = os == OS.iOS || os == OS.macOS;
    final source = switch (os) {
      OS.iOS || OS.macOS => 'src/patterns_apple.m',
      OS.linux => 'src/patterns_linux.c',
      OS.windows => 'src/patterns_windows.c',
      _ => null,
    };
    if (source == null) return;

    final builder = CBuilder.library(
      name: 'system_date_time_format',
      assetName: 'src/native/read_pattern.dart',
      sources: ['src/patterns.c', source],
      language: isApple ? Language.objectiveC : Language.c,
      frameworks: [if (isApple) 'Foundation'],
      libraries: [
        if (os == OS.windows) 'kernel32',
        if (os == OS.linux) ...['icui18n', 'icuuc'],
      ],
    );
    await builder.run(input: input, output: output);
    output.dependencies.add(input.packageRoot.resolve('src/patterns.h'));
  });
}
