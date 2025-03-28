@TestOn('vm')
import 'package:dart_code_metrics/src/cli/cli_runner.dart';
import 'package:dart_code_metrics/src/cli/commands/check_unused_files_command.dart';
import 'package:path/path.dart' as p;
import 'package:test/test.dart';

const _usage = 'Check unused *.dart files.\n'
    '\n'
    'Usage: metrics check-unused-files [arguments] <directories>\n'
    '-h, --help                                        Print this usage information.\n'
    '\n'
    '\n'
    '-r, --reporter=<console>                          The format of the output of the analysis.\n'
    '                                                  [console (default), json]\n'
    '\n'
    '\n'
    '    --root-folder=<./>                            Root folder.\n'
    '                                                  (defaults to current directory)\n'
    '    --sdk-path=<directory-path>                   Dart SDK directory path. Should be provided only when you run the application as compiled executable(https://dart.dev/tools/dart-compile#exe) and automatic Dart SDK path detection fails.\n'
    '    --exclude=<{/**.g.dart,/**.template.dart}>    File paths in Glob syntax to be exclude.\n'
    '                                                  (defaults to "{/**.g.dart,/**.template.dart}")\n'
    '\n'
    '\n'
    '    --[no-]fatal-unused                           Treat find unused file as fatal.\n'
    '\n'
    'Run "metrics help" to see global options.';

void main() {
  group('CheckUnusedFilesCommand', () {
    final runner = CliRunner();
    final command =
        runner.commands['check-unused-files'] as CheckUnusedFilesCommand;

    test('should have correct name', () {
      expect(command.name, 'check-unused-files');
    });

    test('should have correct description', () {
      expect(
        command.description,
        'Check unused *.dart files.',
      );
    });

    test('should have correct invocation', () {
      expect(
        command.invocation,
        'metrics check-unused-files [arguments] <directories>',
      );
    });

    test('should have correct usage', () {
      expect(
        command.usage.replaceAll('"${p.current}"', 'current directory'),
        _usage,
      );
    });
  });
}
