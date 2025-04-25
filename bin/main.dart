import 'dart:convert' as convert__;
import 'dart:io' as io__;
import 'package:archive/archive.dart' as archive__;
import 'package:std/misc.dart' as misc__;

main() async {
  final bytes = io__.File('test.zip').readAsBytesSync();
  final archive = archive__.ZipDecoder().decodeBytes(bytes);
  for (final entry in archive) {
    if (entry.isFile) {
      var fileBytes = entry.readBytes();
      fileBytes = fileBytes!;
      if (misc__.isText(fileBytes)) {
        String text = convert__.utf8.decode(fileBytes);
        text = misc__.adjustTextNewlines(text);
        fileBytes = convert__.utf8.encode(text);
      }
      io__.File('tmp.out/${entry.name}')
        ..createSync(recursive: true)
        ..writeAsBytesSync(fileBytes!.toList());
    }
  }
}
