@TestOn('vm')
import 'dart:io';

import 'package:dart_code_metrics/src/analyzers/unused_l10n_analyzer/reporters/reporters_list/console/unused_l10n_console_reporter.dart';
import 'package:dart_code_metrics/src/analyzers/unused_l10n_analyzer/unused_l10n_analyzer.dart';
import 'package:dart_code_metrics/src/analyzers/unused_l10n_analyzer/unused_l10n_config.dart';
import 'package:path/path.dart';
import 'package:test/test.dart';

void main() {
  group(
    'UnusedL10nAnalyzer',
    () {
      const analyzer = UnusedL10nAnalyzer();
      const rootDirectory = '';
      const analyzerExcludes = <String>[
        'test/resources/**',
        'test/resources/unused_files_analyzer/generated/**/**',
        'test/**/examples/**',
      ];
      final folders = [
        normalize(
          File('test/resources/unused_l10n_analyzer').absolute.path,
        ),
      ];

      test('should analyze files', () async {
        final config = _createConfig(analyzerExcludePatterns: analyzerExcludes);

        final result = await analyzer.runCliAnalysis(
          folders,
          rootDirectory,
          config,
        );

        final report = result.single;
        expect(report.className, 'TestI18n');

        final firstIssue = report.issues.first;
        expect(firstIssue.memberName, 'getter');
        expect(firstIssue.location.line, 4);
        expect(firstIssue.location.column, 3);

        final secondIssue = report.issues.elementAt(1);
        expect(secondIssue.memberName, 'regularGetter');
        expect(secondIssue.location.line, 13);
        expect(secondIssue.location.column, 3);

        final thirdIssue = report.issues.elementAt(2);
        expect(
          thirdIssue.memberName,
          'secondMethod(String value, num number)',
        );
        expect(thirdIssue.location.line, 8);
        expect(thirdIssue.location.column, 3);
      });

      test('should analyze files with custom class pattern', () async {
        final config = _createConfig(
          analyzerExcludePatterns: analyzerExcludes,
          classPattern: r'^S$',
        );

        final result = await analyzer.runCliAnalysis(
          folders,
          rootDirectory,
          config,
        );

        final report = result.single;
        expect(report.className, 'S');

        final firstIssue = report.issues.first;
        expect(firstIssue.memberName, 'field');
        expect(firstIssue.location.line, 23);
        expect(firstIssue.location.column, 3);

        final secondIssue = report.issues.elementAt(1);
        expect(secondIssue.memberName, 'regularField');
        expect(secondIssue.location.line, 36);
        expect(secondIssue.location.column, 3);

        final thirdIssue = report.issues.elementAt(2);
        expect(thirdIssue.memberName, 'method(String value)');
        expect(thirdIssue.location.line, 27);
        expect(thirdIssue.location.column, 3);

        final forthIssue = report.issues.elementAt(3);
        expect(
          forthIssue.memberName,
          'secondMethod(String value, num number)',
        );
        expect(forthIssue.location.line, 29);
        expect(forthIssue.location.column, 3);
      });

      test('should report no issues for a custom class name pattern', () async {
        final config = _createConfig(
          analyzerExcludePatterns: analyzerExcludes,
          classPattern: 'SomeClass',
        );

        final result = await analyzer.runCliAnalysis(
          folders,
          rootDirectory,
          config,
        );

        expect(result, isEmpty);
      });

      test(
        'should analyze files with custom class name using extension',
        () async {
          final config = _createConfig(
            analyzerExcludePatterns: analyzerExcludes,
            classPattern: 'L10nClass',
          );

          final result = await analyzer.runCliAnalysis(
            folders,
            rootDirectory,
            config,
          );

          expect(result, isEmpty);
        },
      );

      test('should return a reporter', () {
        final reporter = analyzer.getReporter(name: 'console', output: stdout);

        expect(reporter, isA<UnusedL10nConsoleReporter>());
      });
    },
    testOn: 'posix',
  );
}

UnusedL10nConfig _createConfig({
  Iterable<String> analyzerExcludePatterns = const [],
  String classPattern = r'I18n$',
}) =>
    UnusedL10nConfig(
      excludePatterns: const [],
      analyzerExcludePatterns: analyzerExcludePatterns,
      classPattern: classPattern,
    );
