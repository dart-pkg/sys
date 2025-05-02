#! /usr/bin/env my-dart

import 'package:sys/sys.dart' as sys__;

main() {
  //sys__.unzipToDirectory('test.zip', 'tmp.out3/');
  sys__.untarToDirectory('web.tar', 'tmp.tar/web');
}
