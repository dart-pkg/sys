import 'package:test/test.dart';
import 'package:output/output.dart';
import 'package:sys/sys.dart' as sys;
//import 'package:path/path.dart' as path;

void main() {
  group('Run', () {
    test('run1', () async {
      echo(sys.timeBasedVersionString());
      // dump(sys.pathBaseName('abc.xyz.exe'));
      // dump(sys.pathExtension('abc.xyz.exe'));
      // dump(sys.pathFiles('xyz'));
      // dump(sys.pathDirectories('xyz'));
      // // echoJson(sys.pathFiles(r'D:\home11\pub\sys', true));
      // // echoJson(sys.pathFiles(r'D:\home11\pub\sys'));
      // // echoJson(sys.pathDirectories(r'D:\home11\pub\sys'));
      // echo(
      //   await sys.httpGetBodyAsync(
      //     'https://github.com/dart-pkg/winsys/raw/main/README.md',
      //   ),
      // );
      // echo(
      //   await sys.httpGetBodyAsync(
      //     'https://github.com/dart-pkg/not-exist/raw/main/README.md',
      //   ),
      // );
      //await sys.runAsync('dir /w');
      int code = await sys.runAsync$(
        [
          'dart',
          'pub',
          'deps',
          '--no-dev',
          '--style',
          'list',
          '|',
          'sed',
          '"/^ .*/d"',
        ],
        returnCode: true,
        useBash: true,
        autoQuote: false,
      );
      echo(code, 'code');
      await sys.runAsync(
        'dart pub deps --no-dev --style list | sed "/^ .*/d"',
        useBash: true,
      );
    });
  });
}
