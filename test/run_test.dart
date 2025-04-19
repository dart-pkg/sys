import 'package:test/test.dart';
import 'package:output/output.dart';
import 'package:sys/sys.dart' as sys;
import 'package:path/path.dart' as path;

void main() {
  group('Run', () {
    test('run1', () {
      dump(sys.pathBaseName('abc.xyz.exe'));
      String home = sys.getenv('HOME')!;
      echo(home, 'home');
      String helloDir = path.join(home, 'dart', 'hello');
      echo(helloDir, 'helloDir');
      echo(sys.directoryExists(helloDir), 'sys.directoryExists(helloDir)');
    });
  });
}
