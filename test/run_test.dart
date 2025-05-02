import 'dart:convert' as dart_convert;
import 'dart:typed_data';
import 'package:test/test.dart';
import 'package:debug_output/debug_output.dart';
import 'package:sys/sys.dart' as sys_sys;

void main() {
  group('Run', () {
    test('run1', () async {
      echo(sys_sys.timeBasedVersionString());
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
      int code = await sys_sys.runAsync$(
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
      echo(code, title: 'code');
      await sys_sys.runAsync(
        'dart pub deps --no-dev --style list | sed "/^ .*/d"',
        useBash: true,
      );
    });
    test('installBinaryToTempDir()', () {
      Uint8List bytes = dart_convert.utf8.encode('abcハロー©');
      echo(
        sys_sys.installBinaryToTempDir(bytes, prefix: 'test-', suffix: '.txt'),
      );
    });
  });
}
