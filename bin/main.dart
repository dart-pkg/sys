#! /usr/bin/env my-dart

import 'package:sys/sys.dart' as sys__;

// void unzipToDirectory(String $zipPath, String $destDir) {
//   $zipPath = sys__.pathFullName($zipPath);
//   $destDir = sys__.pathFullName($destDir);
//   final bytes = io__.File($zipPath).readAsBytesSync();
//   final archive = archive__.ZipDecoder().decodeBytes(bytes);
//   for (final entry in archive) {
//     if (entry.isFile) {
//       var fileBytes = entry.readBytes();
//       fileBytes = fileBytes!;
//       if (misc__.isText(fileBytes)) {
//         String text = convert__.utf8.decode(fileBytes);
//         text = misc__.adjustTextNewlines(text);
//         fileBytes = convert__.utf8.encode(text);
//       }
//       print('${$destDir}/${entry.name}');
//       sys__.writeFileBytes('${$destDir}/${entry.name}', fileBytes);
//     }
//   }
// }

main() {
  sys__.unzipToDirectory('test.zip', 'tmp.out3/');
}
