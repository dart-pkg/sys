#! /usr/bin/env my-dart

import 'package:sys/sys.dart' as sys__;

main() {
  //sys__.unzipToDirectory('test.zip', 'tmp.out3/');
  String lines = 'aaa\nbbb\r\ncdc\n';
  print('`$lines`');
  print(sys__.textToLines(lines));
  lines = 'aaa\nbbb\r\ncdc';
  print('`$lines`');
  print(sys__.textToLines(lines));
}
