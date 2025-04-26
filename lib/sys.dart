import 'dart:core';
import 'dart:convert' as convert__;
import 'dart:io' as io__;
import 'dart:typed_data';
import 'package:path/path.dart' as path__;
import 'package:http/http.dart' as http__;
import 'package:std/command_runner.dart' as std__;
import 'package:std/misc.dart' as std__;
import 'package:archive/archive.dart' as archive__;

bool get isInDebugMode {
  bool inDebugMode = false;
  assert(inDebugMode = true);
  return inDebugMode;
}

String? getenv(String $name) {
  return io__.Platform.environment[$name];
}

void setCwd(String $path) {
  io__.Directory.current = pathFullName($path);
}

String getCwd() {
  return pathFullName(io__.Directory.current.absolute.path);
}

String pathFullName(String $path) {
  return path__.normalize(path__.absolute($path)).replaceAll(r'\', '/');
}

String pathDirectoryName(String $path) {
  return pathFullName(path__.dirname($path));
}

String pathFileName(String $path) {
  return path__.basename($path);
}

String pathBaseName(String $path) {
  return path__.basenameWithoutExtension($path);
}

String pathExtension(String $path) {
  return path__.extension($path);
}

List<String> _getFilesFromDirRecursive(String $path) {
  List<String> result = [];
  io__.Directory dir = io__.Directory($path);
  List<io__.FileSystemEntity> entities = dir.listSync().toList();
  for (var entity in entities) {
    if (entity is io__.File) {
      result.add(pathFullName(entity.path));
    } else if (entity is io__.Directory) {
      result.addAll(_getFilesFromDirRecursive(pathFullName(entity.path)));
    }
  }
  return result;
}

List<String> pathFiles(String $path, [bool? $recursive]) {
  try {
    $recursive ??= false;
    if ($recursive) {
      return _getFilesFromDirRecursive(
        $path,
      ).map(($x) => $x.replaceAll(r'\', r'/')).toList();
    }
    final $dir = io__.Directory(path__.join($path));
    final List<io__.FileSystemEntity> $entities = $dir.listSync().toList();
    final Iterable<io__.File> $files = $entities.whereType<io__.File>();
    List<String> result = [];
    $files.toList().forEach((x) {
      result.add(pathFullName(x.path));
    });
    return result.map(($x) => $x.replaceAll(r'\', r'/')).toList();
  } catch ($e) {
    return <String>[];
  }
}

List<String> pathDirectories(String $path) {
  try {
    final $dir = io__.Directory(path__.join($path));
    final List<io__.FileSystemEntity> $entities = $dir.listSync().toList();
    final Iterable<io__.Directory> $dirs =
        $entities.whereType<io__.Directory>();
    List<String> result = [];
    $dirs.toList().forEach((x) {
      result.add(pathFullName(x.path));
    });
    return result.map(($x) => $x.replaceAll(r'\', r'/')).toList();
  } catch ($e) {
    return <String>[];
  }
}

Uint8List readFileBytes(String $path) {
  final $file = io__.File($path);
  return $file.readAsBytesSync();
}

String readFileString(String $path) {
  final $file = io__.File($path);
  return $file.readAsStringSync();
}

List<String> readFileLines(String $path) {
  final $file = io__.File($path);
  return $file.readAsLinesSync();
}

void writeFileBytes(String $path, Uint8List $data) {
  io__.File($path)
    ..createSync(recursive: true)
    ..writeAsBytesSync($data.toList());
}

void writeFileString(String $path, String $data) {
  writeFileBytes($path, convert__.utf8.encode($data));
}

List<String> textToLines(String $s) {
  const $splitter = convert__.LineSplitter();
  final $lines = $splitter.convert($s);
  return $lines;
}

bool fileExists(String $path) {
  return io__.File($path).existsSync();
}

bool directoryExists(String $path) {
  return io__.Directory($path).existsSync();
}

Future<String?> httpGetBodyAsync(String $urlString) async {
  try {
    var url = Uri.parse($urlString);
    var response = await http__.get(url);
    if (response.statusCode != 200) {
      return null;
    }
    return response.body;
  } catch ($e) {
    return null;
  }
}

Future<dynamic> runAsync(
  String command, {
  bool returnCode = false,
  bool useBash = false,
}) async {
  final $run = std__.CommandRunner(useUnixShell: useBash);
  return $run.run(command, returnCode: returnCode);
}

Future<dynamic> runAsync$(
  List<String> command, {
  List<String>? rest,
  bool returnCode = false,
  bool useBash = false,
  bool autoQuote = true,
}) async {
  var $list = <String>[];
  rest ??= <String>[];
  $list
    ..addAll(command)
    ..addAll(rest);
  String $executable = $list[0];
  List<String> $arguments = $list.sublist(1).toList();
  final $run = std__.CommandRunner(useUnixShell: useBash);
  return $run.run$(
    $executable,
    arguments: $arguments,
    returnCode: returnCode,
    autoQuote: autoQuote,
  );
}

String _adjustVersionString(String $s) {
  List<String> $split = $s.split('.');
  List<String> $result = <String>[];
  for (int i = 0; i < $split.length; i++) {
    String $part = $split[i];
    String $part2 = '';
    bool isBeggining = true;
    for (int j = 0; j < $part.length; j++) {
      if (!isBeggining || (j == $part.length - 1)) {
        $part2 += $part[j];
      } else {
        if ($part[j] != '0') {
          $part2 += $part[j];
          isBeggining = false;
        }
      }
    }
    $result.add($part2);
  }
  return $result.join('.');
}

String lastChars(String s, int len) {
  return s.substring(s.length - len);
}

String timeBasedVersionString() {
  final now = DateTime.now();
  // final formatter1 = intl.DateFormat('yyyy.MMdd.HHmm');
  // String version = formatter1.format(now);
  String year = '${now.year}';
  String month = lastChars('0${now.month}', 2);
  String day = lastChars('0${now.day}', 2);
  String hour = lastChars('0${now.hour}', 2);
  String minute = lastChars('0${now.minute}', 2);
  String version = '$year.$month$day.$hour$minute';
  version = _adjustVersionString(version);
  return version;
}

void unzipToDirectory(String $zipPath, String $destDir) {
  $zipPath = pathFullName($zipPath);
  $destDir = pathFullName($destDir);
  final bytes = io__.File($zipPath).readAsBytesSync();
  final archive = archive__.ZipDecoder().decodeBytes(bytes);
  for (final entry in archive) {
    if (entry.isFile) {
      var fileBytes = entry.readBytes();
      fileBytes = fileBytes!;
      if (std__.isText(fileBytes)) {
        String text = convert__.utf8.decode(fileBytes);
        text = std__.adjustTextNewlines(text);
        fileBytes = convert__.utf8.encode(text);
      }
      //print('${$destDir}/${entry.name}');
      writeFileBytes('${$destDir}/${entry.name}', fileBytes);
    }
  }
}
