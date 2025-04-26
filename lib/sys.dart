import 'dart:core';
import 'dart:convert' as convert__;
import 'dart:io' as io__;
import 'dart:typed_data';
import 'package:path/path.dart' as path__;
import 'package:http/http.dart' as http__;
// import 'package:std/command_runner.dart' as std__;
// import 'package:std/misc.dart' as std__;
import 'package:std/std.dart' as std__;
import 'package:archive/archive.dart' as archive__;

bool get isInDebugMode {
  return std__.isInDebugMode;
}

String? getenv(String name) {
  return std__.getenv(name);
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

Uint8List readFileBytes(String path) {
  return std__.readFileBytes(path);
}

String readFileString(String path) {
  return std__.readFileString(path);
}

List<String> readFileLines(String path) {
  return std__.readFileLines(path);
}

void writeFileBytes(String path, Uint8List data) {
  std__.writeFileBytes(path, data);
}

void writeFileString(String path, String data) {
  std__.writeFileString(path, data);
}

List<String> textToLines(String s) {
  return std__.textToLines(s);
}

bool fileExists(String path) {
  return std__.fileExists(path);
}

bool directoryExists(String path) {
  return std__.directoryExists(path);
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
  var list = <String>[];
  rest ??= <String>[];
  list
    ..addAll(command)
    ..addAll(rest);
  // String $executable = $list[0];
  // List<String> $arguments = $list.sublist(1).toList();
  final $run = std__.CommandRunner(useUnixShell: useBash);
  return $run.run$(
    // $executable,
    // arguments: $arguments,
    list,
    returnCode: returnCode,
    autoQuote: autoQuote,
  );
}

String lastChars(String s, int len) {
  // return s.substring(s.length - len);
  return std__.lastChars(s, len);
}

String timeBasedVersionString() {
  return std__.timeBasedVersionString();
}

void unzipToDirectory(String zipPath, String destDir) {
  zipPath = pathFullName(zipPath);
  destDir = pathFullName(destDir);
  final bytes = io__.File(zipPath).readAsBytesSync();
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
      writeFileBytes('$destDir/${entry.name}', fileBytes);
    }
  }
}
