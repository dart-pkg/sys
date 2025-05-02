#! /usr/bin/env my-dart

import 'package:sys/sys.dart';

main() {
  unzipToDirectory('test.zip', 'tmp.out1/');
  unzipToDirectory(readFileBytes('test.zip'), 'tmp.out2/');
  //unzipToDirectory(123, 'tmp.out3/');
  untarToDirectory('web.tar', 'tmp.out4');
  untarToDirectory(readFileBytes('web.tar'), 'tmp.out5');
}
